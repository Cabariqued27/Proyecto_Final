
import 'member.dart';

class Family {
  int? id;
  String name;
  String address;
  List<Member> members;

  Family({
    this.id,
    required this.name,
    required this.address,
    this.members = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }

  // Método para agregar un miembro a la familia
  void addMember(Member member) {
    members.add(member);
  }
}





