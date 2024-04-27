import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:teste/login_page.dart';
import 'user_form.dart';
import 'pdf_creator.dart'; // Importando os arquivos necessários

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/user_form': (context) =>
            UserForm(), // Defina a rota para a tela UserForm
      },
      home: LoginPage(),
    );
  }
}
