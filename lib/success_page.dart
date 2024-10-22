import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Importando a tela DashboardPage

class SuccessPage extends StatelessWidget {
  final String userName; // Recebe o nome do usuário da tela de cadastro

  const SuccessPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mensagem de sucesso
            const Text(
              'Cadastro realizado com sucesso!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Cor do texto
              ),
            ),
            const SizedBox(height: 40),
            // Ícone de sucesso
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.green, // Fundo verde
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 100,
                color: Colors.white, // Cor do ícone de check
              ),
            ),
            const SizedBox(height: 40),
            // Botão "Acessar conta"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navega para a DashboardPage, passando o nome/usuário
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          userName: userName, // Passa o nome/usuário para a Dashboard
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123068), // Azul solicitado
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Acessar conta',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
