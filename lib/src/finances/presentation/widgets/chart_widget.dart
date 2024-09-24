import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key});

  @override
  ChartWidgetState createState() => ChartWidgetState();
}

class ChartWidgetState extends State<ChartWidget> {
  String selectedMonth = ''; // Armazena o mês selecionado

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Altura do gráfico
      child: SfCartesianChart(
        borderWidth: 0,
        plotAreaBorderWidth: 0,
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(
            color: Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        primaryYAxis: const NumericAxis(
          isVisible: false, // Oculta o eixo Y
          majorGridLines: MajorGridLines(width: 0),
          plotOffset: 2,
        ),
        series: <CartesianSeries<dynamic, dynamic>>[
          ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData sales, _) => sales.month,
            yValueMapper: (ChartData sales, _) =>
                sales.value > 0 ? sales.value : 80,
            color: const Color(0xFF002AFF),
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            width: 0.8,
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

final List<ChartData> data = [
  ChartData('Jul', 2000),
  ChartData('Ago', 1000),
  ChartData('Set', 0),
  ChartData('Out', 0),
  ChartData('Nov', 0),
  ChartData('Dez', 0),
];

// Classe para armazenar os dados do gráfico
class ChartData {
  ChartData(this.month, this.value);
  final String month;
  final double value;
}
