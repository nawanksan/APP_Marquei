import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';
import 'package:marquei/widgets/bottom_bar.dart';

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
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
