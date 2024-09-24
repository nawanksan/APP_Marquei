import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class AppointmentDetailsPage extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailsPage({super.key, required this.appointmentId});
  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  Map<String, dynamic>? _appointmentDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentDetails();
  }

  Future<void> _fetchAppointmentDetails() async {
    print(widget.appointmentId);
    // final url =
    //     'https://api.exemplo.com/appointments/${widget.appointmentId}'; // Substitua com sua URL
    // try {
    //   final response = await http.get(Uri.parse(url));

    //   if (response.statusCode == 200) {
    //     setState(() {
    //       _appointmentDetails = json.decode(response.body);
    //       _isLoading = false;
    //     });
    //   } else {
    //     throw Exception('Falha ao carregar os dados do agendamento');
    //   }
    // } catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   print('Erro: $e');
    // }
    // Dados de exemplo para teste
    setState(() {
      _appointmentDetails = {
        "id": 1,
        "date": "13/09/2024",
        "hour": "08:30",
        "status": "Pendente",
        "value": 50,
        "services_total_time": "00:45",
        "services": [
          {
            "name": "Hidratação Capilar",
            "category": "Tratamentos Capilares",
            "value": 60,
            "duration": "00:45",
          }
        ],
        "client": {
          "first_name": "Houston",
          "last_name": "Barros",
          "photo_url": "https://via.placeholder.com/150"
        },
        "payment": {
          "method": "Estabelecimento",
          "status": "Pendente",
          "value": 50
        },
        "observation": "Sem observação"
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Agendamento'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Adicione ações conforme necessário
            },
            itemBuilder: (BuildContext context) {
              return ['Opção 1', 'Opção 2'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _appointmentDetails == null
              ? const Center(child: Text('Erro ao carregar os detalhes'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Seção de informações do cliente
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                _appointmentDetails!['client']['photo_url']),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_appointmentDetails!['client']['first_name']} ${_appointmentDetails!['client']['last_name']}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Seção de Serviços
                      const Text(
                        'Serviços',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildServiceDetails(),
                      const SizedBox(height: 20),
                      // Seção de Atendimento
                      const Text(
                        'Atendimento',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildAppointmentDetails(),
                      const SizedBox(height: 20),
                      // Seção de Pagamento
                      const Text(
                        'Pagamento',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildPaymentDetails(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildServiceDetails() {
    final service = _appointmentDetails!['services'][0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service['name'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text('Categoria: ${service['category']}'),
        Text('Duração: ${service['duration']}'),
        Text('Valor: R\$ ${service['value'].toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildAppointmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
                'Data e horário: ${_appointmentDetails!['date']} - ${_appointmentDetails!['hour']}'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _appointmentDetails!['status'],
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
        Text('Duração: ${_appointmentDetails!['services_total_time']}'),
        Text('Observação: ${_appointmentDetails!['observation']}'),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    final payment = _appointmentDetails!['payment'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Método: ${payment['method']}'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                payment['status'],
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
        Text('Valor: R\$ ${payment['value'].toStringAsFixed(2)}'),
      ],
    );
  }
}

String formatReal(double value) {
  return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
}
