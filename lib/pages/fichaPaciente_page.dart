// ignore_for_file: file_names, use_build_context_synchronously, unrelated_type_equality_checks
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/repositories/prontuario_repository.dart';
import '../models/rest_client.dart';

class FichaPage extends StatefulWidget {
  final Paciente paciente;

  const FichaPage({super.key, required this.paciente});

  @override
  State<FichaPage> createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  // final controller = ControllerProntuario(
  //   prontuarioRepository: ProntuarioRepository(
  //     restClient: DioClient(),
  //   ),
  // );

  final prontuarioRepository = ProntuarioRepository(
    restClient: DioClient(),
  );

  late DateTime data;
  File? _image;
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
            Center(
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
                      ),
                    ),
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
                      controller:
                          TextEditingController(text: widget.paciente.nomeMae),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    Text('Telefone:', style: _style()),
                    TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: widget.paciente.telefone),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Endereço:', style: _style()),
                    TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: widget.paciente.endereco),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Imagem de Exame:', style: _style()),
                    if (_image != null)
                      Image.file(
                        _image!,
                        height: 300,
                        width: 300,
                      ),
                    const SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              prontuarioRepository
                                  .acharProntuario(widget.paciente.id)
                                  .then(
                                (result) {
                                  result.fold((success) {
                                    Navigator.pushNamed(
                                      context,
                                      ProntuarioViewRoute,
                                      arguments: success,
                                    );
                                  }, (failure) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Prontuário Inexistente"),
                                          content: const Text(
                                              "Deseja Adicionar um prontuário?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Não'),
                                              child: const Text("Não"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pushNamed(context,
                                                      AddProntuarioViewRoute),
                                              child: const Text('Adicionar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });
                                },
                              );
                            },
                            child: const Text("Acessar Prontuário"),
                          ),
                        ],
                      ),
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
