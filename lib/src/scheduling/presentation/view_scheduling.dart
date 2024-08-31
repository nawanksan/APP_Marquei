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
    //   // Tratar erros de requisição
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   print('Erro: $e');
    // }
    setState(() {
      _appointmentDetails = {
        "id": 1,
        "date": "15/07/2024",
        "hour": "18:00",
        "status": "RESCHEDULED",
        "value": 50,
        "services_total_time": "00:15",
        "services": [
          {
            "name": "AAAAAAAAA",
            "description": "dadada",
            "value": 50,
            "duration": "00:30",
            "photo":
                "/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg",
            "category": "Teste"
          }
        ],
        "client": {"first_name": "Houstonb", "last_name": "Clientela"},
        "name_client": null
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Agendamento'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _appointmentDetails == null
              ? const Center(child: Text('Erro ao carregar os detalhes'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horário: ${_appointmentDetails!['hour']}',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Cliente: ${_appointmentDetails!['client']['name']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Serviços: ${(_appointmentDetails!['services'] as List).map((service) => service['name']).join(', ')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Valor: ${_appointmentDetails!['value']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // Adicione mais detalhes conforme necessário
                    ],
                  ),
                ),
    );
  }
}
