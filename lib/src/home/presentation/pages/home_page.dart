import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquei/main.dart';
import 'package:marquei/src/login/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? perfil;

  void initState() {
    super.initState();
    getperfil();
  }

  //codigo da pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7FAFC),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Meu perfil'),
              ),
            ),
            TextButton.icon(
              
              onPressed: (){

            }, 
            icon: Icon(Icons.home,color: Colors.black),
            label: Text('inicio', style: TextStyle(color: Colors.black),)),

            SizedBox(height: 16.0,),

            TextButton.icon(
              
              onPressed: () async {
                bool saiu = await sair();
                if (saiu) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
              },
              icon: Icon(Icons.exit_to_app, color: Colors.black,),
              label: Text('Sair',style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Boas vindas,',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF718096),
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${perfil?['first_name']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF0D0D0D),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${perfil?['last_name']}',
                                    style: const TextStyle(
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
                                  color: const Color(0xFFE4EFFF)),
                              child: IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openEndDrawer();
                                  },
                                  icon: Icon(Icons.menu_open)),
                            ),
                            // Container(
                            //   child: TextButton(
                            //       onPressed: () async {
                            //         bool saiu = await sair();
                            //         if (saiu) {
                            //           Navigator.pushNamedAndRemoveUntil(
                            //               context, '/', (route) => false);
                            //         }
                            //       },
                            //       child: Text('Sair')),
                            // )
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  getperfil() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      var url = Uri.https('marquei-api.fly.dev', '/api/professionals/me/');

      Map<String, String> headers = {
        'Authorization': token,
      };

      var response = await http.get(
        url,
        headers: headers, // Convertendo o corpo para JSON
      );

      Map<String, dynamic> perfilMap = json.decode(response.body);
      setState(() {
        perfil = perfilMap;
      });
    }
  }
}
