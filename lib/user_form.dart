import 'package:flutter/material.dart';
import 'package:teste/pdf_creator.dart';

//Arquivo responsavel pelo formulario e validação
class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;
  String? _medico;
  String? _telefone;
  String? _convenio;
  String? _fcMinima;
  String? _fcMaxima;
  String? _medicacao;
  String? _examesJaRealizados;
  String? _queixaAtual;
  String? _peso;
  bool _glaucoma = false;
  bool _prostata = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'NOME'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor digite um nome valido';
              }
              return null;
            },
            onSaved: (value) => _name = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'IDADE'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || int.tryParse(value) == null) {
                return 'Porfavor digite uma idade valida';
              }
              return null;
            },
            onSaved: (value) => _age = int.tryParse(value!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'NOME MÉDICO'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor digite um nome de medico valido';
              }
              return null;
            },
            onSaved: (value) => _medico = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'TELEFONE'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || int.tryParse(value) == null) {
                return 'Porfavor digite um telefone valido';
              }
              return null;
            },
            onSaved: (value) => _telefone = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'CONVÊNIO'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor digite um convenio valido';
              }
              return null;
            },
            onSaved: (value) => _convenio = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'EXAMES REALIZADOS'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor digite um nome de exame valido';
              }
              return null;
            },
            onSaved: (value) => _examesJaRealizados = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'MEDICAÇÃO'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor digite o nome do medicamento';
              }
              return null;
            },
            onSaved: (value) => _medicacao = value,
          ),
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
            title: const Text('PROBLEMAS DE PROSTATA?'),
            value: _prostata,
            onChanged: (value) {
              setState(() {
                _prostata = value!;
              });
            },
          ),
          TextButton(
            onPressed: () {
              // Add a funçao aqui
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!
                    .save(); // Salva os valores dos campos de texto

                // criaçao da variavel para exibir todas de uma vez no alert
                String glaucomaText = _glaucoma ? 'Sim' : 'Não';
                String prostataText = _prostata ? 'Sim' : 'Não';
                String info = '''
                Nome: $_name \n
                Idade: $_age \n
                Médico: $_medico\n
                Telefone: $_telefone\n
                Convênio: $_convenio\n
                Exames Realizados: $_examesJaRealizados\n
                Medicação: $_medicacao\n
                Possui Glaucoma: $glaucomaText\n
                Problemas de Próstata: $prostataText
              ''';

                //exibir o alert
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('CONFIRA AS INFORMAÇÕES'),
                      content: Text(info), // Usa o valor de _examesJaRealizados
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),

                        //botao dentro do alert para gerar o arquivo pdf
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
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(180, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text('ENVIAR'),
          ),
        ],
      ),
    );
  }
}
