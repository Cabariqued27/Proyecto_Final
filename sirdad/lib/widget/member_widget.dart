import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../getters/member_model.dart';
import '../models/member.dart';

MemberData memberData = MemberData();

void main() {
  runApp(MiembroWidget(familyIdm: ''));
}

class MiembroWidget extends StatelessWidget {
  final String familyIdm;

  MiembroWidget({required this.familyIdm});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Personas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(familyIdm: familyIdm),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String familyIdm;
  MyHomePage({required this.familyIdm});
  @override
  _MyHomePageState createState() => _MyHomePageState(familyIdm);
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  String? _selectedDocumento;
  TextEditingController _nidController = TextEditingController();
  String? _selectedParentesco;
  TextEditingController _genController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String? _selectedEtnia;
  String? _selectedEstadoSalud;
  String? _selectedAfiliacionSalud;
  String? _selectedEstadoInmueble;
  final String familyIdm;

  late DatabaseReference dbRef;
  _MyHomePageState(this.familyIdm);
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('members');
    _getMembersFromCache();
  }

  Future<void> _getMembersFromCache() async {
    // Llamar a la función getEventsFromCache de tu modelo de datos
    await memberData.getMembersFromCache(familyIdm);
  }

  Future<void> _addPerson(MemberData memberData) async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String surname = _surnameController.text;
      int kid = int.parse(_selectedDocumento!);
      int nid = int.parse(_nidController.text);
      int rela = int.parse(_selectedParentesco!);
      String gen = _genController.text;
      int age = int.parse(_ageController.text);
      int et = int.parse(_selectedEtnia!);
      int heal = int.parse(_selectedEstadoSalud!);
      int aheal = int.parse(_selectedAfiliacionSalud!);
      int sh = int.parse(_selectedEstadoInmueble!);

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
        sh: sh,
        familyId: familyIdm,
      );

      memberData.addMember(newMember);

      _nameController.clear();
      _surnameController.clear();
      _nidController.clear();
      _genController.clear();
      _ageController.clear();

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
        'sh': sh,
        'familyId': familyIdm,
      });
      print(memberData.getMembersFromCache(familyIdm));
    }
  }

  Future<void> _generatePDF(List<Member> members) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Transform.rotate(
            angle: 0 * 3.1415926535 / 180,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: double.infinity,
                  padding: pw.EdgeInsets.all(10),
                  margin: pw.EdgeInsets.only(bottom: 10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(),
                  ),
                  child: pw.Text(
                    '  Evaluacion de daños y analisis de necesidades (EDAN)',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 16),
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Container(
                      width: 100,
                      height: 40,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('NGRD'),
                        ],
                      ),
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                    ),
                    pw.Text(
                      'Gestion manejo de desastres',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 15),
                    ),
                    pw.Container(
                      width: 120,
                      height: 40,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Codigo: FR-1703-SMD-08'),
                        ],
                      ),
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                    ),
                    pw.Container(
                      width: 80,
                      height: 40,
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
                _buildInfoBoxes(),
                _buildTable(members),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoBoxWithText('Tipo de documento',
                        '1.registro civil 2.tarjeta de identidad 3.cedula de ciudadania 4.cedula de extrajeria 5.indocumentado 6.no sabe/ no responde'),
                    _buildInfoBoxWithText('Parentesco con el jefe de hogar',
                        '1. jefe de hogar 2.esposo(a) 3.hijo(a) 4.primo(a) 5.tio(a) 6.nieto(a) 7.suegro(a) 8.yerno/nuera'),
                    _buildInfoBoxWithText('Etnia',
                        '1.afrocolombiano 2.indigena 3.Gitano 4.Razial 5.Otro 6.sin informacion'),
                    _buildInfoBoxWithText('Estado de salud',
                        ' 1.Requiere asistencia 2.no requiere asistencia medica'),
                    _buildInfoBoxWithText('Afiliacion al regimen de salud',
                        '1.contributivo 2.subsidio 3.sin afilicion'),
                    _buildInfoBoxWithText('Estado del Inmueble',
                        ' 1.habitable 2.no habitable 3.destruida'),
                  ],
                ),
                pw.SizedBox(height: 3),
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
              ],
            ),
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
    return pw.Container(
      height: 100, // Puedes ajustar el valor según tus necesidades
      width: 100, // Puedes ajustar el valor según tus necesidades
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoBox('Barrio:soledad'),
          _buildInfoBox('Direccion:cra 25'),
          _buildInfoBox('Celular: 3008000697'),
          _buildInfoBox('Fecha: 12/12/23'),
          _buildInfoBox('Firma del Jefe: Luis diaz'),
        ],
      ),
    );
  }

  pw.Widget _buildTable(List<Member> members) {
    return pw.Container(
      height: 600,
      width: 1500, // Ajusta según tus necesidades
      child: pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: {
          0: pw.FixedColumnWidth(200), // Ancho para la columna 'Nombre'
          1: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Tipo de documento'
          2: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Numero de documento'
          3: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Parentesco con el jefe de Hogar'
          4: pw.FixedColumnWidth(200), // Ancho para la columna 'Genero'
          5: pw.FixedColumnWidth(200), // Ancho para la columna 'Edad'
          6: pw.FixedColumnWidth(200), // Ancho para la columna 'Etnia'
          7: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Estado de salud'
          8: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Afiliacion al regimen de salud'
          9: pw.FixedColumnWidth(
              200), // Ancho para la columna 'Estado del Inmueble'
        },
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
                  DropdownButtonFormField<String>(
                    value: _selectedDocumento,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedDocumento = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Registro Civil'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Tarjeta de Identidad'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Cédula de Ciudadanía'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('Cédula de Extranjería'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('Indocumentado'),
                      ),
                      DropdownMenuItem(
                        value: '6',
                        child: Text('No Sabe/No Responde'),
                      ),
                    ],
                    decoration: InputDecoration(labelText: 'Tipo de documento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nidController,
                    decoration:
                        InputDecoration(labelText: 'numero de documento'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un valor válido.';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedParentesco,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedParentesco = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Jefe de Hogar'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Esposo(a)'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Hijo(a)'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('Primo(a)'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('Tío(a)'),
                      ),
                      DropdownMenuItem(
                        value: '6',
                        child: Text('Nieto(a)'),
                      ),
                      DropdownMenuItem(
                        value: '7',
                        child: Text('Suegro(a)'),
                      ),
                      DropdownMenuItem(
                        value: '8',
                        child: Text('Yerno/Nuera'),
                      ),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Parentesco con el jefe de hogar'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
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
                  DropdownButtonFormField<String>(
                    value: _selectedEtnia,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedEtnia = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Afrocolombiano'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Indígena'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Gitano'),
                      ),
                      DropdownMenuItem(
                        value: '4',
                        child: Text('Racial'),
                      ),
                      DropdownMenuItem(
                        value: '5',
                        child: Text('Otro'),
                      ),
                      DropdownMenuItem(
                        value: '6',
                        child: Text('Sin información'),
                      ),
                    ],
                    decoration: InputDecoration(labelText: 'Etnia'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedEstadoSalud,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedEstadoSalud = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Requiere asistencia'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('No requiere asistencia médica'),
                      ),
                    ],
                    decoration: InputDecoration(labelText: 'Estado de salud'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedAfiliacionSalud,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAfiliacionSalud = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Contributivo'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('Subsidio'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Sin afiliación'),
                      ),
                    ],
                    decoration: InputDecoration(
                        labelText: 'Afiliación al régimen de salud'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedEstadoInmueble,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedEstadoInmueble = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('Habitable'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('No habitable'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('Destruida'),
                      ),
                    ],
                    decoration:
                        InputDecoration(labelText: 'Estado del inmueble'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecciona un valor válido.';
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
                            Text('Estado del inmueble: ${person.sh}'),
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
