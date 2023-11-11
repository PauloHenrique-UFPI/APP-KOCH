// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:koch_app/componentization/app_appbar.dart';
import 'package:koch_app/named_routes.dart';
import 'package:koch_app/pages/contatos_page.dart';
import 'package:koch_app/pages/home_page.dart';
import 'package:koch_app/pages/paciente_page.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  var _currentIndex = 1;
  final _children = [
    const ContatoPage(),
    const HomePage(),
    const PacientePage(),
  ];

  _onTap(int tab) {
    if (_currentIndex != tab) {
      setState(
        () {
          _currentIndex = tab;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: compAppBar(context),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Contatos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Pacientes",
          ),
        ],
      ),
    );
  }
}
