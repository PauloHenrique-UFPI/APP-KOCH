import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:koch_app/componentization/app_appbar.dart';
import 'package:koch_app/componentization/cached_image.dart';
import 'package:koch_app/models/contatos.dart';
import 'package:koch_app/models/profile.dart';
import 'package:koch_app/named_routes.dart';

class ContatoViewPage extends StatefulWidget {
  final Profile profiles;
  const ContatoViewPage({super.key, required this.profiles});

  @override
  State<ContatoViewPage> createState() => _ContatoViewPageState();
}

class _ContatoViewPageState extends State<ContatoViewPage> {
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
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 15),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 12),
                    child: Column(children: [
                      Text(
                        'Nome:',
                        style: _style(),
                      ),
                      Text(
                        widget.profiles.nomeP,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text('Email:', style: _style()),
                      Text(widget.profiles.emailP),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("Profissão", style: _style()),
                      Text(widget.profiles.profissaoP),
                      const SizedBox(
                        height: 20,
                      ),
                    ]))),
          ]),
        ));
  }
}
