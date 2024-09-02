import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquei/src/login/presentation/widgets/input_decoration.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF7FAFC),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ainda não tem conta?',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0D0D0D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        ' Cadastre-se',
                        style: TextStyle(
                          color: Color(0xFF0053CC),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('E-mail',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: getAuthenticationInputDecoration(''),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor insira seu e-mail';
                            } else if (!emailRegExp.hasMatch(value)) {
                              return 'Por favor, insira um e-mail válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text('Senha',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: getAuthenticationInputDecoration(""),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor insira sua senha';
                            }else if(value.length < 4){
                              return 'A senha muito curta';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        _isLoading? const CircularProgressIndicator(color: Color(0xFF0053CC),):
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color(0xFF0053CC)),
                                foregroundColor:
                                    const MaterialStatePropertyAll(Colors.white),
                                minimumSize: const MaterialStatePropertyAll(
                                  Size(400, 45),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                
                                if(_formKey.currentState?.validate() ?? false) {
                                  bool deuCerto = await realizarLogin();
                                  if (deuCerto) {
                                    Navigator.pushReplacementNamed(
                                        context, '/menu');
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Erro'),
                                          content: const Text('Dados Inválidos'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text('Fazer Login'),
                          ),
                        const Divider(
                          height: 40,
                          thickness: 1,
                          color: Color(0xFFE2E8F0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                              color: Color(0xFF0053CC),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Marquei ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '© 2024, Todos os direitos reservados',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
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

  Future<bool> realizarLogin() async {
      SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();

      setState(() {
        _isLoading = true;
      });

      var url = Uri.parse('https://marquei-api.fly.dev/api/auth/token/');

      var response = await http.post(
        url,
        body: json.encode({
          "email": _emailController.text,
          "password": _passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // print(response.body);

      if (response.statusCode == 200) {
        await _sharedPreferences.setString('token', "Bearer ${jsonDecode(response.body)['token']}");

        setState(() {
          _isLoading = false;
        });

        print('logado');
        return true;
      } else {

        setState(() {
          _isLoading = false;
        });

        print('dados invalidos');
        return false;
      }
    
  }
}
