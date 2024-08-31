import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquei/src/add/presentation/home_add.dart';
import 'package:marquei/src/catalog/presentation/home_catalog.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';
import 'package:marquei/src/login/presentation/pages/page_menu.dart';
import 'package:marquei/src/login/presentation/pages/verificarToken.dart';
import 'package:marquei/src/scheduling/presentation/home_scheduling.dart';

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
        // Colocar a fonte INter como padrão
        fontFamily: 'Inter',
        primaryColor: const Color(0xFF002AFF),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const VerificarToken(),
        '/login': (context) => const LoginPage(),
        '/menu': (context) => const PageMenu(),
        '/home': (context) => const HomePage(),
        '/catalog-home': (context) => const CatalogScreen(),
        '/Mais-home': (context) => const TelaMaisState(),
        '/scheduling-home': (context) => const CalendarPage(),
      },
    );
  }
}
