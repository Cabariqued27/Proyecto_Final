import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';

class MemberData extends ChangeNotifier {
  final List<Member> _members = [];
  List<Member> get members => _members;
  final List<Family> _familys = []; // Este list no estaba antes
  List<Family> get familys => _familys;

  Future<void> addMember(Member member) async {
    _members.add(member);
    notifyListeners();
  }

  Future<void> addFamily(Family family) async {
    _familys.add(family);
    notifyListeners();
  }

  Future<void> getMembersFromCache(String familyIdm) async {
    FirebaseDatabase.instance.ref().keepSynced(true);
    final ref = FirebaseDatabase.instance.ref().child('members');

    ref.onValue.listen((member) {
      _members.clear();
      if (member.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            member.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          int idm = value['idm'] ?? 0;
          String name = value['name'] ?? '';
          String surname = value['surname'] ?? '';
          int kid = value['kid'] ?? 0;
          int nid = value['nid'] ?? 0;
          int rela = value['rela'] ?? 0;
          String gen = value['gen'] ?? '';
          int age = value['age'] ?? 0;
          int et = value['et'] ?? 0;
          int heal = value['heal'] ?? 0;
          int aheal = value['aheal'] ?? 0;
          int sh = value['sh'] ?? '';
          String familyId = value['familyId'] ?? 0;

          if (familyId == familyIdm) {
            Member newMember = Member(
              idm: idm,
              name: name,
              surname: surname,
              kid: kid,
              nid: nid,
              rela: rela,
              gen: gen,
              age: age,
              et: et,
              heal: heal,
              aheal: aheal,
              sh: sh,
              familyId: familyId,
            );
            addMember(newMember);
          }
        });
      } else {
        if (kDebugMode) {
          print('No data available.');
        }
      }
    });
  }

  Future<void> getfamily(String familyIdm) async {
    FirebaseDatabase.instance.ref().keepSynced(true);
    final ref = FirebaseDatabase.instance.ref().child('familys');
    ref.onValue.listen((family) {
      _familys.clear();
      if (family.snapshot.exists) {
        final Map<dynamic, dynamic> data =
            family.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          String barrio = value['barrio'] ?? "";
          String address = value['address'] ?? "";
          int phone = value['phone'] ?? "";
          String date = value['date'] ?? "";
          String jefe = value['jefe'] ?? "";
          String familyEventId = value['eventId'] ?? "";
          if (key == familyIdm) {
            Family newFamily = Family(
              idf: key,
              barrio: barrio,
              address: address,
              phone: phone,
              date: date,
              jefe: jefe,
              eventId: familyEventId,
            );
            addFamily(newFamily);
          } else {}
        });
      } else {
        if (kDebugMode) {
          print('No data available.');
        }
      }
    });
  }
}
