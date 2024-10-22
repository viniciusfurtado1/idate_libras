import 'package:flutter/material.dart';
import 'idate_t_page.dart'; // Importando a página IDATE-T
import 'idate_e_page.dart'; // Importando a página IDATE-E

class DashboardPage extends StatefulWidget {
  final String userName; // Nome/Usuário passado da tela de sucesso

  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  SingingCharacter? _character = SingingCharacter.idatet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com foto e saudação personalizada
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Imagem do usuário
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/user_image.jpg'), // Substitua pelo caminho correto da imagem
                      ),
                      const SizedBox(width: 10),
                      // Saudação com o nome/usuário
                      Text(
                        'Olá, ${widget.userName}!', // Exibe o nome passado
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Ícone para acessar o histórico
                  IconButton(
                    icon: const Icon(Icons.history, size: 28),
                    onPressed: () {
                      // Lógica para ver histórico de avaliações
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EvaluationHistoryPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Botão para voltar
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Volta para a tela anterior
                  Navigator.pop(context);
                },
              ),
              const Text(
                'SELECIONE O FORMULÁRIO:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Opções de seleção (IDATE-T e IDATE-E)
              Column(
                children: [
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'IDATE-T',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    value: SingingCharacter.idatet,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                    activeColor: Colors.blue, // Cor ativa
                    tileColor: _character == SingingCharacter.idatet
                        ? Colors.blue.shade100
                        : null, // Cor de fundo ao selecionar
                  ),
                  const SizedBox(height: 10),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'IDATE-E',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    value: SingingCharacter.idatee,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                    activeColor: Colors.blue, // Cor ativa
                    tileColor: _character == SingingCharacter.idatee
                        ? Colors.blue.shade100
                        : null, // Cor de fundo ao selecionar
                  ),
                ],
              ),
              const Spacer(),
              // Botão para continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para continuar
                    if (_character == SingingCharacter.idatet) {
                      // Ação para IDATE-T
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const IdateTPage()),
                      );
                    } else if (_character == SingingCharacter.idatee) {
                      // Ação para IDATE-E
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const IdateEPage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123068), // Cor azul
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SingingCharacter { idatet, idatee }

class EvaluationHistoryPage extends StatelessWidget {
  const EvaluationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Avaliações'),
      ),
      body: const Center(
        child: Text('Aqui estará o histórico de avaliações.'),
      ),
    );
  }
}
