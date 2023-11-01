import 'package:flutter/material.dart';
import 'package:sirdad/widget/miembro_widget.dart';

class Person {
  String name;
  String surname;
  int kid;
  int nid;
  int rela;
  String gen;
  int age;
  int et;
  int heal;
  int aheal;
  int familyId;

  Person({
    required this.name,
    required this.surname,
    required this.kid,
    required this.nid,
    required this.rela,
    required this.gen,
    required this.age,
    required this.et,
    required this.heal,
    required this.aheal,
    required this.familyId,
  });
}

class PersonData extends ChangeNotifier {
  List<Person> people = [];

  void addPerson(Person person) {
    people.add(person);
    notifyListeners();
  }
}
