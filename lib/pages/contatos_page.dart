import 'package:flutter/material.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/models/contatos.dart';
import 'package:koch_app/named_routes.dart';
import '../controllers.dart/controller_contatos.dart';
import '../repositories/contatos_repository.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ContatoPageState();
  }
}

class ContatoPageState extends State<ContatoPage> {
  final controller = Controllercontato(
      contatoRepository: ContatoRepository(restClient: DioClient()));
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    controller.buscarcontato();
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
            appBar:
                AppBar(elevation: 1, backgroundColor: Colors.white, actions: [
              if (controller.searshing)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
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
            ]),
            //AQUI E O BODY DA APLICAÇÂO
            body: Container(
              padding: const EdgeInsets.all(20),
              child: _Body(contato: controller.contatos),
            ),
          );
        });
  }
}

class _Body extends StatelessWidget {
  final List<Contato> contato;
  const _Body({required this.contato});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contato.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, ContatoViewRoute,
                  arguments: contato[index]),
            },
            child: Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 10, bottom: 12),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(contato[index].nome),
                    textColor: Colors.white,
                    tileColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  ListTile(
                    title: Text(contato[index].numero),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
