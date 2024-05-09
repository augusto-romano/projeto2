import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
//criação do arquivo pdf
Future<void> printDoc(String info) async {
  final image = await imageFromAssetBundle("assets/tabela.png");
  final doc = pw.Document();
  doc.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return buildPrintableData(
          image, info); // Passando "info" como parâmetro
    },
  ));
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}

pw.Widget buildPrintableData(pw.ImageProvider image, String info) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft, // Alinha o conteúdo à esquerda
    child: pw.Column(
      crossAxisAlignment:
          pw.CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
      children: [
        // Ajuste conforme necessário

        pw.Text(
          "FICHA ECOCARDIOGRAMA DOPPLER DE STRESS", // Texto adicional
          style: pw.TextStyle(fontSize: 18.0, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          info,
          style: pw.TextStyle(fontSize: 20.0, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10.0),
        pw.Expanded(
          child: pw.Container(
            alignment: pw
                .Alignment.bottomCenter, // Alinha a imagem na parte inferior
            child: pw.Image(
              image,
              width: 500, // Largura da imagem
              height: 250, // Altura da imagem (ajuste conforme necessário)
              fit: pw.BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}
