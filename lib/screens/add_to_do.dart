import 'package:flutter/material.dart';
import 'package:to_do/providers/add_to_do_provider.dart';
import '../models/habit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';

class AddToDo extends StatefulWidget {

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _habitTitle = TextEditingController();
  final _notes = TextEditingController();
  Duration _duration = Duration(hours: 0, minutes: 0);
  DateTime _dateTime = DateTime.now();
  @override
  void dispose() {
    // TODO: implement dispose
    _habitTitle.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (d != null) setState(() => _dateTime = d);
  }

  Future<void> _pickDuration() async {
    final d = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (d != null) {
      setState(() {
        _duration = Duration(hours: d.hour, minutes: d.minute);
      });
    }
  }
  void editHabit(){

  }


  void _save() {
    if (_habitTitle.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("ادخل عنوان")));
      return;
    }
    if (_duration.inMinutes == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("اختر المدة المناسبة")));
      return;
    }

    final habit = Habit(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _habitTitle.text,
      dateTime: _dateTime,
      duration: _duration,
      notes: _notes.text,
    );
    context.read<AddToDoProvider>().addHabit(habit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to do', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _habitTitle,
              decoration: InputDecoration(labelText: 'Habit Title'),
            ),
            SizedBox(height: 5),
            ListTile(
              title: Text('Date time: ${DateFormat.yMMMd().format(_dateTime)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            SizedBox(height: 5),
            ListTile(
              title: Text(
                'Duration :${_duration.inHours}h ${_duration.inMinutes}m',
              ),
              trailing: Icon(Icons.timer),
              onTap: _pickDuration,
            ),
            SizedBox(height: 5),
            TextField(
              controller: _notes,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _save
                , child: Text('save')
            ),
          ],
        ),
      ),
    );
  }
}
