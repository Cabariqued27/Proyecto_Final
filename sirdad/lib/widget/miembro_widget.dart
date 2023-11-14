import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../getters/miembro_model.dart';
import '../models/member.dart';

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

  Future<void> _addPerson(MemberData memberData) async {
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

      memberData.addMember(newMember);

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

  Future<void> _generatePDF(List<Member> members) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: members
                .map(
                  (member) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Nombre: ${member.name} ${member.surname}'),
                      pw.Text('Kid: ${member.kid}'),
                      pw.Text('Nid: ${member.nid}'),
                      pw.Text('Rela: ${member.rela}'),
                      pw.Text('Gen: ${member.gen}'),
                      pw.Text('Edad: ${member.age}'),
                      pw.Text('Et: ${member.et}'),
                      pw.Text('Heal: ${member.heal}'),
                      pw.Text('Aheal: ${member.aheal}'),
                      pw.Text('ID de Familia: ${member.familyId}'),
                      pw.SizedBox(height: 16),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );

    final status = await Permission.storage.status;
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final pdfFilePath = '${directory!.path}/Download/miembros.pdf';

      if (!await Directory('${directory.path}/Download').exists()) {
        await Directory('${directory.path}/Download').create(recursive: true);
      }

      await File(pdfFilePath).writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PDF generado con éxito en $pdfFilePath'),
      ));
    } else {
      await Permission.storage.request();
      _generatePDF(members);
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
                  ElevatedButton(
                    onPressed: () {
                      List<Member> members = context.read<MemberData>().members;
                      _generatePDF(members);
                    },
                    child: Text('Generar PDF de Personas'),
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
              builder: (context, memberData, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: memberData.members.length,
                  itemBuilder: (context, index) {
                    Member person = memberData.members[index];
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
