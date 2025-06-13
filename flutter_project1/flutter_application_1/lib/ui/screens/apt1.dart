import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/subtitle_comp.dart';
import 'package:flutter_application_1/ui/widgets/title_comp.dart';

class Apt1 extends StatelessWidget {
  const Apt1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120,),
                Image.asset("assets/icons/apt1-removebg-preview.png",
                width: 270,height: 320,),
                const SizedBox(height: 25,),
                const Titulo("Olá, bem-vindo!"),
                const SizedBox(height: 9,),
                const Subtitulo("Sou o aplicativo inteligente que te guia rumo a hábitos saudáveis e tarefas concluídas."),
                const SizedBox(height: 180,),
                SizedBox( width: 160,height: 55, child:  
                ElevatedButton(
                  onPressed: (){Navigator.pushNamed(context, "/apt2");}, 
                  child: const Text("Continue",style: TextStyle(fontWeight: FontWeight.bold),),)
                )
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}