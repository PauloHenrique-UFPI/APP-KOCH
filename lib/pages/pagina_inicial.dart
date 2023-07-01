// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/pages/login_page.dart';
import 'package:koch_app/root.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rest_client.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  _PaginaInicial createState() => _PaginaInicial();
}

class _PaginaInicial extends State<PaginaInicial> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (duration) {
        verificaUsuario().then(
          (temUsuario) {
            if (temUsuario) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Root()),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pagina de verificação'),
      ),
    );
  }

  Future<bool> verificaUsuario() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('token');
    // ignore: unused_local_variable
    final httpClient = GetIt.I.get<RestClient>();

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
