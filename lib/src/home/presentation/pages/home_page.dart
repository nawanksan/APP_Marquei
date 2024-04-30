import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF7FAFC),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFE4EFFF),
                              ),
                              alignment: Alignment.center,
                              child: const Image(
                                image: AssetImage('lib/assets/logo.png'),
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Boas vindas,',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF718096),
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Houston',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF0D0D0D),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Barros',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF718096),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ]),
                          Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    'lib/assets/icons/notify.svg',
                                    width: 20,
                                  )),
                              const SizedBox(width: 10),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFE4EFFF),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'HB',
                                    style: TextStyle(
                                      color: Color(0xFF2D3748),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estatísticas do seu negócio',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFFE4EFFF),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/calendar_heart.svg',
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xFF002AFF), BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Agendamentos',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '17',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF002AFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ]),
                          )),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFFE4EFFF),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/user_group.svg',
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xFF002AFF), BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total de Clientes',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '74',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF002AFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ]),
                          )),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xFFE4EFFF),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'lib/assets/icons/money.svg',
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(
                                          Color(0xFF002AFF), BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Faturamento',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'R\$ 31.230,00',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF002AFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ]),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
