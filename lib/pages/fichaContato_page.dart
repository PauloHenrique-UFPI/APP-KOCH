// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:koch_app/models/contatos.dart';
import 'package:koch_app/named_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class FichaContato extends StatefulWidget {
  final Contato contatos;
  const FichaContato({super.key, required this.contatos});

  @override
  State<FichaContato> createState() => _FichaContatoState();
}

class _FichaContatoState extends State<FichaContato> {
  TextStyle _style() {
    return const TextStyle(
      fontFamily: 'RobotoMono',
      fontWeight: FontWeight.bold,
    );
  }

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TB-Koch',
          style:
              TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.settings),
        //     onPressed: () {
        //       Navigator.pushNamed(
        //         context,
        //         ProfileViewRoute,
        //         arguments: {
        //           'id': 1,
        //         },
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Ficha de Contato',
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
                          TextEditingController(text: widget.contatos.nome),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Numero:',
                      style: _style(),
                    ),
                    TextField(
                      readOnly: true,
                      controller:
                          TextEditingController(text: widget.contatos.numero),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Descrição:',
                      style: _style(),
                    ),
                    TextField(
                      readOnly: true,
                      maxLines: null,
                      controller: TextEditingController(
                          text: widget.contatos.descricao),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton.icon(
                          onPressed: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: widget.contatos.numero,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              print('erro ao abrir link');
                            }
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          label: const Text(
                            'Ligar',
                            style: TextStyle(color: Colors.green),
                          )),
                    )
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
