import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sql.Database> createDB() async
  {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath,'places.db'),onCreate: (db,version){
      return db.execute('CREATE TABLE userplaces(id TEXT PRIMARY KEY, title TEXT, image TEXT,lat REAL,long REAL,address TEXT)');
    },version: 1);
  }

  static Future<void> insert(String table,Map<String,Object> values) async
  {
   final ourDb = await DBHelper.createDB();
   await ourDb.insert(table, values, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
  static Future<List<Map<String,dynamic>>> getData(String table) async
  {
    final ourDb = await DBHelper.createDB();
    return await ourDb.query(table);
  }
}