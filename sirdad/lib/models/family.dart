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
    this.members = const [], // Inicialmente, la lista de miembros está vacía
  });

  // Método para convertir entre Map y objeto Family
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  // Factory method para crear una Family desde un Map
  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }
}





