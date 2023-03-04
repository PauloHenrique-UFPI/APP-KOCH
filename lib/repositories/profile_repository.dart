import 'package:koch_app/core/rest_client/rest_client.dart';
import 'package:koch_app/models/profile.dart';

class ProfileRepository {
  final RestClient _rest;
  ProfileRepository({required RestClient restClient}) : _rest = restClient;

  Future<List<Profile>> buscarProfile() async {
    final response = await _rest.get('/users');
    return response.map<Profile>(Profile.toMap).toList();
  }
}
