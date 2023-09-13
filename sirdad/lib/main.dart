
import 'package:sirdad/models/event.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/services/database_helper.dart'; // Importa tu clase DataBaseHelper
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final dbHelper = DataBaseHelper();

  // Crear una familia
  final newFamily = Family(
    name: 'Familia Ejemplo',
    address: '123 Calle Principal',
  );

  // Insertar la familia en la base de datos
  final familyId = await dbHelper.insertFamily(newFamily);
  print('Familia insertada con ID: $familyId');

  // Crear un evento
  final newEvent = Event(
    name: 'Evento de Prueba',
    description: 'Descripción del evento de prueba',
    date: DateTime.now(),
  );

  // Insertar el evento en la base de datos
  final eventId = await dbHelper.insertEvent(newEvent);
  print('Evento insertado con ID: $eventId');

  // Crear un miembro
  final family = Family(id: familyId, name: '', address: ''); // Crear una instancia de Family con el ID
  final newMember = Member(
    name: 'Miembro de Prueba',
    age: 30,
    relationship: 'Hijo',
    family: family, // Pasar la instancia de Family creada
  );

  // Insertar el miembro en la base de datos
  final memberId = await dbHelper.insertMember(newMember);
  print('Miembro insertado con ID: $memberId');
}