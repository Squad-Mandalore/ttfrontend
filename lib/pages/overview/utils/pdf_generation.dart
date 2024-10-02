import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:path_provider/path_provider.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

Future<bool> requestStoragePermission(BuildContext context) async {
  if (Platform.isAndroid) {
    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    } else if (context.mounted) {
      if (await Permission.manageExternalStorage.isGranted) {
      Permission.manageExternalStorage.request();
        return true;
      }
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return GenericPopup(
            title: 'Rechte zum Dateizugriff benötigt',
            agreeText: 'Einstellungen Öffnen',
            content: const Column(
              children: [
          SizedBox(height: 16.0),
          Text(
              'Diese App benötigt die Erlaubnis um die angeforderte PDF abzuspeichern. Bitte erlaube den Zugriff auf die Dateien in den Einstellungen.'),
          SizedBox(height: 16.0),
              ],
            ),
            mode: PopUpMode.warning,
            onAgree: () {
              Navigator.of(context).pop(true);
              openAppSettings();
            },
            onDisagree: () {
              Navigator.of(context).pop(false);
            },
          );
        },
      );

      return await Permission.manageExternalStorage.isGranted;
    }
    else {
      Permission.manageExternalStorage.request();
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }
      return false;
    }
  } else {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }
}

Future<Directory?> getAppropriateDirectory(BuildContext context) async {
  // Try to get a directory without requiring permissions
  Directory? directory;

  if (kIsWeb || Platform.isIOS) {
    // Web and iOS may not support file system access
    return null;
  }

  if (Platform.isAndroid) {
    // Use application documents directory
    directory = await getExternalStorageDirectory();
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // For desktop platforms, use downloads directory
    directory = await getDownloadsDirectory();
  }

  // If directory is null or inaccessible, fallback to temporary directory
  directory ??= await getTemporaryDirectory();

  return directory;
}


Future<void> fetchAndSavePdf(
    String month, String headerColor, BuildContext context) async {
  const String query = r'''
    query GeneratePdf($month: String!, $header_color: HeaderColor!) {
      generatePdf(month: $month, headerColor: $header_color)
    }
  ''';

  // Format headerColor from baumarktRot to BAUMARKT_ROT to match the enum value
  String formattedHeaderColor = headerColor
      .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
      .toUpperCase();
  formattedHeaderColor = formattedHeaderColor.replaceFirst('_', '');

  try {
    ApiService apiService = ApiService();
    GraphQLQuery graphQLQuery = GraphQLQuery(
      query: query,
      variables: {
        'month': month,
        'header_color': formattedHeaderColor,
      },
    );

    final response = await apiService.graphQLRequest(graphQLQuery);

    final base64Pdf = response.data?['generatePdf'];

    if (base64Pdf != null) {
      // Decode the Base64 string to get the binary data
      final pdfBytes = base64Decode(base64Pdf);

      bool saveSuccess = false;
      String? filePath;

      try {
        // Try to get the directory to save the file
        final directory = await getAppropriateDirectory(context);
        if (directory == null) {
          throw Exception("Downloads-Ordner konnte nicht geöffnet werden.");
        }

        filePath = '${directory.path}/monatsbericht_$month.pdf';

        // Save the PDF file
        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);

        final prefs = await SharedPreferences.getInstance();
        final now = DateTime.now();
        final formattedDateTime =
            '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
        await prefs.setString('lastPdfRequest', formattedDateTime);

        saveSuccess = true;
      } catch (e) {
        // Saving failed, proceed to display the PDF from bytes
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Speichern fehlgeschlagen: $e')),
          );
        }
      }

      // Show the PDF file using a PDF viewer
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(
              pdfBytes: pdfBytes,
              filePath: saveSuccess ? filePath : null,
            ),
          ),
        );
      }
    } else {
      throw Exception('No PDF data returned from GraphQL query.');
    }
  } catch (e) {
    print('Failed to fetch and save PDF: $e');
    if (context.mounted) {
      GenericPopup.showErrorPopup(
          context, 'Es gab ein Problem beim Herunterladen der PDF-Datei.');
    }
  }
}

class PdfViewerPage extends StatefulWidget {
  final Uint8List pdfBytes;
  final String? filePath; // Optional, in case the file was saved successfully

  const PdfViewerPage({super.key, required this.pdfBytes, this.filePath});

  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends State<PdfViewerPage> {
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: pdfx.PdfDocument.openData(widget.pdfBytes),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  Future<void> _printPdf() async {
    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => widget.pdfBytes,
        name: 'Monatsbericht${DateTime.now().toIso8601String()}.pdf',
        format: PdfPageFormat.a4,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fehler beim Drucken der PDF.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monatsbericht'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printPdf,
          ),
        ],
      ),
      body: PdfViewPinch(
        controller: _pdfController,
      ),
    );
  }
}