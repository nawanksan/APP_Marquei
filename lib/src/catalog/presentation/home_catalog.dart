import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF002AFF),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
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
                  ),
                ),
                const SizedBox(height: 10),
                _buildSectionHeader('Categorias'),
                const SizedBox(height: 8),
                _buildCategoryList(),
                const SizedBox(height: 20),
                _buildSectionHeader('Serviços'),
                const SizedBox(height: 8),
                _buildServiceList(),
              ],
            ),
          ),
        ),
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
                ))),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // ação ao apertar no primeiro card
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome da Categoria 1',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text(
                  'Descrição da Categoria 1...',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome da Categoria 2',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 3),
                Text(
                  'Descrição da Categoria 2...',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceList() {
    return Column(
      children: [
        _buildServiceCard(),
        const SizedBox(height: 10),
        _buildServiceCard(),
      ],
    );
  }

  Widget _buildServiceCard() {
    return GestureDetector(
      onTap: () {},
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome do Serviço',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('R\$ 50,00',
                      style: TextStyle(
                        color: Color(0xFF002AFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                  SizedBox(height: 10),
                  Text('30min',
                      style: TextStyle(
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
