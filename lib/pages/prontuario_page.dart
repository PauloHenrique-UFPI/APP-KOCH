import 'package:flutter/material.dart';
import 'package:koch_app/models/prontuario.dart';
import 'package:koch_app/named_routes.dart';

class ProntuarioPage extends StatefulWidget {
  final Prontuario prontuario;
  const ProntuarioPage({super.key, required this.prontuario});

  @override
  State<ProntuarioPage> createState() => _ProntuarioPageState();
}

class _ProntuarioPageState extends State<ProntuarioPage> {
  TextStyle _style() {
    return const TextStyle(
      fontFamily: 'RobotoMono',
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TB-Koch',
          style:
              TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                ProfileViewRoute,
                arguments: {
                  'id': 1,
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.bottomCenter,
            child: Text(
              'Ficha Médica',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(top: 15),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo da Entrada:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.agravos),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
