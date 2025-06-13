import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  final String text;

  const Titulo(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }
}
