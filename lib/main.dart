import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:teste/login_page.dart';
import 'user_form.dart';
import 'pdf_creator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/tela2',
      routes: {
        '/tela1': (context) =>
            Material(child: UserForm()), // Envolver UserForm com Material
        '/tela2': (context) => LoginPage(),
      },
    );
  }
}
