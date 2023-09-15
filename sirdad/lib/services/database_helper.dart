import 'package:sirdad/services/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseS {
  String name = 'Sirdad';
  int version = 1;

  Future<Database> open()async{
    String path = join(await getDatabasesPath(),name);
    return openDatabase(path, 
    version: version,
    onConfigure: onConfigure,
    onCreate: onCreate
    
    );
  }

  onConfigure(Database DatabaseS) async{
    await DatabaseS.execute('PRAGMA foreing_keys = ON');
  }

  onCreate(Database DatabaseS, int version) async {
    for(var scrip in tables){
      await DatabaseS.execute(scrip);
    }
  }
}


