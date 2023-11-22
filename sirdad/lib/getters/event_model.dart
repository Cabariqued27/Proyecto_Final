import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../models/event.dart';

class EventData extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  Future<void> addEvent(Event event) async {
    _events.add(event);
    //await event.save();
    print(event.id);
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

          print('Event ID: $key');
          print('Date: $date');
          print('Description: $description');
          print('Name: $name');
          Event newEvent = Event(
            id:key,
            name: name,
            description: description,
            date: date,
          );
          addEvent(newEvent);
        });
      } else {
        print('No data available.');
      }
    });
  }
}
