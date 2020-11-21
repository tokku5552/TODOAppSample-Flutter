import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final databaseName = "TodoItem.db";
  final databaseVersion = 1;

  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  void _createTable(Batch batch) {}

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todo_item.db'),
      version: databaseVersion,
      onCreate: (db, version) async {
        var batch = db.batch();
        _createTable(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }
}
