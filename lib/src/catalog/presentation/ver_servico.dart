import 'package:flutter/material.dart';

class Servico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Imagem Placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 16),
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
                Icon(Icons.edit, color: Colors.black),
              ],
            ),
            SizedBox(height: 8),
            // Descrição do serviço
            Text(
              'A descrição do serviço vem aqui',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // Informações adicionais
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
            Divider(height: 32, thickness: 1),
            // Título dos últimos agendamentos
            Text(
              'Últimos agendamentos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Lista de agendamentos
            _buildAppointmentRow('Nome do Cliente', '29/08/2024 - 11:30', 'Pendente'),
            _buildAppointmentRow('Nome do Cliente 2', '29/08/2024 - 19:30', 'Pendente'),
          ],
        ),
      ),
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
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.yellow[700],
          ),
        ],
      ),
    );
  }
}
