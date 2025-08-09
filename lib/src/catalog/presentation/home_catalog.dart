import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, perfil});

  @override
  CatalogScreenState createState() => CatalogScreenState();
}

class CatalogScreenState extends State<CatalogScreen> with RouteAware {
  List<dynamic>? servicos;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfessionalServices();
  }

  @override
  void didPopNext() {
    // Atualize a lista quando voltar para esta tela
    fetchProfessionalServices();
  }

  Future<void> fetchProfessionalServices() async {
  // Simula delay de carregamento, se quiser
  await Future.delayed(Duration(seconds: 1));

  // Lista local simulando os serviços do profissional
  List<Map<String, dynamic>> servicosLocais = [
    {
      "name": "Corte de Cabelo",
      "description": "Corte masculino clássico",
      "value": 30.0,
      "duration": "00:30:00",
      "photo": "assets/images/corte_cabelo.png",
      "category": "Cabelo",
    },
    {
      "name": "Barba",
      "description": "Aparar e modelar barba",
      "value": 20.0,
      "duration": "00:15:00",
      "photo": "assets/images/barba.png",
      "category": "Barba",
    },
    {
      "name": "Manicure",
      "description": "Manicure básica",
      "value": 25.0,
      "duration": "00:45:00",
      "photo": "assets/images/manicure.png",
      "category": "Unhas",
    },
  ];

  if (mounted) {
    setState(() {
      servicos = servicosLocais;
      isLoading = false;
    });
  }
}


  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _refresh() async {
    await fetchProfessionalServices();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFF002AFF),
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAFC),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('adicioanr');
            Navigator.pushNamed(context, '/add_service');
          },
          backgroundColor: const Color(0xFF002AFF),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF002AFF),
                ),
              )
            : servicos != null
                ? SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Catálogo',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSectionHeader('Serviços'),
                            const SizedBox(height: 8),
                            _buildServiceList(), // Atualize para exibir os serviços
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: Text("Nenhum serviço disponível")),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Ver mais',
              style: TextStyle(
                color: Color(0xFF002AFF),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Inter',
              )),
        ),
      ],
    );
  }

  Widget _buildServiceList() {
    if (servicos == null || servicos!.isEmpty) {
      return const Center(
        child: Text('Nenhum serviço disponível'),
      );
    }

    return Column(
      children: servicos!.map((service) {
        return _buildServiceCard(service);
      }).toList(),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> servico) {
    return GestureDetector(
      onTap: () {
        // print('Serviço selecionado: ${servico['id']}');
        Navigator.pushNamed(context, '/ver_servico', arguments: servico['id']);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://api.marquei.pro${servico['photo']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    servico['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('R\$ ${servico['value']}',
                      style: const TextStyle(
                        color: Color(0xFF002AFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 10),
                  Text(getDuration(servico['duration']),
                      style: const TextStyle(
                        color: Color(0xFF718096),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getDuration(String duration) {
  final List<String> durationList = duration.split(':');
  final int hours = int.parse(durationList[0]);
  final int minutes = int.parse(durationList[1]);

  if (hours == 0) {
    return '${minutes}min';
  } else if (minutes == 0) {
    return '${hours}h';
  } else {
    return '${hours}h${minutes}min';
  }
}
