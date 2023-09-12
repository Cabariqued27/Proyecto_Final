import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/event.dart';
import '../models/family.dart';
import '../models/member.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _dbname = "Sirdad.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) async {
        // Crear la tabla 'family'
        await db.execute('''
          CREATE TABLE family (
            id INTEGER PRIMARY KEY,
            name TEXT,
            address TEXT
          )
        ''');

        // Crear la tabla 'event'
        await db.execute('''
          CREATE TABLE event (
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            date TEXT
          )
        ''');

        // Crear la tabla 'member'
        await db.execute('''
          CREATE TABLE member (
            id INTEGER PRIMARY KEY,
            name TEXT,
            age INTEGER,
            relationship TEXT,
            familyId INTEGER,
            FOREIGN KEY (familyId) REFERENCES family(id)
          )
        ''');
      },
      version: _version,
    );
  }
  
  // Método para insertar una familia en la tabla 'family'
  Future<int> insertFamily(Family family) async {
    final db = await _getDB();
    return await db.insert('family', family.toMap());
  }

  // Método para insertar un evento en la tabla 'event'
  Future<int> insertEvent(Event event) async {
    final db = await _getDB();
    return await db.insert('event', event.toMap());
  }

  // Método para insertar un miembro en la tabla 'member'
  Future<int> insertMember(Member member) async {
    final db = await _getDB();
    return await db.insert('member', member.toMap());
  }

   // Método para obtener una familia por su ID
  Future<Family?> getFamilyById(int id) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'family',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Family.fromMap(maps.first);
    } else {
      return null; // Devuelve null si no se encuentra la familia
    }
  }

  Future<List<Event>> getAllEvents() async {
  final db = await _getDB();
  final List<Map<String, dynamic>> maps = await db.query('event');
  return List.generate(maps.length, (i) {
    return Event.fromMap(maps[i]);
  });
}
}
