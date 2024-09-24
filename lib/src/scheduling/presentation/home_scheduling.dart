import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marquei/src/scheduling/presentation/view_scheduling.dart';
import 'package:table_calendar/table_calendar.dart';

class DaysListWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DaysListWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

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
        selectedDate.subtract(Duration(days: selectedDate.weekday % 7));
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
                widget.onDateSelected(day);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _getWeekdayName(day.weekday),
                      style: TextStyle(
                        color: day.day == widget.selectedDate.day
                            ? Colors.white
                            : const Color(0xFF718096),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${day.day}',
                      style: TextStyle(
                        color: day.day == widget.selectedDate.day
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'SEG';
      case 2:
        return 'TER';
      case 3:
        return 'QUA';
      case 4:
        return 'QUI';
      case 5:
        return 'SEX';
      case 6:
        return 'SÁB';
      case 7:
      default:
        return 'DOM';
    }
  }
}

class MonthSelectorWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  // ignore: prefer_const_constructors_in_immutables
  MonthSelectorWidget({super.key, required this.onDateSelected});

  @override
  // ignore: library_private_types_in_public_api
  _MonthSelectorWidgetState createState() => _MonthSelectorWidgetState();
}

class _MonthSelectorWidgetState extends State<MonthSelectorWidget> {
  DateTime _selectedDate = DateTime.now();
  DateTime _monthSelected = DateTime.now();
  bool _isCalendarVisible = false;

