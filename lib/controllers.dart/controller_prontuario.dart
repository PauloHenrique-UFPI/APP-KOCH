import 'package:flutter/material.dart';
import 'package:koch_app/models/prontuario.dart';
import 'package:koch_app/repositories/prontuario_repository.dart';

class ControllerProntuario extends ChangeNotifier {
  final ProntuarioRepository _repository;
  String search = "";

  late final Prontuario _prontuario;
  bool loading = false;

  ControllerProntuario({required ProntuarioRepository prontuarioRepository})
      : _repository = prontuarioRepository;

  Future<void> achar(int id) async {
    try {
      loading = true;
      (await _repository.acharProntuario(id));
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
