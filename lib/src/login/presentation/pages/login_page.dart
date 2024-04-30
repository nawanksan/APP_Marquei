import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:marquei/src/login/presentation/widgets/input_decoration.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              realizarLogin(context);
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
                            Navigator.pushNamed(context, '/home');
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

  realizarLogin(BuildContext context) async {
    var url = Uri.parse('https://marquei-api.fly.dev/api/core/token/');

    try {
      var response = await http.post(
        url,
        body: {
          "password": _passwordController.text,
          "email": _emailController.text,
        },
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido, você pode lidar com a resposta da API aqui
      } else {
        // Login falhou
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Dados Inválidos'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (error) {
      // Erro de conexão ou outro erro
    }
  }

  static void forgotPassword() async {
    const url = 'https://www.globo.com';
    try {
      await launchUrl(Uri.parse(url));
    } catch (error) {
      // ignore: avoid_print
      print('link inválido');
    }
  }
}
