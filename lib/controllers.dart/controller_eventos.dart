import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:koch_app/models/eventos.dart';
import 'package:koch_app/repositories/eventos_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class ControllerEvento extends ChangeNotifier {
  final EventoRepository _repository;
  LinkedHashMap<DateTime, List<Evento>>? calendar;

  String search = "";

  var eventos = <Evento>[];
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

  ControllerEvento({required EventoRepository eventoRepository})
      : _repository = eventoRepository;

  Future<void> buscareventos() async {
    try {
      loading = true;
      Map<DateTime, List<Evento>> eventosTemp = {};
      eventos = await _repository.buscarEvento();
      for (var i = 0; i < eventos.length; i++) {
        final evento = eventos[i];
        DateTime date =
            DateTime(evento.data.year, evento.data.month, evento.data.day);
        if (eventosTemp.containsKey(date)) {
          List<Evento> eventosVar = eventosTemp[date] ?? [];
          eventosVar.add(evento);
          eventosTemp[date] = eventosVar;
        } else {
          eventosTemp[date] = [evento];
        }
      }
      calendar = LinkedHashMap<DateTime, List<Evento>>(
        equals: isSameDay,
        hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
      )..addAll(eventosTemp);
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
