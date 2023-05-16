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
              'Prontuário',
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
                          text: widget.prontuario.tipo_entrada),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'População Especifica: ',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.popu_especifica),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Beneficiario:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.beneficiario),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Tipo Da Doença:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.tipo_doenca),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Se Extrapulmonar:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.se_extrapulmonar),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Agravos:',
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
                    height: 15,
                  ),
                  Text(
                    'Diagnostico:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.diagnostico),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Radiografia:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.radiografia),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'HIV:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: widget.prontuario.hiv),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Terapia:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.terapia),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Data de Inicio do Tratamento Atual:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.data_inicio_tratamento_atual),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Histopatologia:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.histopatologia),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Cultura:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.cultura),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Teste de Sensibilidade:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.teste_sensibilidade),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Contatos Identificados:',
                    style: _style(),
                  ),
                  TextField(
                      readOnly: true,
                      controller: TextEditingController(
                          text: widget.prontuario.contatos_identificados),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      )),
                  const SizedBox(
                    height: 15,
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
