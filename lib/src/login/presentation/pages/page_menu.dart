import 'package:flutter/material.dart';
import 'package:marquei/src/add/presentation/home_add.dart';
import 'package:marquei/src/finances/presentation/home_finan%C3%A7as.dart';
import 'package:marquei/src/scheduling/presentation/home_agenda.dart';
import 'package:marquei/src/catalog/presentation/home_catalog.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';
import 'package:marquei/widgets/bottom_bar.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({super.key});

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
      setState(() {
        _currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          HomePage(),
          TelaAgenda(),
          CatalogScreen(),
          TelaFinancas(),
          TelaMaisState(),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
