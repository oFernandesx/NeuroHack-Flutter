import 'package:flutter/material.dart';
import 'package:flutter_application_1/rotas/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importe esta linha

void main() async { // Marque main como async
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado
  await initializeDateFormatting('pt_BR', null); // Inicialize os dados de locale para português do Brasil
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // <-- Adicione esta linha aqui
      initialRoute: "/apt1", // Sua rota inicial
      theme: Theme.light, // Seu tema personalizado

      // AQUI NÃO TEMOS MAIS A TRANSIÇÃO LATERAL
      onGenerateRoute: (settings) {
        // Mapeia todas as suas rotas definidas em Rotas.rotas
        final Map<String, WidgetBuilder> allRoutes = Rotas.rotas;

        // Tenta encontrar o construtor de widget para a rota solicitada
        final WidgetBuilder? builder = allRoutes[settings.name];

        // Se o construtor não for encontrado, retorna uma rota de erro ou null
        if (builder == null) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Erro de Rota')),
              body: Center(
                child: Text('Rota não encontrada: ${settings.name}'),
              ),
            ),
          );
        }

        // Para TODAS as rotas encontradas, retornamos um MaterialPageRoute padrão (sem animação lateral personalizada)
        return MaterialPageRoute(
          builder: (context) => builder(context),
          settings: settings, // Importante para passar argumentos para a próxima tela
        );
      },
    );
  }
}

// Sua classe Theme permanece a mesma
class Theme {
  static final light = ThemeData(
    scaffoldBackgroundColor: const Color(0XFFFAEFED),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    textTheme: GoogleFonts.poppinsTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFFB2CFDB),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        foregroundColor: Colors.black,
      ),
    ),
  );
}
