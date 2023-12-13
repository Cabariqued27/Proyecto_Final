// MembersListScreen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/member_model.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/widget/member_widget.dart';

class MembersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Miembros Registrados'),
      ),
      body: Consumer<MemberData>(
        builder: (context, memberData, child) {
          return ListView.builder(
            itemCount: memberData.members.length,
            itemBuilder: (context, index) {
              // Build the UI for each member item
              // You can customize this based on your requirements
              Member person = memberData.members[index];
              return ListTile(
                title: Text('Nombre: ${person.name} ${person.surname}'),
                subtitle: Text('Tipo de documento: ${person.kid}'),
                // Add more details as needed
              );
             
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to another screen when the "+" button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MiembroWidget(familyIdm: '',)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}