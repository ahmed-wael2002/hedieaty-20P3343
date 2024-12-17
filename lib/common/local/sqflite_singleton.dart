import 'package:lecture_code/common/constants/local/local_database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseLocalDatabase {
  static Database? _database;

  /// Getter for database - each subclass calls its own initDatabase()
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return await openDatabase(
      '$path/$databaseName',
      version: 1,
      onCreate: (db, version) async {
        for(var sql in databaseCreateCommands){
          await db.execute(sql);
        }
      },
      onOpen: (db) async {
        for(var sql in databaseCreateCommands){
          await db.execute(sql);
        }
      },
    );
  }

  /// Insert a record
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Fetch all rows from a table
  Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  /// Fetch rows with a condition
  Future<List<Map<String, dynamic>>> fetchByCondition({
    required String table,
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.query(table, where: whereClause, whereArgs: whereArgs);
  }

  /// Update a row by ID
  Future<int> update(String table, Map<String, dynamic> data, String idField, dynamic id) async {
    final db = await database;
    return await db.update(table, data, where: '$idField = ?', whereArgs: [id]);
  }

  /// Delete a row by ID
  Future<int> delete(String table, String idField, dynamic id) async {
    final db = await database;
    return await db.delete(table, where: '$idField = ?', whereArgs: [id]);
  }
}