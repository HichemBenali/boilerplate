import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      // TODO: implement database schema
    });
  }

  static destroy() async {
    var d = await db.database;
    String documentsDirectory = await getDatabasesPath();
    _database = null;
    d.close();
    deleteDatabase(join(documentsDirectory, "database.db"));
  }
}
