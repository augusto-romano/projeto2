// conexao.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'form_data.dart'; // Importa a classe FormData

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

  Future<void> insertForm(FormData formData) async {
    final db = await database;
    await db.insert(
      table,
      formData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FormData>> getAllForms() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return FormData(
        id: maps[i][columnId],
        nome: maps[i][columnNome],
        idade: maps[i][columnIdade],
        medico: maps[i][columnNome_Medico],
        telefone: maps[i][columnTelefone],
        convenio: maps[i][columnConvenio],
        exames: maps[i][columnExames],
        medicacao: maps[i][columnMedicacao],
        glaucoma: maps[i][columnGlaucoma] == 1,
        prostata: maps[i][columnProstata] == 1,
      );
    });
  }
}
