// user_form.dart
import 'package:flutter/material.dart';
import 'package:teste/conexao.dart';
import 'package:teste/form_data.dart';
import 'package:teste/historico_screen.dart';
import 'package:teste/pdf_creator.dart';

class UserForm extends StatefulWidget {
  final FormData? formData;

  UserForm({this.formData});

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
  void initState() {
    super.initState();
    if (widget.formData != null) {
      _nameController.text = widget.formData!.nome;
      _ageController.text = widget.formData!.idade;
      _medicoController.text = widget.formData!.medico;
      _telefoneController.text = widget.formData!.telefone;
      _convenioController.text = widget.formData!.convenio;
      _examesController.text = widget.formData!.exames;
      _medicacaoController.text = widget.formData!.medicacao;
      _glaucoma = widget.formData!.glaucoma;
      _prostata = widget.formData!.prostata;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.formData == null ? 'Adicionar Paciente' : 'Editar Paciente'),
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
                      String glaucomaText = _glaucoma ? 'Sim' : 'Não';
                      String prostataText = _prostata ? 'Sim' : 'Não';

                      // Criar um objeto FormData
                      FormData formData = FormData(
                        id: widget.formData?.id,
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

                      // Inserir ou atualizar no banco de dados
                      if (widget.formData == null) {
                        await Conexao.instance.insertForm(formData);
                      } else {
                        await Conexao.instance.updateForm(formData);
                      }

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
                              'Possui glaucoma? $glaucomaText\n'
                              'Problemas de próstata? $prostataText',
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
                                onPressed: () => printDoc(formData.toString()),
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
                  child: Text(widget.formData == null ? 'ENVIAR' : 'ATUALIZAR'),
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
                    backgroundColor: const Color.fromARGB(
                        255, 255, 255, 255), // Cor de fundo
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Espaçamento interno
                  ),
                  child: Text(
                    'VER HISTÓRICO',
                    style: TextStyle(
                        color: Color.fromARGB(255, 252, 4, 4)), // Cor do texto
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
