import 'package:sirdad/models/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SirdadDatabase {
  static final SirdadDatabase instance = SirdadDatabase._init();

  static Database? _database;

  SirdadDatabase._init();
  final String tableEvent = 'event';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sirdad.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase (path, version: 1, onCreate: _onCreateDB);
  }

  Future  _onCreateDB(Database db, int version) async {
    db.execute('''
          CREATE TABLE family (
            id INTEGER PRIMARY KEY,
            name TEXT,
            address TEXT
          )
        ''');db.execute('''
          CREATE TABLE $tableEvent (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            date TEXT
          )
        ''');db.execute('''
          CREATE TABLE member (
            id INTEGER PRIMARY KEY,
            name TEXT,
            age INTEGER,
            relationship TEXT,
            familyId INTEGER,
            FOREIGN KEY (familyId) REFERENCES family(id)
          )
        ''');
  }

  Future <void> insert(Event event) async{
    final db = await instance.database;
    await db.insert(tableEvent,event.toMap());
  }

  
        
}
