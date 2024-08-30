import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthSelectorWidget extends StatefulWidget {
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
          // Colocar botoes de voltar e avançar mês
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month - 1,
                      _selectedDate.day,
                    );
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month + 1,
                      _selectedDate.day,
                    );
                  });
                },
              ),
            ],
          ),
        if (_isCalendarVisible)
          TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(2000),
              lastDay: DateTime(2101),
              // calendarFormat: CalendarFormat.month,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  // Lista das iniciais dos dias da semana
                  List<String> daysOfWeek = ["D", "S", "T", "Q", "Q", "S", "S"];

                  return Center(
                    child: Text(
                      daysOfWeek[day.weekday %
                          7], // % 7 para ajustar o domingo como índice 0
                      style: const TextStyle(color: Color(0xFF718096)),
                    ),
                  );
                },
              ),
              currentDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFF002AFF),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: const Color(0xFF002AFF).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.black),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                _onDateSelected(selectedDay);
              },
              onPageChanged: (focusedDay) {
                _onMonthChanged(focusedDay);
              },
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              headerVisible: false,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Color(0xFF718096)),
                weekendStyle: TextStyle(color: Color(0xFF718096)),
              )),
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
