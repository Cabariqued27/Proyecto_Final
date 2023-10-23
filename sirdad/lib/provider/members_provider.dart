import 'package:flutter/material.dart';
import 'package:sirdad/models/member.dart';

class Members_Provider with ChangeNotifier {
  final List<Member> _members = [];

  List<Member> get members {
    return [..._members];
  }

 Future<void> addMember(member) async {
    _members.add(member);
    notifyListeners();
  }
}
