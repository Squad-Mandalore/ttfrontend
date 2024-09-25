import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  bool hasPermission = await requestStoragePermission(context);
  if (!hasPermission) {
    throw Exception("Fehlende Berechtigungen um auf den Speicher zuzugreifen");
  }
  if (kIsWeb) {
    // Web doesn't support file system access in the same way
    return null;
  }

  if (Platform.isAndroid || Platform.isIOS) {
    // For mobile platforms, use external storage or documents directory
    return await getExternalStorageDirectory();
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // For desktop platforms, use downloads directory
    return await getDownloadsDirectory();
  }

  return null;
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
        'header_color': formattedHeaderColor, // Pass enum value correctly
      },
    );

    final response = await apiService.graphQLRequest(graphQLQuery);

    final base64Pdf = response
        .data?['generatePdf']; // Access the correct path in the response

    if (base64Pdf != null) {
      // Decode the Base64 string to get the binary data
      final pdfBytes = base64Decode(base64Pdf);
      
      // Get the directory to save the file in the Downloads folder
      final directory = await getAppropriateDirectory(context);
      if (directory == null) {
        throw Exception("Downloads-Ordner konnte nicht geöffnet werden.");
      }

      final filePath = '${directory.path}/monatsbericht_$month.pdf';

      // Save the PDF file
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      print('PDF saved to $filePath');
      bool exists = await file.exists();
      print('File exists: $exists');

      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final formattedDateTime =
          '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      await prefs.setString('lastPdfRequest', formattedDateTime);

      // Show the PDF file using a PDF viewer
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(filePath: filePath),
          ),
        );
      }
    } else {
      throw Exception('No PDF data returned from GraphQL query.');
    }
  } catch (e) {
    print('Failed to fetch PDF: $e');
    if (context.mounted) {
      GenericPopup.showErrorPopup(
          context, 'Es gab ein Problem beim Herunterladen der PDF-Datei.');
    }
  }
}

class PdfViewerPage extends StatefulWidget {
  final String filePath;

  const PdfViewerPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monatsbericht'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              try {
                final file = File(widget.filePath);
                final bytes = await file.readAsBytes();

                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => bytes,
                  name: 'My Document',
                  format: PdfPageFormat.a4,
                  // You can add more options here
                );
              } catch (e) {
                print('Error printing PDF: $e');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Fehler beim Drucken der PDF.')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: PDFView(
        filePath: widget.filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          print(error.toString());
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fehler beim Anzeigen der PDF.')),
            );
          }
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fehler beim Anzeigen der PDF.')),
            );
          }
        },
      ),
    );
  }
}
