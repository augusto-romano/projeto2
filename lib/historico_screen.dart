// historico_screen.dart
import 'package:flutter/material.dart';
import 'conexao.dart';
import 'form_data.dart'; // Importa a classe FormData

class HistoricoScreen extends StatefulWidget {
  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  late Future<List<FormData>> _futureForms;

  @override
  void initState() {
    super.initState();
    _futureForms = Conexao.instance.getAllForms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Pacientes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: FutureBuilder<List<FormData>>(
          future: _futureForms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum dado encontrado.'));
            } else {
              final forms = snapshot.data!;
              return ListView.builder(
                itemCount: forms.length,
                itemBuilder: (context, index) {
                  final form = forms[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 5,
                    child: ListTile(
                      title: Text(form.nome),
                      onTap: () {
                        _showPatientDetails(context, form);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _showPatientDetails(BuildContext context, FormData form) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes do Paciente'),
          content: Text(
            'Nome: ${form.nome}\n'
            'Idade: ${form.idade}\n'
            'Médico: ${form.medico}\n'
            'Telefone: ${form.telefone}\n'
            'Convênio: ${form.convenio}\n'
            'Exames: ${form.exames}\n'
            'Medicação: ${form.medicacao}\n'
            'Glaucoma: ${form.glaucoma ? "Sim" : "Não"}\n'
            'Próstata: ${form.prostata ? "Sim" : "Não"}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
