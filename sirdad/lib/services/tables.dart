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
          'idf INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'barrio TEXT,'
          'address TEXT,'
          'phone INTEGER,'
          'date TEXT,'
          'eventId INTEGER,'
          'FOREIGN KEY (eventId) REFERENCES $eventTable(id)'),
      _createTable(
          memberTable,
          'idm INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'name TEXT,'
          'surname TEXT,'
          'kid INTEGER,'
          'nid INTEGER,'
          'rela INTEGER,'
          'gen TEXT,'
          'age INTEGER,'
          'et INTEGER,'
          'heal INTEGER,'
          'aheal INTEGER,'
          'familyId INTEGER,'
          'FOREIGN KEY (familyId) REFERENCES $familyTable(idf)')
    ];

_createTable(String table, String columns) {
  return 'CREATE TABLE IF NOT EXISTS $table ($columns)';
}
