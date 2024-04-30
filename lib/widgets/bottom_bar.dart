import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      currentIndex: _currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/home.svg',
            width: 18,
            colorFilter: ColorFilter.mode(
              _currentIndex == 0
                  ? const Color(0xFF002AFF)
                  : const Color(0xFF718096),
              BlendMode.srcIn,
            ),
          ),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/calendar_heart.svg',
            width: 20,
            colorFilter: ColorFilter.mode(
              _currentIndex == 1
                  ? const Color(0xFF002AFF)
                  : const Color(0xFF718096),
              BlendMode.srcIn,
            ),
          ),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/box.svg',
            width: 20,
            colorFilter: ColorFilter.mode(
              _currentIndex == 2
                  ? const Color(0xFF002AFF)
                  : const Color(0xFF718096),
              BlendMode.srcIn,
            ),
          ),
          label: 'Catálogo',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/money.svg',
            width: 20,
            colorFilter: ColorFilter.mode(
              _currentIndex == 3
                  ? const Color(0xFF002AFF)
                  : const Color(0xFF718096),
              BlendMode.srcIn,
            ),
          ),
          label: 'Finanças',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'lib/assets/icons/more.svg',
            width: 20,
            colorFilter: ColorFilter.mode(
              _currentIndex == 4
                  ? const Color(0xFF002AFF)
                  : const Color(0xFF718096),
              BlendMode.srcIn,
            ),
          ),
          label: 'Mais',
        ),
      ],
      selectedItemColor: const Color(0xFF0D0D0D),
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0D0D0D),
        height: 2.5,
      ),
      unselectedItemColor: const Color(0xFF718096),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Color(0xFF718096),
      ),
      showUnselectedLabels: true,
      enableFeedback: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
