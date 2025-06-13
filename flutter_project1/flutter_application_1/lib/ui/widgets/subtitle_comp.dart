import 'package:flutter/material.dart';

class Subtitulo extends StatelessWidget {
  final String text;

  const Subtitulo(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
