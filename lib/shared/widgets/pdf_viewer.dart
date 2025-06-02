import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';

class PDFMemoryViewer extends StatefulWidget {
  final Uint8List pdfData;

  const PDFMemoryViewer({super.key, required this.pdfData});

  @override
  State<PDFMemoryViewer> createState() => _PDFMemoryViewerState();
}

class _PDFMemoryViewerState extends State<PDFMemoryViewer> {
  late PdfViewerController _pdfController;
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
  }

  void _printPdf() async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => widget.pdfData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printPdf,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_currentPage > 1) {
                _currentPage--;
                _pdfController.jumpToPage(_currentPage);
                setState(() {});
              }
            },
          ),
          Center(child: Text(" $_currentPage / $_totalPages  ")),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (_currentPage < _totalPages) {
                _currentPage++;
                _pdfController.jumpToPage(_currentPage);
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: SfPdfViewer.memory(
        widget.pdfData,
        controller: _pdfController,
        onDocumentLoaded: (details) {
          setState(() {
            _totalPages = details.document.pages.count;
          });
        },
        onPageChanged: (details) {
          setState(() {
            _currentPage = details.newPageNumber;
          });
        },
      ),
    );
  }
}
