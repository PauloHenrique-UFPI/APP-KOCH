import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/componentization/loading.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/named_routes.dart';
import 'package:intl/intl.dart';
import 'package:koch_app/root.dart';

class NoticiaCompleta extends StatefulWidget {
  final Noticia noticias;
  const NoticiaCompleta({super.key, required this.noticias});

  @override
  State<NoticiaCompleta> createState() => _NoticiaCompletaState();
}

class _NoticiaCompletaState extends State<NoticiaCompleta> {
  late DateTime data;
  late final int id = widget.noticias.id;
  late String dataFormatada;
  final httpClient = GetIt.I.get<RestClient>();

  @override
  void initState() {
    data = DateTime.parse(widget.noticias.data);
    dataFormatada = DateFormat('dd-MM-yyyy').format(data);
    super.initState();
  }

  Future delete(String id) async {
    String mensagem;
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          context = context;
          return const Loading();
        },
      );
      final response = await httpClient.delete(
        '/delete-new',
        widget.noticias.id.toString(),
      );

      mensagem = response["message"];
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: Text(mensagem),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Root()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: const Text('Erro:'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
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
        title: const Text(
          'TB-Koch',
          style:
              TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 20, bottom: 12),
                child: Column(
                  children: [
                    Text(
                      widget.noticias.titulo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.noticias.desCurta,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        widget.noticias.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Data de Publicação: $dataFormatada"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.noticias.descLonga,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () => {
          delete(
            id.toString(),
          ),
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
