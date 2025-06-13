import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_application_1/ui/widgets/title_comp.dart';

class Apt4 extends StatefulWidget {
  const Apt4({super.key});

  @override
  State<Apt4> createState() => _Apt4State();
}

class _Apt4State extends State<Apt4> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play(); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.purple, Colors.orange, Colors.pink],
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.3,
            ),
          ),


          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 360),
                    const Titulo("Esse é um ótimo começo. Bom trabalho!"),
                    const SizedBox(height: 296),
                    SizedBox(
                      width: 160,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/tarefas_screen");
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
