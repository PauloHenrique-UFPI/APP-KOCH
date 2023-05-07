import 'package:flutter/material.dart';
import '../models/contatos.dart';
import '../repositories/contatos_repository.dart';
class Controllercontato extends ChangeNotifier {
  final ContatoRepository _repository;
  String search = "";

  var _contatos = <Contato>[];
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

  Controllercontato({required ContatoRepository contatoRepository})
      : _repository = contatoRepository;

  List<Contato> get contatos {
    return _contatos
        .where((e) => e.nome.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> buscarcontato() async {
    try {
      loading = true;
      _contatos = await _repository.buscarContatos();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
