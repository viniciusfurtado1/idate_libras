import 'package:flutter/material.dart';
import 'success_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  SingingCharacter? _character = SingingCharacter.usuario;
  final TextEditingController _nameController = TextEditingController(); // Controlador para o nome/usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Cor azul atualizada
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40.0),
                // Logo e Título
                const Text(
                  'Idate Libras',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Por favor, preencha abaixo para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                // Campo de Email
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email *',
                    hintText: 'usuario@gmail.com',
                    fillColor: Colors.black,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de Nome de usuário
                TextField(
                  controller: _nameController, // Associando o controlador de nome/usuário
                  decoration: const InputDecoration(
                    labelText: 'Nome / User *',
                    hintText: 'Digite seu nome ou usuário',
                    fillColor: Colors.black,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Tipo de usuário
                const Text(
                  'Tipo de usuário *',
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Profissional de saúde',
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.profissional,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                          fillColor: MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Usuário',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.usuario,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                          fillColor: MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Campo de Senha
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha *',
                    hintText: '******',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Botão Criar Conta com fundo branco
                ElevatedButton(
                  onPressed: () {
                    // Navega para a tela de sucesso, passando o nome/usuário
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(
                          userName: _nameController.text, // Passando o nome para a tela de sucesso
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
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum SingingCharacter { usuario, profissional }
