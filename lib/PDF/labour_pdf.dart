import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Labourpdf extends StatelessWidget {
  const Labourpdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.hindRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text("Shop Name"),
              pw.Text("KRISHNA NAGAR, SATNA"),
              pw.Text("Ph. 07672-251116, 403759"),
              pw.Text("WHATSAPP NO:- 7000923360"),
              pw.Text("STATE NAME: MADHYA PRADESH, CODE: 23"),
              pw.Text("E-MAIL : abhaybook1982@gmail.com"),
              pw.Text("POS BILL"),
              pw.Text("Date: ${DateTime.now()}"),
              pw.Text("काजू", style: pw.TextStyle(font: font)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
