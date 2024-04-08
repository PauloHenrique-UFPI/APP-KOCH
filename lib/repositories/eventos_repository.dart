import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/models/eventos.dart';

class EventoRepository {
  final RestClient _rest;
  EventoRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Evento>> buscarEvento() async {
    final response = await _rest.get('/eventos/30');
    return response["groups"].map<Evento>(Evento.toMap).toList();
  }
}
