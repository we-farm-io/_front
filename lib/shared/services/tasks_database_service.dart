import 'package:smart_farm/features/to_do_list/database/to_do_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TasksDatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initialize();
      return _database!;
    }
  }

  Future<String> get fullPath async {
    const name = 'todo.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await ToDoDB().createTable(database);
}
