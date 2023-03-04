class Contato {
  int id;
  String nome;
  String email;
  String numero;
  String profissao;
  bool adm;

  Contato(
      {required this.id,
      required this.nome,
      required this.email,
      required this.numero,
      required this.profissao,
      required this.adm});

  factory Contato.toMap(map) {
    return Contato(
        id: map['id'] ?? 1,
        nome: map['nome'] ?? 'Paciente sem nome',
        email: map['email'] ??
            'Não Informado', // não temos o campo numero no bd, estou resolvendo isso hj
        numero: map[''] ?? 'Não Informado',
        profissao: map[''] ?? 'Não Informado',
        adm: map['adm'] ?? false);
  }
}
