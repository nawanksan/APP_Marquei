import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:marquei/src/add/presentation/widgets/custom_inkwell.dart';
import 'package:marquei/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class TelaMaisState extends StatefulWidget {
  const TelaMaisState({super.key});

  @override
  State<TelaMaisState> createState() => TelaMaisStateState();
}

class TelaMaisStateState extends State<TelaMaisState> {
  Map<String, dynamic>? perfil;

  @override
  void initState() {
    super.initState();
    initUserProfile();
  }

  Future<void> initUserProfile() async {
    perfil = await getUserProfile();
    setState(() {}); // Atualiza o estado para refletir as mudanças
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppBar(perfil: perfil, sair: sair),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Negócio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D0D0D),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Avaliações de clientes',
                        onTap: () {
                          print('apertou 1');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // Ícone pode ser alterado
                      ),
                      const SizedBox(height: 10),
                      
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Cupons',
                        onTap: () {
                          print('apertou 2');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // Ícone pode ser alterado
                      ),
                      const SizedBox(height: 10),
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Página do Negócio',
                        onTap: () {
                          print('apertou 3');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                      ),
                      const SizedBox(height: 10),
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Relatórios',
                        onTap: () {
                          print('apertou 4');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Ajustes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D0D0D),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Horários',
                        onTap: () {
                          print('apertou 5');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                      ),
                     const SizedBox(height: 10),
                     CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Regras de Agendamentos',
                        onTap: () {
                          print('apertou 6');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        'Ajuda',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D0D0D),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Fale Conosco',
                        onTap: () {
                          print('apertou 7');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                      ),
                     const SizedBox(height: 10),
                     CustomInkWell(
                        iconPath: 'lib/assets/icons/home.svg',
                        text: 'Termos e Políticas',
                        onTap: () {
                          print('apertou 8');
                        },
                        trailingIcon: Icons.arrow_forward_ios, // ��cone pode ser alterado
                     ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          bool saiu = await sair();
                          if (saiu) {
                            Navigator.pushNamedAndRemoveUntil(
                                // ignore: use_build_context_synchronously
                                context,
                                '/',
                                (route) => false);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: const Color(0xFFE2E8F0), width: 1)),
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sair',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 239, 8, 8),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Versão 1.0.0',style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w600 ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
            
          ),
        ),
      ),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? perfilJson = prefs.getString('user_profile');
    if (perfilJson != null) {
      return jsonDecode(perfilJson);
    }
    return null;
  }
}