  void _toggleCalendar() {
    setState(() {
      _isCalendarVisible = !_isCalendarVisible;
      _monthSelected = _selectedDate;
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
      _monthSelected = focusedDay;
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
                getMonthNameWithYear(_monthSelected),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                _isCalendarVisible
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined,
                color: const Color(0xFF718096),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        AnimatedCrossFade(
          firstChild: DaysListWidget(
            selectedDate: _selectedDate,
            onDateSelected: _onDateSelected,
          ),
          secondChild: TableCalendar(
            focusedDay: _monthSelected,
            firstDay: DateTime(2000),
            lastDay: DateTime(2101),
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                List<String> daysOfWeek = ["D", "S", "T", "Q", "Q", "S", "S"];
                return Center(
                  child: Text(
                    daysOfWeek[day.weekday % 7],
                    style: const TextStyle(
                      color: Color(0xFF718096),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF002AFF),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Color(0xFF2D3748),
                fontWeight: FontWeight.w600,
              ),
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
          crossFadeState: _isCalendarVisible
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
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

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  List<Map<String, dynamic>> appointments = [
    {
      'id': 8,
      'date': '27/08/2024',
      'hour': '19:00',
      'status': 'ACCOMPLISHED',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Corte',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Uvinha',
    },
    {
      'id': 8,
      'date': '27/08/2024',
      'hour': '19:00',
      'status': 'ACCOMPLISHED',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Corte',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Uvinha',
    },
    {
      'id': 8,
      'date': '27/08/2024',
      'hour': '19:00',
      'status': 'ACCOMPLISHED',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Corte',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Houston Barros',
    },
    {
      'id': 8,
      'date': '27/08/2024',
      'hour': '19:00',
      'status': 'ACCOMPLISHED',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Corte',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Uvinha',
    },
    {
      'id': 8,
      'date': '27/08/2024',
      'hour': '19:00',
      'status': 'ACCOMPLISHED',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Corte',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Uvinha',
    },
    {
      'id': 7,
      'date': '28/08/2024',
      'hour': '17:45',
      'status': 'PENDING',
      'value': 50.0,
      'services_total_time': '00:30',
      'services': [
        {
          'name': 'Barba',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
        {
          'name': 'Tete',
          'description': 'dadada',
          'value': 50.0,
          'duration': '00:30',
          'photo':
              '/media/images/professionals/11/Cores-para-parede-externa-2020-05.jpg',
          'category': 'Teste',
        },
      ],
      'client': null,
      'name_client': 'Uvinha',
    },
  ];

  List<Map<String, dynamic>> get filteredAppointments {
    return appointments
        .where((appointment) =>
            appointment['date'] ==
            "${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}")
        .toList();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFF002AFF),
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FAFC),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF002AFF),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFe2e8f0),
                      width: 1,
                    ),
                  ),
                ),
                child: MonthSelectorWidget(
                  onDateSelected: _onDateSelected,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = filteredAppointments[index];
                    return SchedulingCard(appointment: appointment);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchedulingCard extends StatefulWidget {
  final Map<String, dynamic> appointment;

  const SchedulingCard({super.key, required this.appointment});

  @override
  // ignore: library_private_types_in_public_api
  _SchedulingCardState createState() => _SchedulingCardState();
}

class _SchedulingCardState extends State<SchedulingCard> {
  Color _backgroundColor = Colors.white;

  void _onTapCard() {
    setState(() {
      _backgroundColor = const Color(0xFFFAFCFF);
    });

    // Após um curto período, a cor é restaurada
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _backgroundColor = Colors.white;
      });

      // Adicione aqui a navegação para a próxima página, se necessário
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentDetailsPage(
            appointmentId: widget.appointment['id'].toString(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapCard,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xFFe2e8f0),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.appointment['hour'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.appointment['services_total_time'],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF718096),
                          image: widget.appointment['client'] != null &&
                                  widget.appointment['client']['photo'] !=
                                      null &&
                                  widget
                                      .appointment['client']['photo'].isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      widget.appointment['client']['photo']),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: widget.appointment['client'] == null ||
                                (widget.appointment['client']['photo'] ==
                                        null ||
                                    widget
                                        .appointment['client']['photo'].isEmpty)
                            ? Center(
                                child: Text(
                                  _getInitials(
                                      widget.appointment['client'] != null
                                          ? widget.appointment['client']['name']
                                          : widget.appointment['name_client']),
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
                      const SizedBox(width: 10),
                      Text(
                        widget.appointment['client'] != null
                            ? widget.appointment['client']['name']
                            : widget.appointment['name_client'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/home.svg',
                        width: 14,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF2d3748), BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        (widget.appointment['services']
                                as List<Map<String, dynamic>>)
                            .map<String>((service) => service['name'] as String)
                            .join(', '),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF718096),
                          fontFamily: 'Inter',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/home.svg',
                        width: 14,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF2d3748), BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _transformToReal(widget.appointment['value']),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF718096),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                          _colorFromStatus(widget.appointment['status']))),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.appointment['status'] == 'PENDING'
                          ? 'Pendente'
                          : widget.appointment['status'] == 'ACCOMPLISHED'
                              ? 'Realizado'
                              : 'Cancelado',
                      style: TextStyle(
                        color: Color(
                          int.parse(_colorTextFromStatus(
                              widget.appointment['status'])),
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getInitials(String name) {
  final nameParts = name.split(' ');
  if (nameParts.length > 1) {
    return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
  }
  return name.isNotEmpty ? name[0].toUpperCase() : '';
}

String _transformToReal(double value) {
  String valueString = value.toStringAsFixed(2);

  List<String> parts = valueString.split('.');
  String integerPart = parts[0];
  String decimalPart = parts[1];

  String formattedIntegerPart = '';
  for (int i = integerPart.length - 1, j = 0; i >= 0; i--, j++) {
    if (j > 0 && j % 3 == 0) {
      formattedIntegerPart = '.$formattedIntegerPart';
    }
    formattedIntegerPart = integerPart[i] + formattedIntegerPart;
  }

  return 'R\$ $formattedIntegerPart,$decimalPart';
}

String _colorFromStatus(String status) {
  switch (status) {
    case 'PENDING':
      return '0xFFFFF3E4';
    case 'ACCOMPLISHED':
      return '0xFF68d391';
    case 'CANCELED':
      return '0xFF68d391';
    default:
      return '0xFF71AD96';
  }
}

String _colorTextFromStatus(String status) {
  switch (status) {
    case 'PENDING':
      return '0xFFFF9900';
    case 'ACCOMPLISHED':
      return '0xFFFFFFFF';
    case 'CANCELED':
      return '0xFF68d391';
    default:
      return '0xFFFFFFFF';
  }
}
