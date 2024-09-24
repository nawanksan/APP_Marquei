import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Servico extends StatefulWidget {
  @override
  _ServicoState createState() => _ServicoState();
}

class _ServicoState extends State<Servico> {
  Map<String, dynamic>? servicoDetails;

  @override
  void initState() {
    super.initState();
    // Chamamos a função que busca os detalhes do serviço ao iniciar a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getServicoDetails();
    });
  }

  // Função para buscar os detalhes do serviço pela API
  Future<void> _getServicoDetails() async {
    String? token = await getToken();
    final int? servicoId = ModalRoute.of(context)?.settings.arguments as int?;

    if (servicoId == null) {
      // Se o ID do serviço for nulo, não faz nada
      return;
    }

    final url = Uri.parse('https://api.marquei.pro/api/services/$servicoId/');

    final response = await http.get(
      url,
      headers: {
        'Authorization': token ?? '',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        servicoDetails =
            jsonDecode(response.body); // Armazena os detalhes do serviço
      });
    } else {
      print('Erro ao buscar detalhes do serviço: ${response.body}');
      Navigator.pop(context);
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: servicoDetails == null
          ? const Center(
              child: CircularProgressIndicator(
              color: Color(0xFF002AFF),
            )) // Exibe um loading enquanto carrega
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildImageSection(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildInfoSection(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            image: servicoDetails != null
                ? DecorationImage(
                    image: NetworkImage(
                      'https://api.marquei.pro${servicoDetails!['photo']}',
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Positioned(
          top: 45,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFFFFFFF),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF2D3748),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFFFFFFF),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  key: const Key('GestureDetectorKey'),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 260,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Editar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Color(0xFF718096), size: 15),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(
                                color: Color(0xFFE2E8F0),
                                height: 1,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  // Aparecer um dialogo de confirmação
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Deletar Serviço',
                                            style: TextStyle(
                                              color: Color(0xFF2D3748),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        content: const Text(
                                          'Tem certeza que deseja deletar este serviço?',
                                          style: TextStyle(
                                            color: Color(0xFF2D3748),
                                            fontSize: 16,
                                          ),
                                        ),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: const BorderSide(
                                                  color: Color(0xFFE2E8F0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancelar',
                                                style: TextStyle(
                                                    color: Color(0xFF2D3748),
                                                    fontFamily: 'Inter')),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onPressed: () async {
                                              String? token = await getToken();
                                              final url = Uri.parse(
                                                  'https://api.marquei.pro/api/services/service/${servicoDetails!['id']}/');

                                              final response =
                                                  await http.delete(
                                                url,
                                                headers: {
                                                  'Authorization': token ?? '',
                                                  'Content-Type':
                                                      'application/json',
                                                },
                                              );
                                              if (response.statusCode == 204) {
                                                Navigator.pushNamed(
                                                    context, '/catalog-home');
                                              } else {
                                                print(
                                                    'Erro ao deletar serviço: ${response.body}');
                                              }
                                            },
                                            child: const Text('Deletar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Inter',
                                                )),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Deletar',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Ações',
                        style: TextStyle(
                          color: Color(0xFF2D3748),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Color(0xFF2D3748),
                        size: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              servicoDetails?['name'] ?? 'Nome do Serviço',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            servicoDetails?['description'] ?? 'Descrição do Serviço',
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/hour.svg',
                    width: 20,
                    colorFilter: const ColorFilter.mode(
                        Color(
                          0xFF718096,
                        ),
                        BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text(getDuration(servicoDetails?['duration'] ?? 'Duração'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/money.svg',
                    width: 20,
                    colorFilter: const ColorFilter.mode(
                        Color(
                          0xFF718096,
                        ),
                        BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text('R\$ ${servicoDetails?['value'] ?? 'Preço'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String getDuration(String duration) {
  final List<String> durationList = duration.split(':');
  final int hours = int.parse(durationList[0]);
  final int minutes = int.parse(durationList[1]);

  if (hours == 0) {
    return '$minutes min';
  } else if (minutes == 0) {
    return '$hours h';
  } else {
    return '$hours h $minutes min';
  }
}
