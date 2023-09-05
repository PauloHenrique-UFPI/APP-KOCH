class User {
  int id;
  String nome;
  String email;
  String? profileImage;

  User({
    required this.id,
    required this.nome,
    required this.email,
    this.profileImage,
  });
  factory User.toMap(map) {
    return User(
      id: map['id'] ?? 1,
      nome: map['nome'] ?? "Não Informado",
      email: map['email'] ?? "Não Informado",
      profileImage: map['profileImage'] ?? "Não Informado",
    );
  }
}
