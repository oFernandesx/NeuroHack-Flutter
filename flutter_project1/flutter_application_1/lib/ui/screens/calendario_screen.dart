// lib/ui/screens/calendario_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/nav_button_bar.dart';
import 'package:intl/intl.dart'; 
import 'package:table_calendar/table_calendar.dart'; 

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({Key? key}) : super(key: key);

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  int _selectedIndex = 1;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  final Map<DateTime, List<Map<String, String>>> _events = {

    DateTime.utc(2025, 6, 5): [{'name': 'Corrida Matinal', 'time': '07:00'}],
    DateTime.utc(2025, 6, 7): [{'name': 'Natação', 'time': '10:00'}],
    DateTime.utc(2025, 6, 8): [{'name': 'Reunião de Equipe', 'time': '14:00'}, {'name': 'Apresentação', 'time': '15:00'}],
    DateTime.utc(2025, 6, 12): [{'name': 'Almoço com Cliente', 'time': '12:00'}], 
    DateTime.utc(2025, 6, 15): [{'name': 'Aniversário da Ana', 'time': '19:00'}],
    DateTime.utc(2025, 6, 19): [{'name': 'Treino de Força', 'time': '06:00'}],
    DateTime.utc(2025, 6, 22): [{'name': 'Palestra Online', 'time': '11:00'}],
    DateTime.utc(2025, 6, 23): [
      {'name': 'Alongamento', 'time': '15:30 - 16:40'},
      {'name': 'Meditação', 'time': '17:20'},
      {'name': 'Corrida', 'time': '18:00'},
      {'name': 'Academia', 'time': '19:00'},
    ], 
    DateTime.utc(2025, 6, 28): [{'name': 'Festa de Encerramento', 'time': '20:00'}],
  };

  @override
  void initState() {
    super.initState();

    _focusedDay = DateTime.utc(2025, 6, 1); 
    _selectedDay = null; 
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/tarefas_screen');
      } else if (index == 1) {
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/perfil_screen');
      }
    });
  }


  List<Map<String, String>> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }


  void _addEventToMap(Map<String, String> newEvent) {
    setState(() {
      final selectedDate = _selectedDay ?? _focusedDay;
      final normalizedDate = DateTime.utc(selectedDate.year, selectedDate.month, selectedDate.day);
      if (_events[normalizedDate] == null) {
        _events[normalizedDate] = [];
      }
      _events[normalizedDate]!.add(newEvent);
    });
  }


  void _showAddEventModal(BuildContext context) async {
    final selectedDateForNewEvent = _selectedDay ?? _focusedDay;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
      builder: (context) {
        return _AddEventForm(
          selectedDate: selectedDateForNewEvent,
          onAdd: _addEventToMap, 
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentMonth = DateFormat('MMMM', 'pt_BR').format(_focusedDay);

    return Scaffold(
      backgroundColor: const Color(0XFFDDEBF3), 
      body: Column(
        children: [
      
          Container(
            color: const Color(0XFFDDEBF3),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Text(
                      currentMonth,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TableCalendar(
                locale: 'pt_BR', 
                firstDay: DateTime.utc(2025, 6, 1), 
                lastDay: DateTime.utc(2025, 6, 30), 
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = DateTime.utc(selectedDay.year, selectedDay.month, 1);
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                headerVisible: false,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  weekendStyle:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                daysOfWeekHeight: 58.0,
                calendarStyle: const CalendarStyle(
                  cellMargin: EdgeInsets.all(4.0), 
                  cellAlignment: Alignment.center,
                  isTodayHighlighted: false, 
                  defaultDecoration: BoxDecoration(), 
                  weekendDecoration: BoxDecoration(), 
                  todayDecoration: BoxDecoration(), 
                  selectedDecoration: BoxDecoration(), 
                  markerDecoration: BoxDecoration(), 
                  outsideDaysVisible: true, 
                ),
                eventLoader: _getEventsForDay,
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final weekday = DateFormat.E('pt_BR').format(day);
                    String text;
                    switch (weekday) {
                      case 'dom': text = 'D'; break;
                      case 'seg': text = 'S'; break;
                      case 'ter': text = 'T'; break;
                      case 'qua': text = 'Q'; break;
                      case 'qui': text = 'Q'; break;
                      case 'sex': text = 'S'; break;
                      case 'sáb': text = 'S'; break;
                      default: text = weekday.substring(0, 1).toUpperCase();
                    }
                    return Container(
                      height: 58,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    final events = _getEventsForDay(day);
                    final isOutside = day.month != focusedDay.month; 
                    final isToday = isSameDay(day, DateTime.now());
                    final isSelected = isSameDay(day, _selectedDay);

                    Color boxColor = const Color(0xFFD0E0E8); 
                    if (isOutside) {
                      boxColor = boxColor.withOpacity(0.6); 
                    }
                    if (isSelected) {
                      boxColor = const Color(0XFF213554); 
                    } else if (isToday) { 
                      boxColor = const Color(0xFFD0E0E8);
                    }

                    Color textColor = Colors.black;
                    if (isOutside) {
                      textColor = textColor.withOpacity(0.4); 
                    }
                    if (isSelected) {
                      textColor = Colors.white; 
                    } else if (isToday) { 
                      textColor = Colors.black; 
                    }

                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: isToday && !isSelected
                            ? Border.all(color: Colors.deepOrange, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (events.isNotEmpty && !isSelected)
                              Column(
                                children: List.generate(
                                  events.length > 2 ? 2 : events.length,
                                  (index) => Container(
                                    width: 20,
                                    height: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFF28B66).withOpacity(isOutside ? 0.6 : 1.0), 
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                              ),
                            if (events.isNotEmpty && isSelected)
                              Column(
                                children: List.generate(
                                  events.length > 2 ? 2 : events.length, 
                                  (index) => Container(
                                    width: 20,
                                    height: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFF28B66), // Laranja
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final events = _getEventsForDay(day);
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: const Color(0XFF213554), 
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (events.isNotEmpty)
                              Column(
                                children: List.generate(
                                  events.length > 2 ? 2 : events.length, 
                                  (index) => Container(
                                    width: 20,
                                    height: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFF28B66), 
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final events = _getEventsForDay(day);
                    if (isSameDay(day, _selectedDay)) {
                      return null; 
                    }

                    final bool isDay12 = day.day == 12; 

                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0E0E8), 
                        borderRadius: BorderRadius.circular(10.0),
                        border: isDay12
                            ? null 
                            : Border.all(color: Colors.deepOrange, width: 2), 
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.black, 
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            if (events.isNotEmpty)
                              Column(
                                children: List.generate(
                                  events.length > 2 ? 2 : events.length, 
                                  (index) => Container(
                                    width: 20,
                                    height: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFF28B66), 
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    final events = _getEventsForDay(day);
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0E0E8).withOpacity(0.6), 
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.normal),
                            ),
                            if (events.isNotEmpty)
                              Column(
                                children: List.generate(
                                  events.length > 2 ? 2 : events.length,
                                  (index) => Container(
                                    width: 20,
                                    height: 3,
                                    margin: const EdgeInsets.symmetric(vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFF28B66).withOpacity(0.6), 
                                      borderRadius: BorderRadius.circular(1.5),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0XFF253C58),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
                        itemBuilder: (context, index) {
                          final event =
                              _getEventsForDay(_selectedDay ?? _focusedDay)[index];
                          return _buildEventListItem(event['name']!, event['time']!);
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            enabled: false, 
                            decoration: InputDecoration(
                              hintText:
                                  "Adic. evento em ${DateFormat('dd \'de\' MMMM', 'pt_BR').format(_selectedDay ?? _focusedDay)}",
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector( 
                          onTap: () => _showAddEventModal(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavButtonBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildEventListItem(String eventName, String eventTime) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0), 
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0XFF253C58), 
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.calendar_today, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16.0),
          Container(
            width: 4,
            height: 40,
            color: Colors.deepOrange,
            margin: const EdgeInsets.only(right: 16.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  eventTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _AddEventForm extends StatefulWidget {
  final DateTime selectedDate; 
  final Function(Map<String, String>) onAdd; 

  const _AddEventForm({
    Key? key,
    required this.selectedDate,
    required this.onAdd,
  }) : super(key: key);

  @override
  __AddEventFormState createState() => __AddEventFormState();
}

class __AddEventFormState extends State<_AddEventForm> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _startTime = TimeOfDay.fromDateTime(now.add(const Duration(minutes: 30)));
    _endTime = TimeOfDay.fromDateTime(now.add(const Duration(hours: 1, minutes: 30)));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {

    final DateTime now = DateTime.now();

    DateTime initialDateTime;
    if (isStartTime) {
      initialDateTime = DateTime(
          now.year, now.month, now.day, _startTime?.hour ?? now.hour, _startTime?.minute ?? now.minute);
    } else {
      initialDateTime = DateTime(
          now.year, now.month, now.day, _endTime?.hour ?? now.hour, _endTime?.minute ?? now.minute);
    }


    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime 
          ? (_startTime ?? TimeOfDay.now()) 
          : (_endTime ?? _startTime ?? TimeOfDay.fromDateTime(initialDateTime.add(const Duration(hours: 1)))), 
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0XFF213554), 
              onPrimary: Colors.white,
              surface: Color(0XFFDDEBF3), 
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: const Color(0XFFDDEBF3), 
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;

          if (_endTime == null ||
              (_startTime!.hour > _endTime!.hour ||
                  (_startTime!.hour == _endTime!.hour && _startTime!.minute > _endTime!.minute))) {
            _endTime = TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24) _endTime = TimeOfDay(hour: 23, minute: 59); 
          }
        } else {
          _endTime = picked;

          if (_startTime != null &&
              (_startTime!.hour > _endTime!.hour ||
                  (_startTime!.hour == _endTime!.hour && _startTime!.minute > _endTime!.minute))) {

            _endTime = TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24) _endTime = TimeOfDay(hour: 23, minute: 59); 
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7 + bottomPadding, 
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0 + bottomPadding), 
      decoration: const BoxDecoration(
        color: Color(0XFF253C58), 
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const Text(
            'Título',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Título do Evento',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),


          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Horário',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEE, dd \'de\' MMM.', 'pt_BR').format(widget.selectedDate),
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                      ),
                      Text(
                        _startTime != null ? _startTime!.format(context) : '00:00',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward, color: Colors.white),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('EEE, dd \'de\' MMM.', 'pt_BR').format(widget.selectedDate),
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                      ),
                      Text(
                        _endTime != null ? _endTime!.format(context) : '00:00',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(), 


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Cancelar', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty || _startTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, preencha o título e o horário do evento.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    final newEvent = {
                      'name': _titleController.text,
                      'time': '${_startTime!.format(context)} - ${_endTime!.format(context)}',
                    };
                    widget.onAdd(newEvent); 
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFF28B66),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Adicionar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
