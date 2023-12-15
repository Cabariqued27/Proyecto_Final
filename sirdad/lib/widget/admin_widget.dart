import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../getters/volunteer_model.dart';
import 'package:provider/provider.dart';

final VolunteerData volunteerData = VolunteerData();

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => volunteerData,
      child: MaterialApp(
        title: 'Administrar Usuarios',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          hintColor: Colors.deepOrangeAccent,
          fontFamily: 'Roboto', 
        ),
        home: const VolunteerListScreen(),
      ),
    );
  }
}

class VolunteerListScreen extends StatefulWidget {
  const VolunteerListScreen({super.key});

  @override
  _VolunteerListScreen createState() => _VolunteerListScreen();
}

class _VolunteerListScreen extends State<VolunteerListScreen> {
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('volunteers');
    _getVolunteersFromCache();
    if (kDebugMode) {
      print('miembros.');
    }
  }

  Future<void> _getVolunteersFromCache() async {
    await volunteerData.getVolunteers();
  }

  @override
   Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios con Acceso'),
      ),
      body: Container(
        decoration: const BoxDecoration(
        ),
        child: Consumer<VolunteerData>(
          builder: (context, volunteerProvider, child) {
            final volunteers = volunteerProvider.volunteers;

            return ListView.builder(
              itemCount: volunteers.length,
              itemBuilder: (context, index) {
                final user = volunteers[index];

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 82, 81, 79), width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '${user.namev} (${user.idv})',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Teléfono:${user.phonev}'),
                        Text('ONG: ${user.ong}'),
                        Text('Signo: ${user.sign}'),
                        Text('Noticias: ${user.news}'),
                        Text(
                          'Acceso: ${user.hasAccess ? 'Concedido' : 'Revocado'}',
                          style: TextStyle(
                            color: user.hasAccess ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    trailing: Switch(
                      value: user.hasAccess,
                      onChanged: (newValue) {
                        volunteerProvider.togglevolunteerAccess(index);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
