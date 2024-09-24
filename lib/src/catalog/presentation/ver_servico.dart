import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    final int? servicoId = ModalRoute.of(context)?.settings.arguments as int?;
    if (servicoId == null) {
      // Se o ID do serviço for nulo, não faz nada
      return;
    }

    final String url = 'https://api.marquei.pro/api/services/$servicoId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        servicoDetails = jsonDecode(response.body); // Armazena os detalhes do serviço
      });
    } else {
      print('Erro ao buscar detalhes do serviço: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: servicoDetails == null
          ? Center(child: CircularProgressIndicator()) // Exibe um loading enquanto carrega
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
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                onSelected: (String value) {
                  if (value == 'editar') {
                    print('Editar selecionado');
                  } else if (value == 'deletar') {
                    print('Deletar selecionado');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'editar',
                      child: Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'deletar',
                      child: Text('Deletar'),
                    ),
                  ];
                },
              ),
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            servicoDetails?['description'] ?? 'Descrição do Serviço',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 8),
                  Text(servicoDetails?['duration'] ?? 'Duração'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 8),
                  Text('R\$ ${servicoDetails?['value'] ?? 'Preço'}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
