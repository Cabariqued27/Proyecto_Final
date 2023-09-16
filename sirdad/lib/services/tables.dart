const String eventTable = 'event';
const String familyTable = 'family';
const String memberTable = 'member';

List get tables => [
      _createTable(
          eventTable,
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'name TEXT,'
          'description TEXT,'
          'date TEXT'),
      _createTable(
          familyTable,
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'name TEXT,'
          'address TEXT,'
          'eventId INTEGER,'
          'FOREIGN KEY (eventId) REFERENCES $eventTable(id)'),
      _createTable(
          memberTable,
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'name TEXT,'
          'age INTEGER,'
          'relationship TEXT,'
          'familyId INTEGER,'
          'FOREIGN KEY (familyId) REFERENCES $familyTable(id)')
    ];

_createTable(String table, String columns){
  return 'CREATE TABLE IF NOT EXISTS $table ($columns)';
}
