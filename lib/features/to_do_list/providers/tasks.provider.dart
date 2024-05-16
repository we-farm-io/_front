import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/features/to_do_list/data.dart/tasks_list.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';

class TasksProvider extends ChangeNotifier {
  String selectedDate = DateFormat.yMMMEd().format(DateTime.now());
  String selectedFilter = 'All';
  final List<Task> _toDoList = toDoListDB
      .where((task) => task.date == DateFormat.yMMMEd().format(DateTime.now()))
      .toList();

  List<Task> get toDoList => _toDoList;

  void setDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void fetchTasks(String selectedDate, String filter) {
    if (filter == 'All') {
      _toDoList.clear();
      _toDoList.addAll(
          toDoListDB.where((task) => task.date == selectedDate).toList());
    } else {
      _toDoList.clear();
      _toDoList.addAll(toDoListDB
          .where((task) => task.date == selectedDate && task.state == filter)
          .toList());
    }
    notifyListeners();
  }

  void addTask(String title, String description, String startTime,
      String endTime, String date) {
    Task task = Task(
        taskId: UniqueKey().toString(), // replace this
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        date: date,
        state: 'To Do');
    _toDoList.add(task);
    notifyListeners();
  }

  void setTaskState(Task task, String state) {
    task.state = state;
    notifyListeners();
  }

  void deleteTask(Task task) {
    _toDoList.remove(task);
    notifyListeners();
  }
}
