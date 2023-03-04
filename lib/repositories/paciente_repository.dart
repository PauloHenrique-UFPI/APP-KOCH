import 'package:koch_app/core/rest_client/rest_client.dart';
import 'package:koch_app/models/paciente.dart';

class PacienteRepository {
  final RestClient _rest;
  PacienteRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Paciente>> buscarPacientes() async {
    final response = await _rest.get('/paciente');
    return response.map<Paciente>(Paciente.toMap).toList();
  }
}
