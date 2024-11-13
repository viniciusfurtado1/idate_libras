import 'package:flutter/material.dart';
import 'success_page.dart';
import 'welcome_page.dart'; // Certifique-se de que esta importação está correta

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  SingingCharacter? _character = SingingCharacter.usuario;
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Navega para a tela de sucesso se o formulário for válido
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessPage(userName: _nameController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF123068),
        title: const Text(
          "Cadastro",
          style: TextStyle(color: Colors.white), // Define o texto do título como branco
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // Define a cor do ícone como branco
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20.0), // Ajuste a altura para posicionar "Idate Libras" mais acima
                  const Text(
                    'Idate Libras',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Por favor, preencha abaixo para continuar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Campo de Email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Usuário / Email',
                      hintText: 'Digite o seu email',
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Insira um email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Campo de Nome de usuário
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome / User *',
                      hintText: 'Digite seu nome ou usuário',
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome ou usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Tipo de usuário
                  const Text(
                    'Tipo de usuário *',
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            'Usuário',
                            style: TextStyle(color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.usuario,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                            fillColor: MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200, // Define largura para ajustar o espaçamento
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
                            fillColor: MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_character == null) // Mensagem de erro caso o tipo de usuário não esteja selecionado
                    const Text(
                      'Por favor, selecione um tipo de usuário',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  // Campo de Senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma senha';
                      } else if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Campo de confirmação de Senha
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Digite novamente sua senha',
                      hintText: 'Digite novamente sua senha',
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      } else if (value != _passwordController.text) {
                        return 'As senhas não correspondem';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Botão Criar Conta
                  ElevatedButton(
                    onPressed: () {
                      if (_character == null) {
                        setState(() {}); // Força a atualização da tela para exibir a mensagem de erro
                      } else {
                        _submitForm(); // Envia o formulário se estiver tudo correto
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
                      'Criar Conta',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum SingingCharacter { usuario, profissional }
