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
}