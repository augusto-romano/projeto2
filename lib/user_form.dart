// user_form.dart
import 'package:flutter/material.dart';
import 'package:teste/conexao.dart';
import 'package:teste/historico_screen.dart';
import 'package:teste/pdf_creator.dart';
import 'package:teste/form_data.dart'; // Importa a classe FormData

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _medicoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _convenioController = TextEditingController();
  final TextEditingController _examesController = TextEditingController();
  final TextEditingController _medicacaoController = TextEditingController();

  bool _glaucoma = false;
  bool _prostata = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FICHA ECOCARDIOGRAMA'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'NOME'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um nome válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'IDADE'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Por favor, digite uma idade válida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _medicoController,
                  decoration: InputDecoration(labelText: 'NOME MÉDICO'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um nome de médico válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _telefoneController,
                  decoration: InputDecoration(labelText: 'TELEFONE'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Por favor, digite um telefone válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _convenioController,
                  decoration: InputDecoration(labelText: 'CONVÊNIO'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um convênio válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _examesController,
                  decoration: InputDecoration(labelText: 'EXAMES REALIZADOS'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite um nome de exame válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _medicacaoController,
                  decoration: InputDecoration(labelText: 'MEDICAÇÃO'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome do medicamento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('POSSUI GLAUCOMA?'),
                  value: _glaucoma,
                  onChanged: (value) {
                    setState(() {
                      _glaucoma = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('PROBLEMAS DE PRÓSTATA?'),
                  value: _prostata,
                  onChanged: (value) {
                    setState(() {
                      _prostata = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Criar um objeto FormData
                      FormData formData = FormData(
                        nome: _nameController.text,
                        idade: _ageController.text,
                        medico: _medicoController.text,
                        telefone: _telefoneController.text,
                        convenio: _convenioController.text,
                        exames: _examesController.text,
                        medicacao: _medicacaoController.text,
                        glaucoma: _glaucoma,
                        prostata: _prostata,
                      );

                      // Inserir no banco de dados
                      await Conexao.instance.insertForm(formData);

                      // Mostrar diálogo de confirmação
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('CONFIRA AS INFORMAÇÕES'),
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
                              TextButton(
                                child: const Text('SALVAR PDF'),
                                onPressed: () => printDoc(
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
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('ENVIAR'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoricoScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(180, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'VER HISTÓRICO',
                    style: TextStyle(color: Color.fromARGB(255, 252, 4, 4)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
