import 'package:koch_app/core/rest_client/rest_client.dart';
import 'package:koch_app/models/contatos.dart';

class ContatoRepository {
  final RestClient _rest;
  ContatoRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Contato>> buscarContatos() async {
    final response = await _rest.get('/users');
    return response.map<Contato>(Contato.toMap).toList();
  }
}
