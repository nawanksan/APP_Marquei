import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/assets/icons/home.svg',
              width: 18,
              colorFilter: ColorFilter.mode(
                currentIndex == 0
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
                currentIndex == 1
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
                currentIndex == 2
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
                currentIndex == 3
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
                currentIndex == 4
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
      ),
    );
  }
}
