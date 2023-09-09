import 'family.dart';

class Event {
  int? id;
  String name;
  String description;
  DateTime date;
  List<Family> affectedFamilies;

  Event({
    this.id,
    required this.name,
    required this.description,
    required this.date,
    this.affectedFamilies = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      date: DateTime.parse(map['date']),
    );
  }
}