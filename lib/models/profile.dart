class Profile {
  int id;
  String? profilePictureP;
  String nomeP;
  String? numeroP;
  String profissaoP;
  String emailP;

  Profile({
    required this.id,
    this.profilePictureP,
    required this.nomeP,
    this.numeroP,
    required this.profissaoP,
    required this.emailP,
  });

  factory Profile.toMap(map) {
    return Profile(
      id: map['id'] ?? 1,
      profilePictureP: map['profilePictureP'] ?? "Não Informado",
      nomeP: map['nomeP'] ?? "Não Informado",
      numeroP: map['numeroP'] ?? "Não Informado",
      emailP: map['emailP'] ?? "Não Informado",
      profissaoP: map['profissaoP'] ?? "Não Informado",
    );
  }
}
