import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'storage_service.dart';

class StorageServiceDatabase extends StorageService {

  @override
  Future<int> getCounterValue() async {
    Database db = await DatabaseHelper.instance.database;
    List<String> columnsToSelect = [
      DatabaseHelper.columnCounter,
    ];
    String whereString = '${DatabaseHelper.columnId} = ?';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.query(
        DatabaseHelper.table,
        columns: columnsToSelect,
        where: whereString,
        whereArgs: whereArguments);

    Map firstRow =  result.first;
    return firstRow[DatabaseHelper.columnCounter] ?? 0;
  }

  @override
  Future<void> saveCounterValue(int value) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnCounter: value
    };
    Database db = await DatabaseHelper.instance.database;
    await db.update(DatabaseHelper.table, row);
  }
}

class DatabaseHelper {

  static final _databaseName = "CounterDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'counter_table';

  static final columnId = '_id';
  static final columnCounter = 'counter';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnCounter INTEGER NOT NULL
          )
          ''');
  }
}