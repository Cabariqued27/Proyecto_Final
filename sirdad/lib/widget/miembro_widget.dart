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
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Title Box
            pw.Container(
              width: double.infinity,
              padding: pw.EdgeInsets.all(10),
              margin: pw.EdgeInsets.only(bottom: 10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Text(
                '  Evaluacion de daños y analisis de necesidades (EDAN)',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
              ),
            ),
            pw.Row(
              
              children: [
                // Left Section
                pw.Container(
                  width: 100, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('NGRD'),
                    ],
                  ),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                ),
                // Center Section
                pw.Text(
                  'Gestion manejo de desastres',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
                ),
                // Right Sections
                pw.Container(
                  width: 120, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('Codigo: FR-1703-SMD-08'),
                    ],
                  ),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                ),
                pw.Container(
                  width: 80, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('version.01'),
                    ],
                  ),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                ),
              ],
            ),
            pw.SizedBox(height: 3),
            _buildInfoBoxes(),
            pw.SizedBox(height: 3),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Text('Nombre'),
                    pw.Text('Tipo de documento'),
                    pw.Text('Numero de documento'),
                    pw.Text('Parentesco con el jefe de Hogar'),
                    pw.Text('Genero'),
                    pw.Text('Edad'),
                    pw.Text('Etnia'),
                    pw.Text('Estado de salud'),
                    pw.Text('Afiliacion al regimen de salud'),
                    pw.Text('Estado del Inmueble'),
                  ],
                ),
                // Add a TableRow for each member
                for (var member in members)
                  pw.TableRow(
                    children: [
                      pw.Text('${member.name} ${member.surname}'),
                      pw.Text('${member.kid}'),
                      pw.Text('${member.nid}'),
                      pw.Text('${member.rela}'),
                      pw.Text('${member.gen}'),
                      pw.Text('${member.age}'),
                      pw.Text('${member.et}'),
                      pw.Text('${member.heal}'),
                      pw.Text('${member.aheal}'),
                      pw.Text('${member.familyId}'),
                    ],
                  ),
              ],
            ),
            
            pw.SizedBox(height: 3),
            // Boxes with titles and text
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoBoxWithText('Tipo de documento', '1.registro civil 2.tarjeta de identidad 3.cedula de ciudadania 4.cedula de extrajeria 5.indocumentado 6.no sabe/ no responde'),
                _buildInfoBoxWithText('Parentesco con el jefe de hogar', '1. jefe de hogar 2.esposo(a) 3.hijo(a) 4.primo(a) 5.tio(a) 6.nieto(a) 7.suegro(a) 8.yerno/nuera'),
                _buildInfoBoxWithText('Etnia', '1.afrocolombiano 2.indigena 3.Gitano 4.Razial 5.Otro 6.sin informacion'),
                _buildInfoBoxWithText('Estado de salud', ' 1.Requiere asistencia 2.no requiere asistencia medica'),
                _buildInfoBoxWithText('Afiliacion al regimen de salud', '1.contributivo 2.subsidio 3.sin afilicion'),
                _buildInfoBoxWithText('Estado del Inmueble', ' 1.habitable 2.no habitable 3.destruida'),
              ],
            ),
            pw.SizedBox(height: 3),
            // Box with 3 columns and 2 rows
            pw.Container(
              child: pw.Row(
                children: [
                  _buildInfoBox1('Elaborado por : jack'),
                  _buildInfoBox1('Entidad operativa: jack'),
                  _buildInfoBox1('Observaciones: hola'),
                ],
              ),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
            ),
            pw.Container(
              child: pw.Row(
                children: [
                  _buildInfoBox1('Vo.Bo. CMGRD :   '),
                  _buildInfoBox1('Presidente CMGRD :   '),
                  _buildInfoBox1('Vo.Bo. CDGRD:   '),
                ],
              ),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
            ),
            // Box with text below
            pw.Container(
              margin: pw.EdgeInsets.only(top: 10),
              child: pw.Text(
                'PROTOTIPO DE FORMATO PARA PRESENTACION',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
            ),
          ],
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

pw.Widget _buildInfoBoxes() {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      _buildInfoBox('Barrio:soledad'),
      _buildInfoBox('Direccion:cra 25'),
      _buildInfoBox('Celular: 3008000697'),
      _buildInfoBox('Fecha: 12/12/23'),
      _buildInfoBox('Firma del Jefe: Luis diaz'),
    ],
  );
}

pw.Widget _buildInfoBox(String label) {
  return pw.Container(
    width: 100, // Adjust the width as needed
    height: 60, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
}

pw.Widget _buildInfoBox1(String label) {
  return pw.Container(
    width: 160, // Adjust the width as needed
    height: 50, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
}

pw.Widget _buildInfoBoxWithText(String title, String text) {
  return pw.Container(
    width: 80, // Adjust the width as needed
    height: 200, // Adjust the height as needed
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 4),
        pw.Text(text),
      ],
    ),
    decoration: pw.BoxDecoration(border: pw.Border.all()),
  );
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
                    decoration: InputDecoration(labelText: 'tipo de documento: 1. registro civil 2.tarjeta de identidad 3.cedula de ciudadania 4.cedulan de extranjera 5.indocumentado 6.no sabe/no responde'),
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
                    decoration: InputDecoration(labelText: 'numero de documento'),
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
                    decoration: InputDecoration(labelText: 'parentesco con el jefe de hogar: 1. jefe de hogar 2.esposo(a) 3.hijo(a) 4.primo(a) 5.tio(a) 6.nieto(a) 7.suegro(a) 8.yerno/nuera'),
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
                    decoration: InputDecoration(labelText: 'Genero'),
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
                    decoration: InputDecoration(labelText: 'Etnia : 1. afrocolombiano 2.indigena 3.Gitano 4.Razial 5.Otro 6.sin informacion'),
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
                    decoration: InputDecoration(labelText: 'Estado de salud: 1.Requiere asistencia 2.no requiere asistencia medica'),
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
                    decoration: InputDecoration(labelText: 'Afiliacion al regimen de salud: 1.contributivo 2.subsidio 3.sin afilicion'),
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
                    decoration: InputDecoration(labelText: 'Estado del inmueble 1. habitable 2.no habitable 3.destruida'),
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
                            Text('Tipo de documento: ${person.kid}'),
                            Text('Numero de documento: ${person.nid}'),
                            Text('parentesco: ${person.rela}'),
                            Text('Genero: ${person.gen}'),
                            Text('Edad: ${person.age}'),
                            Text('Etnia: ${person.et}'),
                            Text('Estado de salud: ${person.heal}'),
                            Text('Afiliacion al regimen: ${person.aheal}'),
                            Text('Estado del inmueble: ${person.familyId}'),
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