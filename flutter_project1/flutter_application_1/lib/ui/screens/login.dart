// lib/ui/screens/subscribe.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/nav_button_bar.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int _selectedIndex = 2; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/tarefas_screen');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/calendario_screen');
      } else if (index == 2) {
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB7D1DD), 

      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)), 
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF233B54), 
                          shape: BoxShape.circle,
                        ),
                        child: const Icon( 
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Inscreva-se ou faça login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF233B54), 
                        ),
                      ),
                      const SizedBox(height: 8),

                      const Text(
                        'Você está atualmente no modo visitante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),

                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar( // Use const SnackBar
                              content: Text('Funcionalidade de Fazer Login em desenvolvimento!'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF233B54), // Laranja
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Fazer Login',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Exemplo de botão para criar conta:
                      OutlinedButton(
                        onPressed: () {
                          // Navegar para a tela de criação de conta, se houver
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar( // Use const SnackBar
                              content: Text('Funcionalidade de Criar Conta em desenvolvimento!'),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF233B54), // Azul escuro
                          side: const BorderSide(color: Color(0xFF233B54), width: 2), // Borda azul escura
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Criar Conta',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavButtonBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
