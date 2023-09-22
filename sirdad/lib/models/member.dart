import 'family.dart'; // Importa la clase Family

class Member {
  int? id;
  String name;
  int age;
  String relationship;
  Family family;

  Member({
    this.id,
    required this.name,
    required this.age,
    required this.relationship,
    required this.family,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'relationship': relationship,
      'familyId': family.idf,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map, Family family) {
    return Member(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      relationship: map['relationship'],
      family: family,
    );
  }
}
