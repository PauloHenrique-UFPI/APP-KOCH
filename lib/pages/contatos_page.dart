import 'package:flutter/material.dart';
import 'package:koch_app/models/contatos.dart';
import 'package:koch_app/named_routes.dart';
import '../controllers.dart/controller_contatos.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ContatoPageState();
  }
}

class ContatoPageState extends State<ContatoPage> {
  final controller = Controllercontato();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            actions: [
              if (controller.searshing)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration:
                          const InputDecoration(labelText: 'Contatos: '),
                      autofocus: true,
                      onChanged: controller.changeSearch,
                    ),
                  ),
                ),
              if (!controller.searshing)
                GestureDetector(
                  onTap: controller.changeSearshing,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    color: Colors.transparent,
                  ),
                ),
              IconButton(
                color: Colors.black,
                onPressed: controller.changeSearshing,
                icon: controller.searshing
                    ? const Icon(Icons.close)
                    : const Icon(Icons.search_sharp),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: _Body(contato: controller.contatos),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final List<Contato> contato;
  const _Body({required this.contato});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: contato.map((contato) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(contato.nome),
                subtitle: Text(contato.numero),
                onTap: () {
                  Navigator.pushNamed(context, ContatoViewRoute,
                      arguments: contato);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
