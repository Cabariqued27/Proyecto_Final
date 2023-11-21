import 'package:sirdad/services/crud.dart';
import 'package:sirdad/services/tables.dart';
// Importa la clase Family

class Event extends Crud {
  int id;
  String name;
  String description;
  String date;

  Event({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.date = '',
  }) : super(eventTable);

  @override
  String toString() {
    return '\n Id: $id name: $name \n';
  }

  Event toObject(Map<dynamic, dynamic> data) {
    return Event(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        date: data['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id > 0 ? id : null,
      'name': name,
      'description': description,
      'date': date,
    };
  }

  save() async {
    //return await ((id > 0) ? update(toMap()) : create(toMap()));
  }

  remove() async {
    await delete(id);
  }

  Future<List<Event>> getEvents() async {
    var result = await query('SELECT * FROM $eventTable');
    return _getListObject(result);
  }

  List<Event> _getListObject(parsed) {
    return (parsed as List).map((map) => toObject(map)).toList();
  }
}
