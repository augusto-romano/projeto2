import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

//Criação e configuração da pagina do arquivo pdf
buildPrintableData(image, info) => pw.Padding(
      padding: const pw.EdgeInsets.all(25.00),
      child: pw.Column(children: [
        pw.Text("vijaycreations",
            style:
                pw.TextStyle(fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10.00),
        pw.Divider(),
        pw.Align(
          alignment: pw.Alignment.topLeft,
          child: pw.Image(
            image,
            width: 250,
            height: 250,
          ),
        ),
      ]),
    );
