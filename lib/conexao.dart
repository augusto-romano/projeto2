// conexao.dart
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste/form_data.dart';

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

  Future<int> insertForm(FormData formData) async {
    final db = await instance.database;
    return await db.insert(
      table,
      formData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FormData>> getForms() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return FormData(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        idade: maps[i]['idade'],
        medico: maps[i]['medico'],
        telefone: maps[i]['telefone'],
        convenio: maps[i]['convenio'],
        exames: maps[i]['exames'],
        medicacao: maps[i]['medicacao'],
        glaucoma: maps[i]['glaucoma'] == 1,
        prostata: maps[i]['prostata'] == 1,
      );
    });
  }

  Future<int> updateForm(FormData formData) async {
    final db = await instance.database;
    return await db.update(
      table,
      formData.toMap(),
      where: '$columnId = ?',
      whereArgs: [formData.id],
    );
  }

  Future<int> deleteForm(int id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
