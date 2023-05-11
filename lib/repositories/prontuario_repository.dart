import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/models/prontuario.dart';

class ProntuarioRepository {
  final RestClient _rest;
  ProntuarioRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Prontuario>> buscarProntuario() async {
    final response = await _rest.get('/prontuarios');
    return response["groups"].map<Prontuario>(Prontuario).toList();
  }

  Future<Prontuario> achar(String id) async {
    final response = await _rest.post('/prontuarioPaciente', {"id": id});
    return Prontuario.fromJson(response);
  }
}
