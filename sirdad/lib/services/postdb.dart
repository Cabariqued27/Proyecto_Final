import 'package:flutter/material.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/models/volunteer.dart';
import '../models/event.dart';

class postDB {
  String events = '';
  String familys = '';
  String members = '';
  String volunteers = '';

  void enviare() async {
    Event event = Event(
        name: 'Primer Evento', description: 'Incendio', date: '02/10/2023');
    await event.save();
  }

  void enviarf() async {
    Family family = Family(
        barrio: 'Salamanca',
        address: 'cra 15 b',
        phone: 3005075795,
        date: '02/10/2023',
        eventId: 1);
    await family.save();
  }
}

void enviarm(member) async {
  Member member = Member(
      name: 'David',
      surname: 'Cabarique',
      kid: 1,
      nid: 1,
      rela: 2,
      gen: 'm',
      age: 22,
      et: 1,
      heal: 2,
      aheal: 3,
      familyId: 1);
  await member.save();
}

void enviarv() async {
  Volunteer volunteer = Volunteer(
      namev: 'Voluntario',
      nidv: 55,
      phonev: 3225,
      ong: 'defensa civil',
      sign: 'firma',
      news: 'no paso nada');
  await volunteer.save();
}
