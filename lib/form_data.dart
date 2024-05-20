// form_data.dart
class FormData {
  final int? id;
  final String nome;
  final String idade;
  final String medico;
  final String telefone;
  final String convenio;
  final String exames;
  final String medicacao;
  final bool glaucoma;
  final bool prostata;

  FormData({
    this.id,
    required this.nome,
    required this.idade,
    required this.medico,
    required this.telefone,
    required this.convenio,
    required this.exames,
    required this.medicacao,
    required this.glaucoma,
    required this.prostata,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'medico': medico,
      'telefone': telefone,
      'convenio': convenio,
      'exames': exames,
      'medicacao': medicacao,
      'glaucoma': glaucoma ? 1 : 0,
      'prostata': prostata ? 1 : 0,
    };
  }
}
