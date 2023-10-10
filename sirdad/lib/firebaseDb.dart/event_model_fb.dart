import 'package:firebase_database/firebase_database.dart';

class Event {
  String id;
  String name;
  String description;
  String date;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
  });

  
}
