import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelp {
  static Future<sql.Database> database() async {
    //here we are getting the location of database
    final dbPath = await sql.getDatabasesPath();
    //open the database
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_Places(id TEXT PRIMARY KEY, title TEXT, image )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DatabaseHelp.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DatabaseHelp.database();
   return db.query(table);
  }
}
