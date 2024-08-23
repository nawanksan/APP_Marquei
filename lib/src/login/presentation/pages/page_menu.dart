import 'package:flutter/material.dart';
import 'package:marquei/src/home/presentation/pages/home_page.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({super.key});

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final List<Widget> _widgetOptions = <Widget>[
  //   HomePage(), // Tela principal
  //   HomePage(), // Tela de configurações
  //   HomePage(), // Tela de perfil
  // ];

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomePage();
    // var activePageTitle = 'Categories';
    if (_selectedIndex == 1){
      activePage = const HomePage();
      // activePageTitle = 'Favorites';
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF002AFF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_outlined),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Finanças',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: 'Mais',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
