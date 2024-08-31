import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthSelectorWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  MonthSelectorWidget({required this.onDateSelected});

  @override
  _MonthSelectorWidgetState createState() => _MonthSelectorWidgetState();
}

class _MonthSelectorWidgetState extends State<MonthSelectorWidget> {
  DateTime _selectedDate = DateTime.now();
  bool _isCalendarVisible = false;

  void _toggleCalendar() {
    setState(() {
      _isCalendarVisible = !_isCalendarVisible;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _isCalendarVisible = false;
    });
    widget.onDateSelected(date);
  }

  void _onMonthChanged(DateTime focusedDay) {
    setState(() {
      _selectedDate = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _toggleCalendar,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getMonthNameWithYear(_selectedDate),
                style: const TextStyle(fontSize: 24),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        if (_isCalendarVisible)
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2101),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                List<String> daysOfWeek = ["D", "S", "T", "Q", "Q", "S", "S"];
                return Center(
                  child: Text(
                    daysOfWeek[day.weekday % 7],
                    style: const TextStyle(color: Color(0xFF718096)),
                  ),
                );
              },
            ),
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              _onDateSelected(selectedDay);
            },
            onPageChanged: (focusedDay) {
              _onMonthChanged(focusedDay);
            },
            headerVisible: false,
          ),
      ],
    );
  }
}

String getMonthNameWithYear(DateTime selectedDate) {
  final currentYear = DateTime.now().year;
  final monthNames = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  String monthName = monthNames[selectedDate.month - 1];

  if (selectedDate.year != currentYear) {
    monthName += " ${selectedDate.year}";
  }

  return monthName;
}
