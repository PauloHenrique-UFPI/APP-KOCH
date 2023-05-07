import 'package:flutter/material.dart';
import 'package:koch_app/models/contatos.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/models/prontuario.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/pages/add_noticias.dart';
import 'package:koch_app/pages/add_paciente.dart';
import 'package:koch_app/pages/fichaContato_page.dart';
import 'package:koch_app/pages/fichaPaciente_page.dart';

import 'package:koch_app/pages/login_page.dart';
import 'package:koch_app/pages/noticiaCompleta_page.dart';
import 'package:koch_app/pages/pagina_inicial.dart';
import 'package:koch_app/pages/profile_page.dart';
import 'package:koch_app/pages/prontuario_page.dart';
import 'package:koch_app/root.dart';

import 'models/prontuario.dart';

Map<String, Widget Function(BuildContext)> routes = {
  InitialViemRoute: (p0) => const PaginaInicial(),
  RootViewRoute: (p0) => const Root(),
  LoginViewRoute: (p0) => const LoginPage(),
  ProfileViewRoute: (p0) => const ProfilePage(),
  AddPacienteViewRoute: (p0) => const AddPacientes(),
  AddNoticiaViewRoute: (p0) => const AddNoticia(),
  FichaViewRoute: (context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    return FichaPage(
      paciente: arg as Paciente,
    );
  },
  NoticiaCompletaViewRoute: (context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    return NoticiaCompleta(
      noticias: arg as Noticia,
    );
  },
  ContatoViewRoute: (context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    return FichaContato(
      contatos: arg as Contato,
    );
  },
  ProntuarioViewRoute: (context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    return ProntuarioPage(
      prontuario: arg as Prontuario,
    );
  }
};
