// lib/ui/screens/tarefas_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/nav_button_bar.dart';
import 'package:intl/intl.dart'; // Importe para formatação de data

class TarefasScreen extends StatefulWidget {
  const TarefasScreen({Key? key}) : super(key: key);

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  int _selectedIndex = 0; 

  final List<Map<String, String>> _tasks = [
    {
      'name': 'Alongamento',
      'time': '10:30',
      'image': 'assets/icons/ioga.png',
      'completed': 'false'
    },
    {
      'name': 'Meditação',
      'time': '17:20',
      'image': 'assets/icons/meditando.png',
      'completed': 'false'
    },
    {
      'name': 'Corrida',
      'time': '18:00',
      'image': 'assets/icons/correndo.png',
      'completed': 'false'
    },
    {
      'name': 'Academia',
      'time': '19:30',
      'image': 'assets/icons/levantando-peso.png',
      'completed': 'false'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {

      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/calendario_screen');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/perfil_screen');
      }
    });
  }


  void _addTask(Map<String, String> newTask) {
    setState(() {
      _tasks.add(newTask);
    });
  }


  void _updateTask(int index, Map<String, String> updatedTask) {
    setState(() {
      _tasks[index] = updatedTask;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }


  void _showAddTaskModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
      builder: (context) {
        return _AddTaskForm(
          onAdd: _addTask, 
        );
      },
    );
  }


  void _showEditDeleteTaskModal(BuildContext context, int index, Map<String, String> task) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _EditTaskForm(
          initialTask: task,
        );
      },
    );

    if (result != null) {
      if (result['action'] == 'update') {
        _updateTask(index, result['task'] as Map<String, String>);
      } else if (result['action'] == 'delete') {
        _deleteTask(index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final String currentDate =
        DateFormat('dd \'de\' MMMM \'de\' 2025', 'pt_BR').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0XFFDDEBF3), 
      body: Column(
        children: [

          Container(
            color: const Color(0XFFDDEBF3), 
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    16.0, 16.0, 16.0, 16.0), 
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, 
                  children: [

                    Text(
                      currentDate, 
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                        height: 16.0), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        final days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
                        final isSelected = days[index] == 'Sex';

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              height: 75,
                              decoration: isSelected
                                  ? BoxDecoration(
                                      color: const Color(0XFFF5F5F5),
                                      borderRadius: BorderRadius.circular(20.0),
                                    )
                                  : null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    days[index],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? const Color(0XFF4A4A4A)
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0), 
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, 
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0XFFB2CFDB), 
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Text(
                          'Tarefas do Dia',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true, 
                      physics: const NeverScrollableScrollPhysics(), 
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return _buildTaskItem(
                          context,
                          task['name']!,
                          task['time']!,
                          task['image']!,
                          task['completed'] == 'true',
                          index, 
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskModal(context), 
        backgroundColor: const Color(0XFFF28B66), 
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: NavButtonBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, String time,
      String imagePath, bool completed, int index) {
    return GestureDetector( 
      onTap: () {
        _showEditDeleteTaskModal(context, index, _tasks[index]);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0XFFDDEBF3), 
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), 
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                    Icons.assignment, 
                    size: 40,
                    color: Colors.grey);
              },
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: completed ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.black,
                      decorationThickness: 2,
                    ),
                  ),
                  Text(
                    'Horário: $time',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: completed ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.grey,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _tasks[index]['completed'] = completed ? 'false' : 'true';
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed ? const Color(0XFFFA7B5B) : Colors.transparent, 
                  border: Border.all(
                      color: const Color(0XFFFA7B5B),
                      width: 2), 
                ),
                child: completed
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null, // Check se completa
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTaskForm extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const _AddTaskForm({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  __AddTaskFormState createState() => __AddTaskFormState();
}

class __AddTaskFormState extends State<_AddTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime; 
  String _selectedImagePath = 'assets/icons/default_task.png'; 
  List<Map<String, String>> _availableIcons = [
    {'name': 'Ioga', 'path': 'assets/icons/ioga.png'},
    {'name': 'Meditação', 'path': 'assets/icons/meditando.png'},
    {'name': 'Corrida', 'path': 'assets/icons/correndo.png'},
    {'name': 'Academia', 'path': 'assets/icons/levantando-peso.png'},
    {'name': 'Estudando', 'path': 'assets/icons/estudando.png'},
    {'name': 'Café', 'path': 'assets/icons/Café.png'}, 
    {'name': 'Festa', 'path': 'assets/icons/festa.png'},
    {'name': 'Cozinhando', 'path': 'assets/icons/cozinhando.png'},
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startTime = TimeOfDay.fromDateTime(now.add(const Duration(minutes: 30)));
    _endTime =
        TimeOfDay.fromDateTime(now.add(const Duration(hours: 1, minutes: 30)));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = isStartTime
        ? (_startTime ?? TimeOfDay.now())
        : (_endTime ??
            _startTime ??
            TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))));

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
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
                  (_startTime!.hour == _endTime!.hour &&
                      _startTime!.minute > _endTime!.minute))) {
            _endTime =
                TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24)
              _endTime = const TimeOfDay(hour: 23, minute: 59);
          }
        } else {
          _endTime = picked;
          if (_startTime != null &&
              (_startTime!.hour > _endTime!.hour ||
                  (_startTime!.hour == _endTime!.hour &&
                      _startTime!.minute > _endTime!.minute))) {
            _endTime =
                TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24)
              _endTime = const TimeOfDay(hour: 23, minute: 59);
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
            'Título da Tarefa',
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
              hintText: 'Ex: Estudar Flutter',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),

          const Text(
            'Ícone da Tarefa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _availableIcons.length,
              itemBuilder: (context, index) {
                final icon = _availableIcons[index];
                final isSelected = _selectedImagePath == icon['path'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImagePath = icon['path']!;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0XFFF28B66) 
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.transparent, 
                        width: 2,
                      ),
                    ),
                    child: Image.asset(icon['path']!, width: 40, height: 40),
                  ),
                );
              },
            ),
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
                        'Início', 
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 14),
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
                        'Fim', 
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 14),
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
                          content: Text('Por favor, preencha o título e o horário da tarefa.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    final newTask = {
                      'name': _titleController.text,
                      'time':
                          '${_startTime!.format(context)} - ${_endTime!.format(context)}',
                      'image': _selectedImagePath,
                      'completed': 'false', 
                    };
                    widget.onAdd(newTask);
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
class _EditTaskForm extends StatefulWidget {
  final Map<String, String> initialTask;

