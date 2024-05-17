import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_farm/features/to_do_list/database/to_do_db.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';

class TasksProvider extends ChangeNotifier {
  String selectedDate = DateFormat.yMMMEd().format(DateTime.now());
  String selectedFilter = 'All';
  List<Task> _toDoList = [];
  final todoDB = ToDoDB();

  Future<List<Task>> get toDoList async {
    return _toDoList;
  }

  TasksProvider() {
    fetchTasks();
  }

  void setDate(String date) {
    selectedDate = date;
    fetchTasks();
    notifyListeners();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    fetchTasks();
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    if (selectedFilter == 'All') {
      _toDoList = await todoDB.fetchAllTasks(selectedDate);
    } else {
      _toDoList = await todoDB.fetchFilteredTasks(selectedDate, selectedFilter);
    }
    notifyListeners();
  }

  Future<void> addTask(String title, String description, String startTime,
      String endTime, String date) async {
    Task task = Task(
      taskId: _toDoList.length +1,
        title: title,
        description: description,
        startTime: startTime,
        endTime: endTime,
        date: date, 
        state: 'To Do',);
    await todoDB.create(task);
    fetchTasks();
  }

  Future<void> setTaskState(Task task, String state) async {
    await todoDB.updateState(taskId: task.taskId!, state: state);
    fetchTasks();
  }

  Future<void> deleteTask(Task task) async {
    await todoDB.delete(task.taskId!);
    fetchTasks();
  }
}
