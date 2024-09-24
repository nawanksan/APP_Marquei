import 'package:flutter/material.dart';
import 'package:marquei/src/finances/presentation/widgets/chart_widget.dart';

class HomeFinance extends StatefulWidget {
  const HomeFinance({super.key});

  @override
  State<HomeFinance> createState() => _HomeFinanceState();
}

class _HomeFinanceState extends State<HomeFinance> {
  String dropdownValue = 'Set/2024';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finanças',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 24,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Relatório',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Set/2024', 'Ago/2024', 'Out/2024']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const ChartWidget(),

            const SizedBox(height: 16),
            const Text(
              'Setembro de 2024',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 16),
            // Informações de Receita, Valores e Serviços
            const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R\$ 0,00',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Receita total',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF718096)),
                          ),
                        ],
                      ),
                      SizedBox(width: 100),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R\$ 0,00',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Valores não pagos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF718096)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'R\$ 0,00',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Venda de serviços',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF718096)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Color(0xFFE2E8F0),
                    height: 20,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '0',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Clientes Atendidos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF718096)),
                          ),
                        ],
                      ),
                      SizedBox(width: 100),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R\$ 0,00',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Média por cliente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Color(0xFF718096)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Serviços vendidos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF718096)),
                      ),
                    ],
                  ),
                ])
            // Table(
            //   children: const [
            //     TableRow(children: [
            //       Text('R\$ 0,00\nReceita total', textAlign: TextAlign.center),
            //       Text('R\$ 0,00\nValores não pagos',
            //           textAlign: TextAlign.center),
            //     ]),
            //     TableRow(children: [
            //       Text('R\$ 0,00\nVenda de combos',
            //           textAlign: TextAlign.center),
            //       Text('R\$ 0,00\nVenda de serviços',
            //           textAlign: TextAlign.center),
            //     ]),
            //     TableRow(children: [
            //       Text('0\nClientes atendidos', textAlign: TextAlign.center),
            //       Text('R\$ 0,00\nMédia por cliente',
            //           textAlign: TextAlign.center),
            //     ]),
            //     TableRow(children: [
            //       Text('0\nServiços vendidos', textAlign: TextAlign.center),
            //       Text('0\nCombos vendidos', textAlign: TextAlign.center),
            //     ]),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
