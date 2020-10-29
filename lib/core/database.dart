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
    String path = join(documentsDirectory, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "Create Table `Group`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE, `hash` TEXT UNIQUE ON CONFLICT REPLACE,  GroupeName TEXT UNIQUE, group_types_id TEXT, Groupespecialite TEXT, color TEXT)");
      await db.execute(
          "Create Table `GroupType`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE, GroupeName TEXT)");
      await db.execute(
          "Create Table `Client`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE,  `hash` TEXT UNIQUE ON CONFLICT REPLACE, `lname` TEXT, `fname` TEXT, `adress` TEXT, `code` TEXT, `groupe_id` TEXT, `segments` TEXT, `image` TEXT)");
      await db.execute(
          "Create Table `Visit`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE,  `hash` TEXT UNIQUE ON CONFLICT REPLACE, `objectif` TEXT, `media` TEXT, `client_id` TEXT, `date` TEXT UNIQUE ON CONFLICT REPLACE, `rendu` TEXT, `newobjectif` TEXT, `echantillon` TEXT, `bondecommande` TEXT)");
      await db.execute(
          "Create Table `Files`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE, `name` TEXT, `filename` TEXT, `type` TEXT, `link` TEXT)");
      await db.execute(
          "Create Table `Operations`(id INTEGER PRIMARY KEY ON CONFLICT REPLACE, url TEXT, data TEXT, method TEXT)");
    });
  }

  static destroy() async {
    var d = await db.database;
    String documentsDirectory = await getDatabasesPath();
    _database = null;
    d.close();
    deleteDatabase(join(documentsDirectory, "TestDB.db"));
  }

  static createOperation(String method, String url, String data) async {
    var d = await db.database;

    var res = await d
        .insert("Operations", {"url": url, "data": data, "method": method});

    return res;
  }
}
