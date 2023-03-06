import 'package:flutter/material.dart';

import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/repositories/paciente_repository.dart';

import '../controllers.dart/controller_paciente.dart';
import 'package:intl/intl.dart';

class FichaPage extends StatefulWidget {
  final Paciente paciente;

  const FichaPage({super.key, required this.paciente});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  TextStyle _style() {
    return const TextStyle(
      fontFamily: 'RobotoMono',
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime data = DateTime.parse(widget.paciente.dataN);
    String dataFormatada = DateFormat('dd-MM-yyyy').format(data);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TB-Koch',
            style: TextStyle(
                fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.supervised_user_circle_outlined),
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
                            'Nome:',
                            style: _style(),
                          ),
                          TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: widget.paciente.nome),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Data de Nascimento:',
                            style: _style(),
                          ),
                          TextField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: dataFormatada),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Nome da Mãe:', style: _style()),
                          TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: widget.paciente.nomeMae),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                              )),
                          Text('Telefone:', style: _style()),
                          TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: widget.paciente.telefone),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Endereço:', style: _style()),
                          TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                  text: widget.paciente.endereco),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                              )),
                          Text('Imagem de Exame:', style: _style()),
                          AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              widget.paciente.imgTrat,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]))),
            Card(
                // ignore: prefer_const_literals_to_create_immutables
                child: Column(
              children: [
                const Text(
                  "Para acessar o prontuario clique no botão abaixo: ",
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('Acesse o Prontuario'),
                )
              ],
            ))
          ]),
        ));
  }
}

/*
Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: name),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Idade:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: age.toString()),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Diagnóstico:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: diagnosis),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),

*/

/*

const Text(
                            "Para acessar o prontuario clique no botão abaixo: ",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            child: const Text('Acesse o Prontuario'),
                          )

*/
