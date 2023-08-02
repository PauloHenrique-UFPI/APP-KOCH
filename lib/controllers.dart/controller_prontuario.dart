import 'package:flutter/material.dart';
import 'package:koch_app/repositories/prontuario_repository.dart';

class ControllerProntuario extends ChangeNotifier {
  final ProntuarioRepository _repository;
  String search = "";

  late final _prontuario;
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

  ControllerProntuario({required ProntuarioRepository prontuarioRepository})
      : _repository = prontuarioRepository;

  Future<void> achar(int id) async {
    try {
      loading = true;
      _prontuario = await _repository.acharProntuario(id);
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
