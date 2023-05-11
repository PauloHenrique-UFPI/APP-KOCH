import 'package:flutter/material.dart';
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
  @override
  var _currentIndex = 1;
  var _children = [
    const ContatoPage(),
    const HomePage(),
    const PacientePage(),
  ];

  _onTap(int tab) {
    if (_currentIndex != tab) {
      setState(() {
        _currentIndex = tab;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'TB-Koch',
          style:
              TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
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
            )
          ]),
    );
  }
}
