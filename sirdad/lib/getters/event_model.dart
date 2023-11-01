
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/event.dart';


class EventData extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> addEvent(Event event) async {
    _events.add(event);
    await event.save();
    print(event.id);
    notifyListeners();
  }
   Future<void> geteventsfb() async {
    final ref = FirebaseDatabase.instance.ref().child('events');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        String date = value['date'];
        String description = value['description'];
        String name = value['name'];

        print('Event ID: $key');
        print('Date: $date');
        print('Description: $description');
        print('Name: $name');
         Event newEvent = Event(
        name: date,
        description: description,
        date: name,
      );
      addEvent(newEvent);

      });
    } else {
      print('No data available.');
    }
  }
}