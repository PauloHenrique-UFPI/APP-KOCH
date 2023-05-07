import 'package:koch_app/core/rest_client/rest_client.dart';
import 'package:koch_app/models/contatos.dart';

class ContatoRepository {
  final RestClient _rest;
  ContatoRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Contato>> buscarContatos() async {
    final response = await _rest.get('/contatos');
    return response["groups"].map<Contato>(Contato.toMap).toList();
  }
}
