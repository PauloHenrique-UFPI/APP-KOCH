class Contato {
  int id;
  String nome;
  String email;
  String numero;

  Contato({
    required this.id,
    required this.nome,
    required this.email,
    required this.numero,
  });

  factory Contato.toMap(map) {
    return Contato(
        id: map['id'] ?? 1,
        nome: map['name'] ?? 'Não Informado',
        email: map['email'] ??
            'Não Informado', // não temos o campo numero no bd, estou resolvendo isso hj
        numero: map['number'] ?? 'Não Informado');
  }
}
