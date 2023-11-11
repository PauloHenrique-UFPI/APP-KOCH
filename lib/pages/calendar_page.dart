import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/controllers.dart/controller_eventos.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/eventos.dart';
import 'package:koch_app/repositories/eventos_repository.dart';
import 'package:table_calendar/table_calendar.dart';

bool repetirSemanalmente = false;

// class Evento {
//   final String title;
//   final DateTime date;

//   Evento(this.title, this.date);
// }

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  final controller = ControllerEvento(
      eventoRepository: EventoRepository(restClient: DioClient()));
  ValueNotifier<List<Evento>> _selectedEvents = ValueNotifier<List<Evento>>([]);

  @override
  void initState() {
    super.initState();
    controller.buscareventos();
    _selectedEvents = ValueNotifier([]);
  }

  void _addEvent(DateTime day) {
    showDialog(
      context: context,
      builder: (context) {
        return EventAddScreen(today: day);
      },
    ).then((event) {
      if (event != null) {
        _selectedEvents.value.add(event);
        _selectedEvents.value =
            List.from(_selectedEvents.value); // Notificar os ouvintes

        if (repetirSemanalmente) {
          for (int i = 1; i <= 12; i++) {
            // Repetir o evento por 12 semanas
            DateTime nextWeek = event.data.add(Duration(days: 7 * i));
            Evento nextEvent =
                Evento(titulo: event.titulo as String, data: nextWeek);
            _selectedEvents.value.add(nextEvent);
          }
          _selectedEvents.value = List.from(
              _selectedEvents.value); // Notificar os ouvintes novamente
        }
        repetirSemanalmente = false;
      }
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

    if (controller.calendar?[day]?.isEmpty ?? true) {
      // Se não tiver eventos nesse dia, o dialogo para adicionar eventos vai ser aberto
      _addEvent(day);
    } else {
      // Se não, o dialogo com os eventos será mostrado
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Eventos em ${DateFormat('yMd').format(day)}'),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
              child: SingleChildScrollView(
                child: Column(
                  children: controller.calendar!.values
                      .expand((element) => element)
                      .map((event) => ListTile(
                            title: Text(event.titulo),
                            subtitle: Text(DateFormat('jm').format(event.data)),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _selectedEvents.value.remove(event);
                                _selectedEvents.value = List.from(
                                    _selectedEvents
                                        .value); // Notificar os ouvintes
                                Navigator.of(context).pop();
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Adicionar evento'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addEvent(day);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder<List<Evento>>(
          valueListenable: _selectedEvents,
          builder: (context, value, child) {
            return TableCalendar(
              eventLoader: (day) {
                return controller.calendar?[day] ?? [];
              },
              locale: 'pt_BR',
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              shouldFillViewport: true,
              onDaySelected: _onDaySelected,
            );
          },
        ),
      ),
    );
  }
}

class EventAddScreen extends StatefulWidget {
  final ValueNotifier<TimeOfDay?> timeSub = ValueNotifier(null);
  final DateTime today;

  EventAddScreen({super.key, required this.today});

  @override
  _EventAddScreenState createState() => _EventAddScreenState();
}

class _EventAddScreenState extends State<EventAddScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Título do evento',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            ValueListenableBuilder<TimeOfDay?>(
              valueListenable: widget.timeSub,
              builder: (context, timeVal, child) {
                return InkWell(
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true,
                          ),
                          child: child!,
                        );
                      },
                      initialTime: TimeOfDay.now(),
                    );
                    widget.timeSub.value = time;
                  },
                  child: buildDateTimePicker(
                    timeVal != null ? timeVal.format(context) : '14:00',
                    'Horário do Evento',
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Checkbox(
                      value: repetirSemanalmente,
                      onChanged: (value) {
                        setState(() {
                          repetirSemanalmente = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'Repetir toda semana',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String tituloEvento = _titleController.text;
                      TimeOfDay? horarioEvento = widget.timeSub.value;
                      if (tituloEvento.isNotEmpty && horarioEvento != null) {
                        Evento event = Evento(
                          titulo: tituloEvento,
                          data: DateTime(
                            widget.today.year,
                            widget.today.month,
                            widget.today.day,
                            horarioEvento.hour,
                            horarioEvento.minute,
                          ),
                        );
                        Navigator.of(context).pop(event);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(160, 50),
                    ),
                    child: const Text(
                      'Adicionar Evento',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String convertTime(TimeOfDay timeOfDay) {
  DateTime tempDate =
      DateFormat('hh:mm').parse('${timeOfDay.hour}:${timeOfDay.minute}');
  var dateFormat = DateFormat('h:mm a');
  return dateFormat.format(tempDate);
}

Widget buildDateTimePicker(String data, String texto) {
  return SizedBox(
    width: 300,
    height: 60,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100.withOpacity(0.2),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1.0),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        trailing: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.access_time,
            color: Colors.grey,
            size: 25.0,
          ),
        ),
      ),
    ),
  );
}
