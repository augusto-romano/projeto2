// historico_screen.dart
import 'package:flutter/material.dart';
import 'package:teste/conexao.dart';
import 'package:teste/form_data.dart';
import 'user_form.dart';

class HistoricoScreen extends StatefulWidget {
  @override
  _HistoricoScreenState createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  late Future<List<FormData>> _forms;

  @override
  void initState() {
    super.initState();
    _refreshForms();
  }

  void _refreshForms() {
    setState(() {
      _forms = Conexao.instance.getForms();
    });
  }

  void _editForm(FormData formData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserForm(formData: formData),
      ),
    ).then((value) => _refreshForms());
  }

  void _deleteForm(int id) async {
    await Conexao.instance.deleteForm(id);
    _refreshForms();
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
          future: _forms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum paciente encontrado'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final formData = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 5,
                    child: ListTile(
                      title: Text(formData.nome),
                      subtitle: Text('Idade: ${formData.idade}, Médico: ${formData.medico}'),
                      onTap: () {
                        _showPatientDetails(context, formData);
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editForm(formData),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteForm(formData.id!),
                          ),
                        ],
                      ),
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

  void _showPatientDetails(BuildContext context, FormData formData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes do Paciente'),
          content: Text(
            'Nome: ${formData.nome}\n'
            'Idade: ${formData.idade}\n'
            'Médico: ${formData.medico}\n'
            'Telefone: ${formData.telefone}\n'
            'Convênio: ${formData.convenio}\n'
            'Exames: ${formData.exames}\n'
            'Medicação: ${formData.medicacao}\n'
            'Possui glaucoma? ${formData.glaucoma ? "Sim" : "Não"}\n'
            'Problemas de próstata? ${formData.prostata ? "Sim" : "Não"}',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
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
