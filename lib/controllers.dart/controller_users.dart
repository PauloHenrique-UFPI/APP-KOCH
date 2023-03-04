import 'package:flutter/material.dart';
import 'package:koch_app/models/profile.dart';
import 'package:koch_app/repositories/profile_repository.dart';

class ControllerProfile extends ChangeNotifier {
  final ProfileRepository _repository;
  String search = "";

  var _profiles = <Profile>[];
  bool loading = false;
  bool searshing = false;

  void changeSearch(String key) {
    search = key;
    notifyListeners();
  }

  void changeSearshing() {
    searshing = !searshing;
    if (!searshing) search = "";
    notifyListeners();
  }

  ControllerProfile({required ProfileRepository usersRepository})
      : _repository = usersRepository;

  List<Profile> get profiles {
    return _profiles
        .where((e) => e.nomeP.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> buscarProfile() async {
    try {
      loading = true;
      _profiles = await _repository.buscarProfile();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
