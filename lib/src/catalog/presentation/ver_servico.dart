import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Servico extends StatelessWidget {
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Imagem Placeholder
          _buildImageSection(),
          // Informações centrais
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
    // String? selectedAction; // Variável para armazenar a ação selecionada

    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(''),
            actions: [
              SizedBox(width: 8), // Espaço entre o dropdown e a borda
              Text('Ações'), // Nome "Ações" ao lado esquerdo

              // Dropdown para ações
              PopupMenuButton<String>(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                onSelected: (String value) {
                  // Ações a serem realizadas quando o item do menu é selecionado
                  if (value == 'editar') {
                    // Coloque aqui a lógica para editar
                    
                    print('Editar selecionado');
                  } else if (value == 'deletar') {
                    // Coloque aqui a lógica para deletar
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Raio das bordas
                ),
                color: Colors.white, // Cor de fundo do menu
              ), // Espaço entre "Ações" e o ícone de editar
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
        // Título e ícone de edição
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nome do Serviço',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        // Descrição do serviço
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'A descrição do serviço vem aqui',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 16),
        // Informações adicionais alinhadas à esquerda
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 8),
                  Text('30min'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.category),
                  SizedBox(width: 8),
                  Text('Categoria'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(width: 8),
                  Text('R\$ 50,00'),
                ],
              ),
            ],
          ),
        ),
        Divider(height: 32, thickness: 1),
        // Título dos últimos agendamentos
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Últimos agendamentos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        // Lista de agendamentos
        _buildAppointmentRow(
            'Nome do Cliente', '29/08/2024 - 11:30', 'Pendente'),
        _buildAppointmentRow(
            'Nome do Cliente 2', '29/08/2024 - 19:30', 'Pendente'),
      ],
    );
  }

  Widget _buildAppointmentRow(String name, String date, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(date),
            ],
          ),
          Chip(
            label: Text(
              status,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.yellow[500],
            side: BorderSide.none,
          ),
        ],
      ),
    );
  }
}
