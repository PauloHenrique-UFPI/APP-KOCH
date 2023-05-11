import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:koch_app/componentization/block_button.dart';
import 'package:koch_app/models/rest_client.dart';
import 'package:koch_app/named_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final httpClient = GetIt.I.get<RestClient>();
  String token = '';

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();

  Future login(String email, String password) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      final response = await httpClient.post(
        '/login',
        {
          'email': email,
          'password': password,
        },
      );

      token = response['token'];
      await _sharedPreferences.setString('token', token);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, InitialViemRoute);
    } catch (error) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Invalido'),
            content: const Text('Seu E-mail e/ou senha inválidos'),
            // title: const Text('ERRO'),
            // content: const Text('Erro no servidor:'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset("assets/images/LOGO_TB_KOCH.png"),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'nome@gmail.com',
                          border: OutlineInputBorder()),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Digite seu e-mail';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Senha', border: OutlineInputBorder()),
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Digite sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlockButton(
                        icon: Icons.logout,
                        label: 'Entrar',
                        probutton: 300,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login(_email.text, _senha.text);
                          }
                        })
                    //
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}