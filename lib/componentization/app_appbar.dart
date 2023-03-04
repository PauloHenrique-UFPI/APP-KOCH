//componentização da nossa ap bar (quero usar em mais de uma tela)
import 'dart:ui';

import 'package:flutter/material.dart';

AppBar compAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      'TB-Koch',
      style: TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 26, 25, 25)),
    ),
    actions: <Widget>[
      IconButton(
          icon: Icon(Icons.supervised_user_circle_outlined), onPressed: () {}),
      //Customizavel(),
    ],
  );
}

BottomNavigationBar navbar() {
  return BottomNavigationBar(items: const [
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
  ]);
}
