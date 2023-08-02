import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/models/prontuario.dart';

class ProntuarioRepository {
  final RestClient _rest;
  ProntuarioRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Prontuario>> buscarProntuario() async {
    final response = await _rest.get('/prontuarios');
    return response["groups"].map<Prontuario>(Prontuario).toList();
  }

  Future<Prontuario> achar(int id) async {
    final response = await _rest.post('/prontuarioId/', {"id": id});
    print(id);
    return Prontuario.fromJson(response);
  }
}