  const _EditTaskForm({
    Key? key,
    required this.initialTask,
  }) : super(key: key);

  @override
  __EditTaskFormState createState() => __EditTaskFormState();
}

class __EditTaskFormState extends State<_EditTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _selectedImagePath = 'assets/icons/default_task.png';
  
  List<Map<String, String>> _availableIcons = [
    {'name': 'Ioga', 'path': 'assets/icons/ioga.png'},
    {'name': 'Meditação', 'path': 'assets/icons/meditando.png'},
    {'name': 'Corrida', 'path': 'assets/icons/correndo.png'},
    {'name': 'Academia', 'path': 'assets/icons/levantando-peso.png'},
    {'name': 'Estudando', 'path': 'assets/icons/estudando.png'}, 
    {'name': 'Café', 'path': 'assets/icons/Café.png'}, 
    {'name': 'Festa', 'path': 'assets/icons/festa.png'}, 
    {'name': 'Cozinhando', 'path': 'assets/icons/cozinhando.png'}, 
  ];

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTask['name']!;

    final String timeString = widget.initialTask['time']!;
    List<String> times = timeString.split(' - ');
    if (times.length == 2) {
      _startTime = _parseTimeOfDay(times[0]);
      _endTime = _parseTimeOfDay(times[1]);
    } else {
      _startTime = _parseTimeOfDay(timeString);
  
      if (_startTime != null) {
        _endTime = TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
        if (_endTime!.hour >= 24) _endTime = const TimeOfDay(hour: 23, minute: 59);
      }
    }

    _selectedImagePath = widget.initialTask['image'] ?? 'assets/icons/default_task.png';
  }


  TimeOfDay? _parseTimeOfDay(String time) {
    if (time.contains('Horário não definido')) {
      return null;
    }
    try {
      final format = DateFormat('HH:mm'); 
      final DateTime dt = format.parse(time);
      return TimeOfDay.fromDateTime(dt);
    } catch (e) {

      print('Erro ao parsear horário: $e');
      return null;
    }
  }


  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = isStartTime
        ? (_startTime ?? TimeOfDay.now())
        : (_endTime ??
            _startTime ??
            TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))));

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
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
                  (_startTime!.hour == _endTime!.hour &&
                      _startTime!.minute > _endTime!.minute))) {
            _endTime =
                TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24)
              _endTime = const TimeOfDay(hour: 23, minute: 59);
          }
        } else {
          _endTime = picked;
          if (_startTime != null &&
              (_startTime!.hour > _endTime!.hour ||
                  (_startTime!.hour == _endTime!.hour &&
                      _startTime!.minute > _endTime!.minute))) {
            _endTime =
                TimeOfDay(hour: _startTime!.hour + 1, minute: _startTime!.minute);
            if (_endTime!.hour >= 24)
              _endTime = const TimeOfDay(hour: 23, minute: 59);
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
            'Título da Tarefa',
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
              hintText: 'Ex: Estudar Flutter',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),

          const Text(
            'Ícone da Tarefa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _availableIcons.length,
              itemBuilder: (context, index) {
                final icon = _availableIcons[index];
                final isSelected = _selectedImagePath == icon['path'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImagePath = icon['path']!;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0XFFF28B66)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Image.asset(icon['path']!, width: 40, height: 40),
                  ),
                );
              },
            ),
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
                        'Início',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 14),
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
                        'Fim',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 14),
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
                    Navigator.pop(context, {'action': 'cancel'}); 
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
                          content: Text('Por favor, preencha o título e o horário da tarefa.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    final updatedTask = {
                      'name': _titleController.text,
                      'time':
                          '${_startTime!.format(context)} - ${_endTime!.format(context)}',
                      'image': _selectedImagePath,
                      'completed': widget.initialTask['completed']!, 
                    };
                    Navigator.pop(context, {'action': 'update', 'task': updatedTask}); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFF28B66),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Salvar', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), 
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {'action': 'delete'}); 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, 
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete),
                SizedBox(width: 8),
                Text('Excluir Tarefa', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
