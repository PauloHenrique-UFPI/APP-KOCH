import 'package:flutter/material.dart';
import 'package:koch_app/componentization/app_controler.dart';
import 'package:koch_app/core/rest_client/dio_client.dart';
import 'package:koch_app/controllers.dart/controller_noticias.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/pages/noticiaCompleta_page.dart';
import 'package:koch_app/repositories/noticias_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final controller = ControllerNoticias(
      noticiasRepository: NoticiasRepository(restClient: DioClient()));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.buscarNoticia();
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
            body: Container(
              padding: const EdgeInsets.all(20),
              child: _Body(noticias: controller.noticias),
            ),
          );
        });
  }
}

class _Body extends StatelessWidget {
  final List<Noticia> noticias;
  const _Body({required this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.pushNamed(context, NoticiaCompletaViewRoute,
                  arguments: noticias[index]),
            },
            child: Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 10, bottom: 12),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Image(image: NetworkImage(noticias[index].img)),
                    textColor: Colors.white,
                    tileColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      noticias[index].titulo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(noticias[index].desCurta),
                  ),
                ]),
              ),
            ),
          );
        });
  }
}

class Customizavel extends StatelessWidget {
  const Customizavel({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.temaDaAplicacao,
      onChanged: (value) {
        animation:
        AppController.instance.changeThema();
      },
    );
  }
}
