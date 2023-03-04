import 'package:flutter/material.dart';
import 'package:koch_app/models/noticias.dart';
import 'package:koch_app/models/paciente.dart';
import 'package:koch_app/models/profile.dart';
import 'package:koch_app/models/user.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/pages/add_paciente.dart';
import 'package:koch_app/pages/contatos_page.dart';
import 'package:koch_app/pages/fichaContato_page.dart';
import 'package:koch_app/pages/fichaPaciente_page.dart';
import 'package:koch_app/pages/home_page.dart';

import 'package:koch_app/pages/login_page.dart';
import 'package:koch_app/pages/noticiaCompleta_page.dart';
import 'package:koch_app/pages/paciente_page.dart';
import 'package:koch_app/pages/profile_page.dart';
import 'package:koch_app/root.dart';

import 'models/contatos.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arguments = settings.arguments;

  switch (settings.name) {
    case RootViewRoute:
      return MaterialPageRoute(builder: (context) => Root());

    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());

    case ProfileViewRoute:
      return MaterialPageRoute(builder: (context) => ProfilePage());

    case FichaViewRoute:
      return MaterialPageRoute(builder: (context) {
        print(arguments);
        return FichaPage(
          paciente: arguments as Paciente,
        );
      });
    case NoticiaCompletaViewRoute:
      return MaterialPageRoute(builder: (context) {
        print(arguments);
        return NoticiaCompleta(
          noticias: arguments as Noticia,
        );
      });

    case AddPacienteViewRoute:
      return MaterialPageRoute(builder: (context) => AddPacientes());

    default:
      return MaterialPageRoute(builder: (context) => Root());
  }
}
