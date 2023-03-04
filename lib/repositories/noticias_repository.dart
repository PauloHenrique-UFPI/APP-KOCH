import 'package:koch_app/core/rest_client/rest_client.dart';
import 'package:koch_app/models/noticias.dart';

class NoticiasRepository {
  final RestClient _rest;
  NoticiasRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Noticia>> buscarNoticia() async {
    final response = await _rest.get('/noticias');
    return response.map<Noticia>(Noticia.toMap).toList();
  }
}
