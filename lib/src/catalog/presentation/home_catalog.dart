import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, perfil});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<dynamic>? servicos; // Altere para lista de serviços
  List<dynamic>? category;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfessionalServices();
    fetchProfessionalCategories();
  }

  Future<void> fetchProfessionalServices() async {
    String? token = await getToken();

    if (token != null) {
      final url =
          Uri.parse('https://api.marquei.pro/api/services/professional/me/');

      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Converte a resposta para um Map
        final responseBody = jsonDecode(response.body);
        // print(response.body);
        if (mounted) {
          setState(() {
            // Acessa a lista de resultados dentro de 'results'
            servicos =
                responseBody['results']; // 'results' contém a lista de serviços
            isLoading = false;
          });
        }
      } else {
        print('Erro ao carregar os serviços. Status: ${response.statusCode}');
      }
    } else {
      print('Token não encontrado');
    }
  }

  Future<void> fetchProfessionalCategories() async {
    String? token = await getToken();

    if (token != null) {
      final url =
          Uri.parse('https://api.marquei.pro/api/professionals/category/');

      final response = await http.get(
        url,
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Converte a resposta para um Map
        final responseBody = jsonDecode(response.body);
        // print(response.body);
        if (mounted) {
          setState(() {
            // Acessa a lista de resultados dentro de 'results'
            category =
                responseBody['results']; // 'results' contém a lista de serviços
            isLoading = false;
          });
        }
      } else {
        print('Erro ao carregar as category. Status: ${response.statusCode}');
      }
    } else {
      print('Token não encontrado');
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
          onPressed: () {},
          backgroundColor: const Color(0xFF002AFF),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: const Color(0xFF002AFF),
              ))
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
                            const SizedBox(height: 10),
                            _buildSectionHeader('Categorias'),
                            const SizedBox(height: 8),
                            _buildCategoryList(),
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

  Widget _buildCategoryList() {
    if (category == null || category!.isEmpty) {
      return const Text("Nenhuma categoria disponível");
    }

    final categoriesToShow = category!.take(2).toList();

    return Column(
      children: categoriesToShow.map<Widget>((cat) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cat['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
        print('Serviço selecionado: ${servico['name']}');
      },
      child: Container(
        width: double.infinity,
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
              height: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/1280'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
                  Text('${servico['duration']} min',
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

  //chamar função que pega o token do usuario e adiciona na rota de serviços para pegar todos os serviços daquele usuario
}
