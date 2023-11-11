class Evento {
  String titulo;
  DateTime data;
  int? id;

  Evento({
    required this.titulo,
    required this.data,
    this.id,
  });

  factory Evento.toMap(map) {
    return Evento(
        titulo: map['titulo'] ?? 'Não Informado',
        data: map['data'] ?? DateTime.now(),
        id: map['id']);
  }
}
