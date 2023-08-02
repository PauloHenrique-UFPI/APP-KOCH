import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/models/prontuario.dart';
import 'package:result_dart/result_dart.dart';

class ProntuarioRepository {
  final RestClient _rest;
  ProntuarioRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Prontuario>> buscarProntuario() async {
    final response = await _rest.get('/prontuarios');
    return response["groups"].map<Prontuario>(Prontuario).toList();
  }

  AsyncResult<Prontuario, Exception> acharProntuario(int id) async {
    try {
      final response = await _rest.get('/prontuarioId/$id');
      return Prontuario.fromJson(response).toSuccess();
    } catch (e) {
      return Exception('Erro eo carregar prontuario').toFailure();
    }
  }
}
