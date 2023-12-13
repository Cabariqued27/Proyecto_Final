import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/MembersListScreen.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'dart:io';
import '../pdf/member_pdf.dart';

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

  //--------------------pasar las funciones de PDF a partir de aquí--------//

//--------------------pasar las funciones de PDF hasta acá--------//

  void showMessage(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Duración del mensaje
      ),
    );
  }

  void _navigateToMembersListScreen() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MembersListScreen()),
  );
}






@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.orange,
        width: 10.0,
      ),
    ),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Personas'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar a FamilyWidget y pasar el ID del evento
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyApp())); // Esto llevará de regreso a EventWidget
          },
        ),
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un nombre.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _surnameController,
                      decoration: InputDecoration(labelText: 'Apellido'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un apellido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _nidController,
                      decoration:
                          InputDecoration(labelText: 'Número de documento'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un valor válido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      controller: _genController,
                      decoration: InputDecoration(labelText: 'Género'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa un valor válido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  ElevatedButton(
                    onPressed: () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MembersListScreen()),
  );
                      _addPerson(context.read<MemberData>());
                    },
                    child: Text('Agregar Persona'),
                  ),
                  ElevatedButton(
                    onPressed: () {


                      /*Sí imprime los member, pero no imprime O al menos no muestra la familys
                        pero en el widget de family, sí, tendrá que ver con con el context?
                      */
                      //MemberData está en Getters
                      List<Member> members = context.read<MemberData>().members;
                      List<Family> familys = context.read<MemberData>().familys;

                      generatePDF(members, familys, showMessage);
                       
                    },
                    child: Text('Generar PDF de Personas'),
                  ),
                  ElevatedButton(
  onPressed: _navigateToMembersListScreen,
  child: Text('Mostrar Lista de Miembros'),
),

                ],
              ),
            ),
            SizedBox(height: 20),
            
            
          ],
        ),
      ),
    ),
  );
}
}
