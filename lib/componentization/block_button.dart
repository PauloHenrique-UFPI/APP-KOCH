//este arquivo serve para componentizar os butões, isto é cria a regra de negocios para tratar de eventuais
//botoes
import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double probutton;
  final Function()? onPressed;

  // ignore: non_constant_identifier_names
  final ButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 219, 56, 56),
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(15),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  );

  BlockButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.probutton,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: probutton,
      child: ElevatedButton.icon(
        style: ButtonStyle,
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
