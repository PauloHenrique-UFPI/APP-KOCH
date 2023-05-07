import 'package:flutter/material.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/repositories/noticias_repository.dart';

class ControllerNoticias extends ChangeNotifier {
  final NoticiasRepository _repository;
  String search = "";

  var _noticias = <Noticia>[];
  bool loading = false;
  bool searching = false;

  void changeSearch(String key) {
    search = key;
    notifyListeners();
  }

  void changeSearching() {
    searching = !searching;
    if (!searching) search = "";
    notifyListeners();
  }

  ControllerNoticias({required NoticiasRepository noticiasRepository})
      : _repository = noticiasRepository;

  List<Noticia> get noticias {
    return _noticias
        .where((e) => e.titulo.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<void> buscarNoticia() async {
    try {
      loading = true;
      _noticias = await _repository.buscarNoticia('oafoafaok');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
