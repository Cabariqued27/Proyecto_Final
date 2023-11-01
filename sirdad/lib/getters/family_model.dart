import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sirdad/widget/family_widget.dart';


class Family {
  String barrio;
  String address;
  int phone;
  String date;
  String headOfFamily;

  Family({
    required this.barrio,
    required this.address,
    required this.phone,
    required this.date,
    required this.headOfFamily,
  });
}

class FamilyData extends ChangeNotifier {
  List<Family> families = [];

  void addFamily(Family family) {
    families.add(family);
    notifyListeners();
  }
}

