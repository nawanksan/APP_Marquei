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

  @override
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                                  width: 55,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFE4EFFF),
                                  ),
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 225,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 16.0),
                                                    child: Text(
                                                      '${perfil?['first_name']} ${perfil?['last_name']}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(Icons.person),
                                                    title:
                                                        const Text('Configurações de conta', style: TextStyle(fontWeight: FontWeight.bold),),
                                                    onTap: () {
                                                      // Ação para acessar o perfil
                                                      Navigator.pop(context);
                                                      // Navegar para a tela de perfil
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(Icons.help),
                                                    title: const Text('Fale conosco', style: TextStyle(fontWeight: FontWeight.bold),),
                                                    onTap: () {
                                                      // Ação para acessar os pedidos
                                                      // Navigator.pop(context);
                                                      // Navegar para a tela de pedidos
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(Icons.exit_to_app),
                                                    title: const Text('Sair', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                                                    onTap: () async{
                                                      bool saiu = await sair();
                                                      if (saiu) {
                                                        Navigator.pushNamedAndRemoveUntil(
                                                            // ignore: use_build_context_synchronously
                                                            context, '/', (route) => false);
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'HB',
                                      style: TextStyle(
                                          color: Color(0xFF2D3748),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
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
                          fontSize: 15,
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 20),
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
                          child: Row(
                            children: [
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //PARTE QUE FICA OS AGENDAMENTOS

                      const Text(
                        'Seus Próximos Agendamentos',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 130,
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
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(5),
                                    //   color: const Color(0xFFE4EFFF),
                                    // ),
                                    alignment: Alignment.center,
                                    child: const Column(
                                      children: [
                                        Text(
                                          '27',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          'abr',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sábado, 27 de abr 2024 18:00hs',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Corte de Cabelo',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF002AFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Cliente: Kawan-san',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 130,
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
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(5),
                                    //   color: const Color(0xFFE4EFFF),
                                    // ),
                                    alignment: Alignment.center,
                                    child: const Column(
                                      children: [
                                        Text(
                                          '28',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          'abr',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sábado, 28 de abr 2024 10:00hs',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Barba',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF002AFF),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Cliente: Houston barros',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF0D0D0D),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //PARTE QUE FICA OS MELHORES SERVIÇOS

                      const Text(
                        'Melhores Serviços',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFE4EFFF),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '13',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFF002AFF)),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Corte de Cabelo',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Mês passado: 13 agendamentos',
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFE4EFFF),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '9',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFF002AFF)),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Barba',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Mês passado: 9 agendamentos',
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFE4EFFF),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '5',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFF002AFF)),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Degradê',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Mês passado: 5 agendamentos',
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Últimas Atividades',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF0D0D0D),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Ver mais',
                                style: TextStyle(color: Color(0xFF002AFF)),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFE4EFFF),
                                ),
                                child: Icon(Icons.add_box),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Novo Serviço criado: Barbearia'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: const Color(0xFFE2E8F0), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFFE4EFFF),
                                ),
                                child: Icon(Icons.add_box),
                                alignment: Alignment.center,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Novo Serviço criado: Barbaterapia'),
                                  Text('criado em 27/04/23 13:38')
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
