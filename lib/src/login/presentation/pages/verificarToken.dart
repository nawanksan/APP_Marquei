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

  Future<void> _getPerfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      var url = Uri.https('marquei-api.fly.dev', '/api/professionals/me/');

      Map<String, String> headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> perfilMap = json.decode(response.body);

        await _saveUserProfile(perfilMap);
      } else {
        // Trate erros de resposta HTTP, se necessário.
      }
    }
  }

  Future<void> _saveUserProfile(Map<String, dynamic> perfilMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String perfilJson = jsonEncode(perfilMap);
    await prefs.setString('user_profile', perfilJson);
  }
}
