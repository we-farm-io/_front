class Task {
  int? taskId;
  String title;
  String description;
  String startTime;
  String endTime;
  String date;
  String state; // Done - In progress - To Do

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.state,
  });

  factory Task.fromSqfliteDataBase(Map<String, dynamic> map) => Task(
        taskId: map['taskId'],
        title: map['title'],
        description: map['description'],
        startTime: map['startTime'],
        endTime: map['endTime'],
        date: map['date'],
        state: map['state'],
      );
}
