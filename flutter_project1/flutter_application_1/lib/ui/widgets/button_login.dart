// lib/widgets/button_login.dart

import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonLogin({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFADC4D4), 
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF233B54), 
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}