import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomStatics extends StatelessWidget {
  final String iconPath;
  final String text;
  final String date;
  final String count;
  // final VoidCallback onTap;

  const CustomStatics({
    super.key,
    required this.iconPath,
    required this.text,
    // required this.onTap,
    required this.date,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('apertou o '+ text);
      },
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFE4EFFF),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  colorFilter:
                      const ColorFilter.mode(Color(0xFF002AFF), BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0D0D0D),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ), // Added fontFamily here
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF718096),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      count,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF002AFF),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
