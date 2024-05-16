class Task {
  String taskId;
  String title;
  String description;
  String startTime;
  String endTime;
  String date;
  String state; // done - in progress - to do

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.state,
  });
}

