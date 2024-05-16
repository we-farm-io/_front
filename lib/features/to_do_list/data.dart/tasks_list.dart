import 'package:intl/intl.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';

List<Task> toDoListDB = [
  Task(
    taskId: '1',
    title: 'Example Task',
    description: 'This is an example task',
    startTime: '9:00 AM',
    endTime: '10:00 AM',
    date: DateFormat.yMMMEd().format(DateTime.now()),
    state: 'To Do',
  ),
  Task(
    taskId: '2',
    title: 'Second Task',
    description: 'This is the second task',
    startTime: '10:30 AM',
    endTime: '11:30 AM',
    date: DateFormat.yMMMEd().format(DateTime.now()),
    state: 'To Do',
  ),
  Task(
    taskId: '3',
    title: 'Third Task',
    description: 'This is the third task',
    startTime: '1:00 PM',
    endTime: '2:00 PM',
    date: DateFormat.yMMMEd().format(DateTime.now()),
    state: 'In progress',
  ),
  Task(
    taskId: '4',
    title: 'Fourth Task',
    description: 'This is the fourth task',
    startTime: '3:00 PM',
    endTime: '4:00 PM',
    date: DateFormat.yMMMEd().format(DateTime.now()),
    state: 'Done',
  ),
];
