import 'package:flutter/material.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/named_routes.dart';

class NoticiaCompleta extends StatefulWidget {
  final Noticia noticias;
  const NoticiaCompleta({super.key, required this.noticias});

  @override
  State<NoticiaCompleta> createState() => _NoticiaCompletaState();
}

class _NoticiaCompletaState extends State<NoticiaCompleta> {
  TextStyle _style() {
    return const TextStyle(
      fontFamily: 'RobotoMono',
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
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
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 20, bottom: 12),
                    child: Column(children: [
                      Text(
                        widget.noticias.titulo,
                        style: _style(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.noticias.data),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.noticias.desCurta),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.noticias.descLonga),
                      const SizedBox(
                        height: 20,
                      ),
                    ]))),
          ]),
        ));
  }
}
