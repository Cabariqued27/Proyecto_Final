import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../models/event.dart';

class EventData extends ChangeNotifier {
  final List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> addEvent(Event event) async {
    _events.add(event);
    //await event.save();
    if (kDebugMode) {
      print(event.id);
    }
    notifyListeners();
  }

  Future<void> getEventsFromCache() async {
    // Habilitar la sincronización en tiempo real para mantener los datos en caché
    FirebaseDatabase.instance.ref().keepSynced(true);
    // Obtener referencia a un nodo específico en la base de datos
    final ref = FirebaseDatabase.instance.ref().child('events');

    // Escuchar cambios en los datos del nodo (en tiempo real)
    ref.onValue.listen((event) {
      _events.clear();
      if (event.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String date = value['date'] ?? '';
          String description = value['description'] ?? '';
          String name = value['name'] ?? '';

          if (kDebugMode) {
            print('Event ID: $key');
            print('Date: $date');
            print('Description: $description');
            print('Name: $name');
          }

          Event newEvent = Event(
            id: key,
            name: name,
            description: description,
            date: date,
          );
          addEvent(newEvent);
        });
      } else {
        if (kDebugMode) {
          print('No data available.');
        }
      }
    });
  }

  //save data
  /*final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  void addEventf(String name, String description, String date) {
    databaseReference.child("events").push().set({
      'name': name,
      'description': description,
      'date': date,
    });
  }*/
}
