import 'package:smart_farm/shared/services/tasks_database_service.dart';
import 'package:smart_farm/features/to_do_list/models/task.model.dart';
import 'package:sqflite/sqflite.dart';

class ToDoDB {
  final tableName = 'todos';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "taskId" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    PRIMARY KEY("taskId" AUTOINCREMENT)
  );""");
  }

  Future<int> create(Task task) async {
    final database = await TasksDatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName 
       ("title", "description", "startTime", "endTime", "date", "state") 
       VALUES (?, ?, ?, ?, ?, ?)''',
      [
        task.title,
        task.description,
        task.startTime,
        task.endTime,
        task.date,
        task.state,
      ],
    );
  }

  Future<List<Task>> fetchAllTasks(String date) async {
    final database = await TasksDatabaseService().database;
    final tasks = await database.rawQuery(
      '''SELECT * FROM $tableName WHERE date = ?''',
      [date],
    );
    return tasks.map((task) => Task.fromSqfliteDataBase(task)).toList();
  }

  Future<List<Task>> fetchFilteredTasks(String date, String state) async {
    final database = await TasksDatabaseService().database;
    final tasks = await database.rawQuery(
      '''SELECT * FROM $tableName WHERE date = ? AND state = ?''',
      [date, state],
    );
    return tasks.map((task) => Task.fromSqfliteDataBase(task)).toList();
  }

  Future<int> updateState(
      {required int taskId, required String state}) async {
    final database = await TasksDatabaseService().database;
    return await database.update(
      tableName,
      {'state': state},
      where: 'taskId = ?',
      whereArgs: [taskId],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<void> delete(int taskId) async {
    final database = await TasksDatabaseService().database;
    await database
        .rawDelete('''DELETE FROM $tableName WHERE taskId = ?''', [taskId]);
  }
}
