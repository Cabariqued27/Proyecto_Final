import 'package:sirdad/services/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class db {
  String name = 'Sirdad';
  int version = 2;

  Future<Database> open()async{
    String path = join(await getDatabasesPath(),name);
    return openDatabase(path, 
    version: version,
    onConfigure: onConfigure,
    onCreate: onCreate
    
    );
  }

  onConfigure(Database db) async{
    await db.execute('PRAGMA foreign_keys = ON');
  }

  onCreate(Database db, int version) async {
    for(var scrip in tables){
      await db.execute(scrip);
    }
  }
}


