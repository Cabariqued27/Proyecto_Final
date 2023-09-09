import 'family.dart'; // Importa la clase Family

class Member {
  int? id;
  String name;
  int age;
  String relationship;
  Family family; // Cambio: Hacer que la referencia a la familia sea obligatoria

  Member({
    this.id,
    required this.name,
    required this.age,
    required this.relationship,
    required this.family, // Cambio: Hacer que la familia sea obligatoria
  });

  // Método para convertir entre Map y objeto Member
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'relationship': relationship,
      'familyId': family.id, // Cambio: Usar la referencia a la familia
    };
  }

  // Factory method para crear un Member desde un Map
  factory Member.fromMap(Map<String, dynamic> map, Family family) {
    return Member(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      relationship: map['relationship'],
      family: family, // Cambio: Establecer la referencia a la familia
    );
  }
}
