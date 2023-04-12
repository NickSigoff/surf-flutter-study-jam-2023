import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfPage extends StatelessWidget {
  final String path;

  const PdfPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
      document: PdfDocument.openFile(path),
    );
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
