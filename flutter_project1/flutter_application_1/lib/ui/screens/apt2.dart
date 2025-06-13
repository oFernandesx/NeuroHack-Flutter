import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/subtitle_comp.dart';
import 'package:flutter_application_1/ui/widgets/title_comp.dart';

class Apt2 extends StatelessWidget {
  const Apt2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/icons/cellphone12.png',
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: double.infinity, 
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, 
                    Colors.black.withOpacity(0.7), 
                  ],

                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),


          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(

                children: [
                  const SizedBox(height: 150), 
                  const Column(
                    children: [
                      Titulo("Viva com mais foco e disciplina"),
                      SizedBox(height: 4),
                      Subtitulo("Isso traz mais equilíbrio, saúde e produtividade para o seu dia a dia."),
                    ],
                  ),

                  const Spacer(), 

                  SizedBox(
                    width: 160,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/apt3");
                      },
                      child: const Text(
                        "Continuar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 90), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}