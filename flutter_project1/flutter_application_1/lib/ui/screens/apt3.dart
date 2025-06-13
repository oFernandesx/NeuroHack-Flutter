import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/subtitle_comp.dart';
import 'package:flutter_application_1/ui/widgets/title_comp.dart';

class Apt3 extends StatelessWidget {
  const Apt3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter, 
            child: Image.asset(
              'assets/icons/cellphone2.png', 
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Titulo("Organize seus dias com leveza e clareza"),
                      SizedBox(height: 4),
                      Subtitulo("Veja seus compromissos com clareza e tenha mais controle da sua rotina."),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 160,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/apt4");
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