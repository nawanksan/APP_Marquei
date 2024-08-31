import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInkWell extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  final IconData trailingIcon;

  const CustomInkWell({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    this.trailingIcon = Icons.arrow_forward_ios, // ícone padrão
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 18,
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF002AFF), BlendMode.srcIn),
                ),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0D0D0D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(
              trailingIcon,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
