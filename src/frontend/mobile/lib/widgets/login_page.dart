import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUsuario = TextEditingController();
  final _controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sírio Libanês'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Image.asset('assets/logo.png'),

              const SizedBox(height: 20),

              TextFormField(
                controller: _controllerUsuario,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome de usuário';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _controllerSenha,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    
                  }
                },
                child: const Text('Login'),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  
                },
                child:const Text('Esqueci minha senha?'),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  
                },
                child: const Text('Quero me cadastrar!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
