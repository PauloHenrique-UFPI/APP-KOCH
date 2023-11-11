class Contato {
  String nome;
  String numero;
  String? descricao;

  Contato({
    required this.nome,
    required this.numero,
    this.descricao,
  });

  factory Contato.toMap(map) {
    return Contato(
        descricao: map['desc'],
        nome: map['name'] ?? 'Não Informado',
        numero: map['number'] ?? 'Não Informado');
  }
}


