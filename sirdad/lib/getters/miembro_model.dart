import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/widget/member_widget.dart';

class MemberData extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> get members => _members;

  Future<void> addMember(Member member) async {
    _members.add(member);
    await member.save();
    notifyListeners();
  }

  Future<void> getmembersfb() async {
    final ref = FirebaseDatabase.instance.ref().child('members');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      final Map<dynamic, dynamic> data =
          snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        int idm = data['idm'];
        String name = data['name'];
        String surname = data['surname'];
        int kid = data['kid'];
        int nid = data['nid'];
        int rela = data['rela'];
        String gen = data['gen'];
        int age = data['age'];
        int et = data['et'];
        int heal = data['heal'];
        int aheal = data['aheal'];
        int familyId = data['familyId'];

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
            familyId: familyId);
            addMember(newMember);
      });
    } else {
      print('No data available.');
    }
  }
}
