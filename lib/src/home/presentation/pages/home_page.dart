import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquei/src/home/presentation/widgets/custom_statics.dart';
import 'package:marquei/widgets/custom_appbar.dart';
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
    initUserProfile();
  }

  Future<void> initUserProfile() async {
    perfil = await getUserProfile();
    setState(() {}); // Atualiza o estado para refletir as mudanças
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF7FAFC),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: CustomAppBar(perfil: perfil, sair: sair),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
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
                        CustomStatics(
                          iconPath: 'lib/assets/icons/calendar_heart.svg',
                          text: 'Agendamentos',
                          count: '12',
                          date: 'Hoje',
                          // onTap: () => {
                          //   // Ações para abrir a tela de agendamentos
                          //   print('apertou 3')
                          // },
                        ),
                        const SizedBox(height: 10),
                        CustomStatics(
                          iconPath: 'lib/assets/icons/user_group.svg',
                          text: 'Total de Clientes',
                          count: '74',
                          date: 'Semana',
                          // onTap: () => {
                          //   // Ações para abrir a tela de agendamentos
                          //   //...
                          // },
                        ),
                        const SizedBox(height: 10),
                        CustomStatics(
                          iconPath: 'lib/assets/icons/money.svg',
                          text: 'Faturamento',
                          count: 'R\$ 31.230,00',
                          date: 'Ano',
                          // onTap: () => {
                          //   // Ações para abrir a tela de agendamentos
                          //   //...
                          // },
                        ),
                        const SizedBox(height: 30),
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
                        InkWell(
                          onTap: () {
                            print('apertou');
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '27',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'abr',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w600,
                                                height: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'De 10:00 às 11:00',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF0D0D0D),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE4EFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 3, 8, 3),
                                                  child: Text(
                                                    'Agendado',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFF002AFF),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            'Kawan Nascimento',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            'Serviços selecionados: 1',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF0D0D0D),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'R\$ 30,00',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Dinheiro',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF718096),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            print('apertou 2');
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
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '28',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'abr',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w600,
                                                height: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'De 10:00 às 11:00',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF0D0D0D),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFF3E4),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 3, 8, 3),
                                                  child: Text(
                                                    'Pendente',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFFFF9900),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            'Houston Barros',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w800),
                                          ),
                                          const SizedBox(height: 3),
                                          const Text(
                                            'Serviços selecionados: 3',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF0D0D0D),
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'R\$ 40,00',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'PIX',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF718096),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Atalhos',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color(0xFFE2E8F0),
                                            width: 1,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/box.svg',
                                          width: 25,
                                          // ignore: deprecated_member_use
                                          color: const Color(0xFF002AFF),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Agendar',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF0D0D0D),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color(0xFFE2E8F0),
                                            width: 1,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          'lib/assets/icons/box.svg',
                                          width: 25,
                                          // ignore: deprecated_member_use
                                          color: const Color(0xFF002AFF),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Agendar',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF0D0D0D),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
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

  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? perfilJson = prefs.getString('user_profile');
    if (perfilJson != null) {
      return jsonDecode(perfilJson);
    }
    return null;
  }
}
