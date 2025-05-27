import 'package:flutter/material.dart';
import 'package:idate_libras/idate_e/idate_e_intrucoes.dart';
import 'package:idate_libras/idate_t/idate_t_intrucoes.dart';
import 'package:idate_libras/result_page.dart';
import 'package:idate_libras/login_page.dart'; // Certifique-se de ter uma página de login ou boas-vindas

class DashboardPage extends StatefulWidget {
  final String? userName; // Nome/Usuário opcional
  final bool fromLogin; // Indica se veio da tela de login

  const DashboardPage({
    super.key,
    this.userName = "Usuário",
    this.fromLogin = false,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  SingingCharacter? _character = SingingCharacter.idatet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'IDATE/Libras',
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF123068),

        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.fromLogin
                        ? 'Bem-vindo(a)!'
                        : 'Olá, ${widget.userName}!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'SELECIONE O FORMULÁRIO:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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
                    activeColor: Colors.blue,
                    tileColor: _character == SingingCharacter.idatet
                        ? Colors.blue.shade100
                        : null,
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
                    activeColor: Colors.blue,
                    tileColor: _character == SingingCharacter.idatee
                        ? Colors.blue.shade100
                        : null,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_character == SingingCharacter.idatet) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IdateTInstrucoes(),
                      ));
                    } else if (_character == SingingCharacter.idatee) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IdateEInstrucoes(),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123068),
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
