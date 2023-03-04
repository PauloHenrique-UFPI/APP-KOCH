class Noticia {
  int id;
  String titulo;
  String data;
  String img;
  String desCurta;
  String descLonga;

  Noticia({
    required this.id,
    required this.titulo,
    required this.data,
    required this.img,
    required this.desCurta,
    required this.descLonga,
  });
  factory Noticia.toMap(map) {
    return Noticia(
      id: map['id_noticia'] ?? 1,
      titulo: map['titulo'] ?? 'Não Informado',
      data: map['data'] ?? 'Não Informado',
      img: map['img'] ?? 'Não Informado',
      desCurta: map['desCurta'] ?? 'Não Informado',
      descLonga: map['descLonga'] ?? 'Não Informado',
    );
  }
}
