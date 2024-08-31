import 'package:flutter/material.dart';

class DaysListWidget extends StatefulWidget {
  final DateTime selectedDate;

  const DaysListWidget({super.key, required this.selectedDate});

  @override
  // ignore: library_private_types_in_public_api
  _DaysListWidgetState createState() => _DaysListWidgetState();
}

class _DaysListWidgetState extends State<DaysListWidget> {
  late List<DateTime> days;

  @override
  void initState() {
    super.initState();
    _generateDaysList(widget.selectedDate);
  }

  void _generateDaysList(DateTime selectedDate) {
    final List<DateTime> generatedDays = [];
    final startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    for (int i = 0; i < 7; i++) {
      generatedDays.add(startOfWeek.add(Duration(days: i)));
    }
    setState(() {
      days = generatedDays;
    });
  }

  @override
  void didUpdateWidget(covariant DaysListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _generateDaysList(widget.selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final day in days)
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Seleciona o dia
                  print(day);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: day.day == widget.selectedDate.day
                      ? const Color(0xFF002AFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 60,
                child: Column(
                  children: [
                    // Qual dia da semana
                    Text(
                      day.weekday == 1
                          ? 'Seg'
                          : day.weekday == 2
                              ? 'Ter'
                              : day.weekday == 3
                                  ? 'Qua'
                                  : day.weekday == 4
                                      ? 'Qui'
                                      : day.weekday == 5
                                          ? 'Sex'
                                          : day.weekday == 6
                                              ? 'Sáb'
                                              : 'Dom',
                      style: TextStyle(
                        color: day.day == widget.selectedDate.day
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),

                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: day.day == widget.selectedDate.day
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
