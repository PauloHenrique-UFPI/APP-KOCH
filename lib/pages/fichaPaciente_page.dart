import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/models/prontuario.dart';
import 'package:koch_app/named_routes.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/repositories/prontuario_repository.dart';

import '../models/rest_client.dart';

class FichaPage extends StatefulWidget {
  final Paciente paciente;

  const FichaPage({super.key, required this.paciente});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  late DateTime data;
  late String dataFormatada;
  final ProntuarioRepository repo =
      ProntuarioRepository(restClient: GetIt.I.get<RestClient>());

  TextStyle _style() {
    return const TextStyle(
      fontFamily: 'RobotoMono',
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    data = DateTime.parse(widget.paciente.dataN);
    dataFormatada = DateFormat('dd-MM-yyyy').format(data);
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
        child: Column(
          children: [
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
                        controller:
                            TextEditingController(text: widget.paciente.nome),
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
                        controller: TextEditingController(text: dataFormatada),
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
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var teste =
                            await repo.achar(widget.paciente.id.toString());
                        if (teste != null) {
                          Navigator.pushNamed(
                            context,
                            ProntuarioViewRoute,
                            arguments: teste,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Paciente Sem Prontuário'),
                                content: const Text(
                                    'Este Paciente não tem um prontuario ou não foi encontrado, deseja dicionar?'),
                                // title: const Text('ERRO'),
                                // content: const Text('Erro no servidor:'),
                                actions: [
                                  TextButton(
                                    child: const Text('Adicionar'),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AddProntuarioViewRoute);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Acessar Prontuario"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
