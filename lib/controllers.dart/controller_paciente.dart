import 'package:flutter/material.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/repositories/paciente_repository.dart';

class ControllerPaciente extends ChangeNotifier {
  final PacienteRepository _repository;
  String search = "";

  var _pacientes = <Paciente>[];
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

  ControllerPaciente({required PacienteRepository pacienteRepository})
      : _repository = pacienteRepository;

  List<Paciente> get pacientes {
    return _pacientes
        .where((e) => e.nome.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> buscarPacientes() async {
    try {
      loading = true;
      _pacientes = await _repository.buscarPacientes();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
