import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/models/noticias.dart';

class NoticiasRepository {
  final RestClient _rest;
  NoticiasRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Noticia>> buscarNoticia(String a) async {
    final response = await _rest.get('/noticias');
    return response["groups"].map<Noticia>(Noticia.toMap).toList();
  }
}
