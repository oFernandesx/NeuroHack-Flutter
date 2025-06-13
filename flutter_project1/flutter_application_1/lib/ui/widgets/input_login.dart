// lib/widgets/input_login.dart

import 'package:flutter/material.dart';

class InputLogin extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const InputLogin({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF233B54), // <-- COR DA LETRA ATUALIZADA
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFFB2CFDB), // <-- COR DO INPUT ATUALIZADA
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 25.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none, // Sem borda
          ),
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Icon(icon, color: const Color(0xFF233B54)), // <-- COR DA LETRA ATUALIZADA
                )
              : null,
        ),
      ),
    );
  }
}