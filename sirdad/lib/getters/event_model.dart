
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../models/event.dart';


class EventData extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }
}