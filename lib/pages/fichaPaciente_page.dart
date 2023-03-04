import 'package:flutter/material.dart';

import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/repositories/paciente_repository.dart';

import '../controllers.dart/controller_paciente.dart';

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
              color: Colors.blue,
              alignment: Alignment.bottomCenter,
              child: Text(
                'Ficha Médica',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Card(
                margin: const EdgeInsets.only(top: 15),
                color: Colors.amber,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 12),
                    child: Column(children: [
                      Text(
                        'Nome:',
                        style: _style(),
                      ),
                      Text(
                        widget.paciente.nome,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Nome da Mãe:', style: _style()),
                      Text(widget.paciente.nomeMae),
                      Text('Telefone:', style: _style()),
                      Text(widget.paciente.telefone),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Endereço:', style: _style()),
                      Text(widget.paciente.endereco),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                    ]))),
          ]),
        ));
  }
}

/*
child: Stack(children: [
                      Container(
                        color: Colors.amber,
                        width: 300,
                        height: 500,
                      ),
                      Container(
                        color: Colors.black,
                        width: 100,
                        height: 100,
                      )
                    ])

*/
