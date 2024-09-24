import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppointmentDetailsPage extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailsPage({super.key, required this.appointmentId});
  @override
  appointmentDetailsPageState createState() => appointmentDetailsPageState();
}

class appointmentDetailsPageState extends State<AppointmentDetailsPage> {
  Map<String, dynamic>? appointmentDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAppointmentDetails();
  }

  // Função para buscar os detalhes do serviço pela API
  Future<void> _fetchAppointmentDetails() async {
    String? token = await getToken();
    final int? appointmentId = int.tryParse(widget.appointmentId);

    if (appointmentId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse('https://api.marquei.pro/api/scheduling/$appointmentId/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          appointmentDetails = jsonDecode(response.body);
          _isLoading = false; // Atualiza _isLoading após o sucesso
        });
      } else {
        setState(() {
          _isLoading = false; // Atualiza _isLoading em caso de erro
        });
        Navigator.pop(
            context); // Volta para a tela anterior se houver erro na requisição
      }
    } catch (e) {
      // Tratar erros de conexão ou outros problemas
      setState(() {
        _isLoading =
            false; // Certifique-se de que o loader sempre seja removido
      });
      Navigator.pop(context); // Voltar para a tela anterior em caso de erro
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF002AFF)))
          : appointmentDetails == null
              ? const Center(child: Text('Erro ao carregar os detalhes'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Seção de informações do cliente
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF718096),
                              image: appointmentDetails?['client'] != null &&
                                      appointmentDetails?['client']['photo'] !=
                                          null &&
                                      appointmentDetails?['client']['photo']
                                          .isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          'https://api.marquei.pro${appointmentDetails?['client']['photo']}'),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: appointmentDetails?['client'] == null ||
                                    (appointmentDetails?['client']['photo'] ==
                                            null ||
                                        appointmentDetails?['client']['photo']
                                            .isEmpty)
                                ? Center(
                                    child: Text(
                                      _getInitials(appointmentDetails?[
                                                  'client'] !=
                                              null
                                          ? '${appointmentDetails?['client']['first_name']} ${appointmentDetails?['client']['last_name']}'
                                          : appointmentDetails?['name_client']),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${appointmentDetails!['client']['first_name']} ${appointmentDetails!['client']['last_name']}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Seção de Serviços
                      const Divider(
                        color: Color(0xFFe2e8f0),
                        height: 1,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icons/box.svg',
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF718096),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Serviços',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      _buildServiceDetails(),

                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xFFe2e8f0),
                        height: 1,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'lib/assets/icons/hour.svg',
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF718096),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Atendimento',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              appointmentDetails!['status'] == 'scheduled'
                                  ? 'Agendado'
                                  : 'Pendente',
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildAppointmentDetails(),

                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xFFe2e8f0),
                        height: 1,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'lib/assets/icons/money.svg',
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF718096),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Pagamento',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Pago',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildPaymentDetails(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildServiceDetails() {
    final service = appointmentDetails!['services'][0];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service['name'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Categoria',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(service['category'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Duração',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(getDuration(service['duration']),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Valor',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(formatReal(service['value']),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Data e horário',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(
                '${appointmentDetails!['date']} - ${appointmentDetails!['hour']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Duração',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(getDuration(appointmentDetails!['services_total_time']),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Observação',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(
                appointmentDetails!['observation'].isEmpty
                    ? 'Sem observações'
                    : appointmentDetails!['observation'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    final payment = appointmentDetails!['payment'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Método',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text('Espécie',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Valor',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF718096))),
            Text(formatReal(payment['value']),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ],
    );
  }
}

String formatReal(double value) {
  return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
}

String _getInitials(String name) {
  final nameParts = name.split(' ');
  if (nameParts.length > 1) {
    return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
  }
  return name.isNotEmpty ? name[0].toUpperCase() : '';
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
