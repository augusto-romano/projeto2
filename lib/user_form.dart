import 'package:flutter/material.dart';
import 'package:teste/pdf_creator.dart';

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

  String? _queixaAtual;
  String? _peso;
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      String glaucomaText = _glaucoma ? 'Sim' : 'Não';
                      String prostataText = _prostata ? 'Sim' : 'Não';
                      String info = '''
                        Nome: ${_nameController.text}
                        Idade: ${_ageController.text}
                        Médico: ${_medicoController.text}
                        Telefone: ${_telefoneController.text}
                        Convênio: ${_convenioController.text}
                        Exames Realizados: ${_examesController.text}
                        Medicação: ${_medicacaoController.text}
                        Possui Glaucoma: $glaucomaText
                        Problemas de Próstata: $prostataText
                      ''';
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('CONFIRA AS INFORMAÇÕES'),
                            content: Text(info),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('SALVAR PDF'),
                                onPressed: () => printDoc(info),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
