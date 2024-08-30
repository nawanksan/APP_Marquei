import 'package:flutter/material.dart';
import 'package:marquei/src/scheduling/presentation/widgets/calendar.dart';

class HomeScheduling extends StatelessWidget {
  const HomeScheduling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF002AFF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonthSelectorWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
