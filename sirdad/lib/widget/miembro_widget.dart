import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/getters/miembro_model.dart';
import 'package:sirdad/models/member.dart';



MemberData memberData = MemberData();

void main() {
  runApp(MiembroWidget());
}

class MiembroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Personas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _kidController = TextEditingController();
  TextEditingController _nidController = TextEditingController();
  TextEditingController _relaController = TextEditingController();
  TextEditingController _genController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _etController = TextEditingController();
  TextEditingController _healController = TextEditingController();
  TextEditingController _ahealController = TextEditingController();
  TextEditingController _familyIdController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('members');
  }

  Future<void> _addPerson(MemberData MemberData) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String surname = _surnameController.text;
      int kid = int.parse(_kidController.text);
      int nid = int.parse(_nidController.text);
      int rela = int.parse(_relaController.text);
      String gen = _genController.text;
      int age = int.parse(_ageController.text);
      int et = int.parse(_etController.text);
      int heal = int.parse(_healController.text);
      int aheal = int.parse(_ahealController.text);
      int familyId = int.parse(_familyIdController.text);

      Member newMember = Member(
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
        familyId: familyId,
      );

      MemberData.addMember(newMember);

      _nameController.clear();
      _surnameController.clear();
      _kidController.clear();
      _nidController.clear();
      _relaController.clear();
      _genController.clear();
      _ageController.clear();
      _etController.clear();
      _healController.clear();
      _ahealController.clear();
      _familyIdController.clear();

      // Save the person in Firebase Realtime Database
      dbRef.push().set({
        'name': name,
        'surname': surname,
        'kid': kid,
        'nid': nid,
        'rela': rela,
        'gen': gen,
        'age': age,
        'et': et,
        'heal': heal,
        'aheal': aheal,
        'familyId': familyId,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Personas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(labelText: 'Apellido'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un apellido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _kidController,
                    decoration: InputDecoration(labelText: 'Kid'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nidController,
                    decoration: InputDecoration(labelText: 'Nid'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _relaController,
                    decoration: InputDecoration(labelText: 'Rela'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _genController,
                    decoration: InputDecoration(labelText: 'Gen'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(labelText: 'Edad'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa una edad válida.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _etController,
                    decoration: InputDecoration(labelText: 'Et'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _healController,
                    decoration: InputDecoration(labelText: 'Heal'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ahealController,
                    decoration: InputDecoration(labelText: 'Aheal'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _familyIdController,
                    decoration: InputDecoration(labelText: 'ID de Familia'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addPerson(context.read<MemberData>());
                    },
                    child: Text('Agregar Persona'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Personas Registradas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<MemberData>(
              builder: (context, MemberData, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: MemberData.members.length,
                  itemBuilder: (context, index) {
                    Member person = MemberData.members[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text('Nombre: ${person.name} ${person.surname}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kid: ${person.kid}'),
                            Text('Nid: ${person.nid}'),
                            Text('Rela: ${person.rela}'),
                            Text('Gen: ${person.gen}'),
                            Text('Edad: ${person.age}'),
                            Text('Et: ${person.et}'),
                            Text('Heal: ${person.heal}'),
                            Text('Aheal: ${person.aheal}'),
                            Text('ID de Familia: ${person.familyId}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
