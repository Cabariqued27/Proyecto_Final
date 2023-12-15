import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/member_model.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/widget/member_widget.dart';



class MembersListScreen extends StatelessWidget {
  const MembersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miembros Registrados'),
      ),
      body: Consumer<MemberData>(
        builder: (context, memberData, child) {
          return ListView.builder(
            itemCount: memberData.members.length,
            itemBuilder: (context, index) {
              Member person = memberData.members[index];
              return GestureDetector(
                
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text('Nombre: ${person.name} ${person.surname}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipo de documento: ${person.kid}'),
                        Text('Número de documento: ${person.nid}'),
                        Text('Parentesco: ${person.rela}'),
                        Text('Género: ${person.gen}'),
                        Text('Edad: ${person.age}'),
                        Text('Etnia: ${person.et}'),
                        Text('Estado de salud: ${person.heal}'),
                        Text('Afiliación al régimen: ${person.aheal}'),
                        Text('Estado del inmueble: ${person.sh}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MiembroWidget(familyIdm: '',)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}