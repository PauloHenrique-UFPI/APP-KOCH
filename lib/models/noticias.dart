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
      id: map['id'] ?? 1,
      titulo: map['titulo'] ?? 'Não Informado',
      data: map['created_at'] ?? 'Não Informado',
      img: map['img'] ??
          'https://cdn-icons-png.flaticon.com/512/5110/5110429.png',
      desCurta: map['desc_curta'] ?? 'Não Informado',
      descLonga: map['desc_longa'] ?? 'Não Informado',
    );
  }
}
