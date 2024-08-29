import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquei/src/catalog/presentation/home_catalog.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';
import 'package:marquei/src/login/presentation/pages/page_menu.dart';
import 'package:marquei/src/login/presentation/pages/verificarToken.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Verificartoken(),
        '/login': (context) => const LoginPage(),
        '/menu': (context) => const PageMenu(),
        '/home': (context) => const HomePage(),
        '/catalog-home': (context) => const CatalogScreen(),
      },
    );
  }
}
