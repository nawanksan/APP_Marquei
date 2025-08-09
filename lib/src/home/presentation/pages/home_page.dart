import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquei/src/home/presentation/widgets/custom_statics.dart';
import 'package:marquei/src/scheduling/presentation/view_scheduling.dart';
import 'package:marquei/widgets/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic>? perfil;
  Map<String, dynamic>? estatisticas;
  List<dynamic>? agendamentos;
  // String? token;  // Variável para armazenar as estatísticas

  @override
  void initState() {
    super.initState();
    initUserProfile();
  }

  Future<void> initUserProfile() async {
    try {
      final fetchedPerfil = await getUserProfile();
      print(fetchedPerfil);

      // Usar dados locais mockados no lugar de buscar na API
      final fetchedEstatisticas = await fetchProfessionalStatistics() ??
          {
            "schedules_today": 0,
            "clients": 0,
            "invoicing": 0.0,
          };

      final fetchedAgendamentos = await fetchProfessionalAgendamentos() ??
          [
            {
              "id": 1,
              "date": "2025/08/10",
              "hour": "14:00",
              "status": "confirmado",
              "value": 50.0,
              "services_total_time": "00:30:00",
              "services": [
                {
                  "name": "Corte de cabelo",
                  "description": "Corte masculino",
                  "value": 50.0,
                  "duration": "00:30:00",
                  "photo": "assets/images/corte_cabelo.png",
                  "category": "Cabelo",
                }
              ],
              "client": {
                "first_name": "João",
                "last_name": "Silva",
              },
              "name_client": "João Silva",
            }
          ];

      setState(() {
        perfil = fetchedPerfil;
        estatisticas = fetchedEstatisticas;
        agendamentos = fetchedAgendamentos;
      });
    } catch (error) {
      print("Erro ao inicializar perfil: $error");
    }
  }

// Mock: retorna perfil salvo no SharedPreferences (igual você já tem)
  Future<Map<String, dynamic>?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? perfilJson = prefs.getString('user_profile');
    if (perfilJson != null) {
      return jsonDecode(perfilJson);
    }
    return null;
  }

// Mock local, sem usar API
  Future<List<dynamic>?> fetchProfessionalAgendamentos() async {
    // Simula delay
    await Future.delayed(Duration(milliseconds: 500));
    // Retorna null para usar o valor padrão no initUserProfile()
    return null;
  }

// Mock local, sem usar API
   Future<void> _refresh() async {
    await initUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFF002AFF),
      onRefresh: _refresh,
      child: perfil == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF002AFF),
              ), // Mostra o círculo de carregamento enquanto `perfil` for nulo
            )
          : Scaffold(
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
                                count:
                                    '${estatisticas?['schedules_today']}', //${estatisticas?['schedules_today']}
                                date: 'Hoje',
                              ),
                              const SizedBox(height: 10),
                              CustomStatics(
                                iconPath: 'lib/assets/icons/user_group.svg',
                                text: 'Total de Clientes',
                                count:
                                    '${estatisticas?['clients']}', //${estatisticas?['clients']}
                                date: 'Semana',
                              ),
                              const SizedBox(height: 10),
                              CustomStatics(
                                iconPath: 'lib/assets/icons/money.svg',
                                text: 'Faturamento',
                                count:
                                    'R\$ ${estatisticas?['invoicing']}', //${estatisticas?['invoicing']}
                                date: 'Ano',
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
                              agendamentos == null || agendamentos!.isEmpty
                                  ? const Text(
                                      'Nenhum agendamento encontrado.',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: agendamentos!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            print(agendamentos![index]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AppointmentDetailsPage(
                                                  appointmentId:
                                                      agendamentos![index]['id']
                                                          .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color(0xFFE2E8F0),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              agendamentos![
                                                                          index]
                                                                      ['date']
                                                                  .split(
                                                                      '/')[0],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 24,
                                                                color: Color(
                                                                    0xFF000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'De ${agendamentos![index]['hour']} às ${getEndTime(agendamentos![index]['hour'], agendamentos![index]['services_total_time'])}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xFF0D0D0D),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFE4EFFF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          8,
                                                                          3,
                                                                          8,
                                                                          3),
                                                                  child: Text(
                                                                    'Agendado',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color(
                                                                            0xFF002AFF),
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            agendamentos![index]
                                                                        [
                                                                        'client'] !=
                                                                    null
                                                                ? '${agendamentos![index]['client']['first_name']} ${agendamentos![index]['client']['last_name']}'
                                                                : agendamentos![
                                                                        index][
                                                                    'name_client'],
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF000000),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            'Serviços selecionados: ${agendamentos![index]['services'].length}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xFF0D0D0D),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        formatReal(
                                                            agendamentos![index]
                                                                ['value']),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Color(
                                                                0xFF000000),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      const Text(
                                                        'Espécie',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xFF718096),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              const SizedBox(
                                height: 10,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/add_service');
                                      },
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: const Color(0xFFE2E8F0),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE2E8F0),
                                                    width: 1,
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                  'lib/assets/icons/box.svg',
                                                  width: 25,
                                                  // ignore: deprecated_member_use
                                                  color:
                                                      const Color(0xFF002AFF),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Criar serviço',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  color:
                                                      const Color(0xFFE2E8F0),
                                                  width: 1,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                'lib/assets/icons/calendar_heart.svg',
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

  String getMonthName(String month) {
    switch (month) {
      case '01':
        return 'jan';
      case '02':
        return 'fev';
      case '03':
        return 'mar';
      case '04':
        return 'abr';
      case '05':
        return 'mai';
      case '06':
        return 'jun';
      case '07':
        return 'jul';
      case '08':
        return 'ago';
      case '09':
        return 'set';
      case '10':
        return 'out';
      case '11':
        return 'nov';
      case '12':
        return 'dez';
      default:
        return '';
    }
  }

  String getEndTime(String hour, String servicesTotalTime) {
    final hourParts = hour.split(':');
    final servicesTotalTimeParts = servicesTotalTime.split(':');

    final hourInt = int.parse(hourParts[0]);
    final minuteInt = int.parse(hourParts[1]);

    final servicesHourInt = int.parse(servicesTotalTimeParts[0]);
    final servicesMinuteInt = int.parse(servicesTotalTimeParts[1]);

    int endHour = hourInt + servicesHourInt;
    int endMinute = minuteInt + servicesMinuteInt;

    if (endMinute >= 60) {
      endHour += endMinute ~/ 60;
      endMinute = endMinute % 60;
    }

    endHour = endHour % 24;

    return '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';
  }

  String formatReal(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
  
  fetchProfessionalStatistics() {}
}
