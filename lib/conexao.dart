import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste/user_form.dart';

class Conexao {
  static const _dbname = "hospital.db";
  static const _sqlScript =
      'CREATE TABLE form(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, idade TEXT, medico TEXT, telefone TEXT, convenio TEXT, exames TEXT, medicacao TEXT, glaucoma BOOLEAN, prostata BOOLEAN)';

  static const table = 'form';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnIdade = 'idade';
  static const columnNome_Medico = 'medico';
  static const columnTelefone = 'telefone';
  static const columnConvenio = 'convenio';
  static const columnExames = 'exames';
  static const columnMedicacao = 'medicacao';
  static const columnGlaucoma = 'glaucoma';
  static const columnProstata = 'prostata';

  Conexao.privateConstructor();
  static final Conexao instance = Conexao.privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) {
        return db.execute(_sqlScript);
      },
      version: 1,
    );
  }

  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) {
        return db.execute(_sqlScript);
      },
      version: 1,
    );
  }

  insertForm(FormData formData) {}
}

Future<void> insertForm(FormData formData) async {
  var instance;
  final Database db = await instance.database;
  await db.insert(
    Conexao.table,
    formData.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
