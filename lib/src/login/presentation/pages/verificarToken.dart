import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VerificarToken extends StatefulWidget {
  const VerificarToken({super.key});

  @override
  State<VerificarToken> createState() => _VerificarTokenState();
}

class _VerificarTokenState extends State<VerificarToken> {
  @override
  void initState() {
    super.initState();
    _verificarToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7FAFC),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002AFF)),
          strokeCap: StrokeCap.round,
          strokeWidth: 5,
        ),
      ),
    );
  }

  Future<void> _verificarToken() async {
    bool tokenExiste = await _buscarToken();
    if (tokenExiste) {
      await _getPerfil();

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/menu');
      }
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  Future<bool> _buscarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token') != null;
  }

  // Método modificado para carregar perfil local fixo
  Future<void> _getPerfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Exemplo de perfil local fixo:
    Map<String, dynamic> perfilLocal = {
      "first_name": "Usuário",
      "last_name": "Local",
      "email": "teste@teste.com",
      "phone": "123456789",
      // Você pode adicionar mais campos conforme seu app precisar
    };

    // Salva o perfil local no SharedPreferences
    await _saveUserProfile(perfilLocal);
  }

  Future<void> _saveUserProfile(Map<String, dynamic> perfilMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String perfilJson = jsonEncode(perfilMap);
    await prefs.setString('user_profile', perfilJson);
  }
}

