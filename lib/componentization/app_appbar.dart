// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:koch_app/models/user.dart';
import 'package:koch_app/named_routes.dart';

AppBar compAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    title: const Text(
      'TB-Koch',
      style: TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
    ),
    actions: <Widget>[
      PopupMenuButton(
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 'settings',
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
          ),
          const PopupMenuItem(
            value: 'logout',
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ),
        ],
        onSelected: (value) {
          if (value == 'logout') {
            // Redirecionar para a tela de login ou executar a lógica de logout aqui
            Navigator.pushNamed(context, LoginViewRoute);
          }
        },
      ),
    ],
  );
}

BottomNavigationBar navbar() {
  return BottomNavigationBar(
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
    ],
  );
}
