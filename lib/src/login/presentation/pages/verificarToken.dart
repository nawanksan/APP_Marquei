import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class Verificartoken extends StatefulWidget {
  const Verificartoken({super.key});

  @override
  State<Verificartoken> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Verificartoken> {

  @override
  void initState() {
    super.initState();
    buscarToken().then((value){
      if (value){
        Navigator.pushReplacementNamed(context, '/menu');
      }else{
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  Future<bool> buscarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token') != null){
      return true;
    }else{
      return false;
    }
  }
}