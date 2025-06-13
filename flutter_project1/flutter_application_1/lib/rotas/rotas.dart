import 'package:flutter_application_1/ui/screens/apt1.dart';
import 'package:flutter_application_1/ui/screens/apt2.dart';
import 'package:flutter_application_1/ui/screens/apt3.dart';
import 'package:flutter_application_1/ui/screens/apt4.dart';
import 'package:flutter_application_1/ui/screens/calendario_screen.dart';
import 'package:flutter_application_1/ui/screens/tarefas_screen.dart';
import 'package:flutter_application_1/ui/screens/login.dart';

class Rotas {

  static final rotas = {
    "/apt1": (context) => const Apt1(),
    "/apt2": (context) => const Apt2(),
    "/apt3": (context) => const Apt3(),
    "/apt4": (context) => const Apt4(),
    "/tarefas_screen": (context) => const TarefasScreen(),
    "/calendario_screen": (context) => const CalendarioScreen(),
    "/perfil_screen": (context) => const SignUpScreen(),
  };
}  