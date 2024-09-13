import 'dart:convert';  // Import for base64 decoding
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';  // Import the PDF viewer
import 'package:path_provider/path_provider.dart';
import 'package:ttfrontend/modules/widgets/custom_popup.dart';
import 'package:ttfrontend/service/api_service.dart';
import 'package:ttfrontend/service/models/graphql_query.dart';

Future<void> fetchAndSavePdf(String month, String headerColor, BuildContext context) async {
  const String query = r'''
    query GeneratePdf($month: String!, $header_color: HeaderColor!) {
      generatePdf(month: $month, headerColor: $header_color)
    }
  ''';

  // Format headerColor from baumarktRot to BAUMARKT_ROT to match the enum value
  String formattedHeaderColor = headerColor.replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}').toUpperCase();
  formattedHeaderColor = formattedHeaderColor.replaceFirst('_', '');

  try {
    ApiService apiService = ApiService();
    GraphQLQuery graphQLQuery = GraphQLQuery(
      query: query,
      variables: {
        'month': month,
        'header_color': formattedHeaderColor,  // Pass enum value correctly
      },
    );

    final response = await apiService.graphQLRequest(graphQLQuery);

    final base64Pdf = response.data?['data']?['generatePdf'];  // Access the correct path in the response

    if (base64Pdf != null) {
      // Decode the Base64 string to get the binary data
      final pdfBytes = base64Decode(base64Pdf);

      // Get the directory to save the file in the Downloads folder
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception("Could not access the Downloads directory.");
      }

      final filePath = '${directory.path}/downloaded_file.pdf';

      // Save the PDF file
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      print('PDF saved to $filePath');

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
      GenericPopup.showErrorPopup(context, 'Es gab ein Problem beim Herunterladen der PDF-Datei.');
    }
  }
}

// A separate widget to view the PDF
class PdfViewerPage extends StatelessWidget {
  final String filePath;

  const PdfViewerPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monatsübersicht'),
      ),
      body: PDFView(
        filePath: filePath,
        autoSpacing: false,
      ),
    );
  }
}
