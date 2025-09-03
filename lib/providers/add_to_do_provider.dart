import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import '../models/habit.dart';

class AddToDoProvider with ChangeNotifier {
  final LocalStorage storage;
  final _habitsKey = 'habits';
  List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  AddToDoProvider(this.storage) {
    _loadHabits();
  }
  Future<void> _loadHabits() async {
    final h = storage.getItem('habits');
    if (h != null) {
      final List decoded = jsonDecode(h);
      _habits = decoded.map((j) => Habit.fromJosn(j)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveHabits(
    String key,
    List<Habit> habits,
    Map Function(Habit) toJson,
  ) async {
    final data = jsonEncode(habits.map((e) => toJson(e)).toList());
    storage.setItem(key, data);
  }

  Future<void> addHabit(Habit h) async {
    _habits.add(h);
    await _saveHabits(_habitsKey, habits, (Habit e) => e.toJson());
    notifyListeners();
  }
  Future<void>editHabit(Habit h) async{
    final index=_habits.indexWhere((e)=>e.id==h.id);
    removeHabit(index.toString());
    _habits[index]=h;
    await _saveHabits(_habitsKey, habits, (Habit e)=>e.toJson());
    notifyListeners();



  }

  Future<void> removeHabit(String id) async {
    _habits.removeWhere((e) => e.id == id);
    await _saveHabits(_habitsKey, habits, (Habit e) => e.toJson());
    notifyListeners();
  }

  Future<void> habitsIsCompleted(String id) async {
    _habits.where((e) => e.id == id).first.isCompleted = !_habits
        .where((e) => e.id == id)
        .first
        .isCompleted;
    await _saveHabits(_habitsKey, habits, (Habit e) => e.toJson());

    notifyListeners();
  }
}
