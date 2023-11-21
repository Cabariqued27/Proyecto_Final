import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FamilyMember {
  String name;
  String surname;
  bool kid;
  String nid;
  int relationship;
  String gender;
  int age;
  int educationLevel;
  int healthStatus;
  int accessToHealthcare;

  FamilyMember({
    required this.name,
    required this.surname,
    required this.kid,
    required this.nid,
    required this.relationship,
    required this.gender,
    required this.age,
    required this.educationLevel,
    required this.healthStatus,
    required this.accessToHealthcare,
  });
}

class Family {
  String barrio;
  String address;
  int phone;
  String date;
  String headOfFamily;
  List<FamilyMember> members;

  Family({
    required this.barrio,
    required this.address,
    required this.phone,
    required this.date,
    required this.headOfFamily,
    required this.members,
  });
}

class FamilyData extends ChangeNotifier {
  List<Family> families = [];

  void addFamily(Family family) {
    families.add(family);
    notifyListeners();
  }

  void addFamilyMember(int familyIndex, FamilyMember member) {
    families[familyIndex].members.add(member);
    notifyListeners();
  }
}

void main() {
  runApp(FormatWidget());
}

class FormatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Familias',
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
  TextEditingController _barrioController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _headOfFamilyController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.reference().child('families');
  }

  Future<void> _addFamily(FamilyData familyData) async {
    if (_formKey.currentState!.validate()) {
      String familyBarrio = _barrioController.text;
      String familyAddress = _addressController.text;
      int familyPhone = int.parse(_phoneController.text);
      String familyDate = _dateController.text;
      String familyHead = _headOfFamilyController.text;

      Family newFamily = Family(
        barrio: familyBarrio,
        address: familyAddress,
        phone: familyPhone,
        date: familyDate,
        headOfFamily: familyHead,
        members: [],
      );

      familyData.addFamily(newFamily);

      _barrioController.clear();
      _addressController.clear();
      _phoneController.clear();
      _dateController.clear();
      _headOfFamilyController.clear();
    }
  }

  void _addFamilyMember(FamilyData familyData, int familyIndex, FamilyMember member) {
    familyData.addFamilyMember(familyIndex, member);
  }

  Future<void> _generatePDF(List<Family> families) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: families
                .map(
                  (family) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Barrio: ${family.barrio}'),
                      pw.Text('Address: ${family.address}'),
                      pw.Text('Phone: ${family.phone.toString()}'),
                      pw.Text('Date: ${family.date}'),
                      pw.Text('Jefe de familia: ${family.headOfFamily}'),
                      pw.Text('Miembros de la familia:'),
                      pw.ListView(
                        children: family.members
                            .map(
                              (member) => pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Nombre: ${member.name}'),
                                  pw.Text('Apellido: ${member.surname}'),
                                  pw.Text('Es Niño: ${member.kid ? 'Sí' : 'No'}'),
                                  pw.Text('NID: ${member.nid}'),
                                  pw.Text('Relación: ${member.relationship}'),
                                  pw.Text('Género: ${member.gender}'),
                                  pw.Text('Edad: ${member.age}'),
                                  pw.Text('Nivel de educación: ${member.educationLevel}'),
                                  pw.Text('Estado de salud: ${member.healthStatus}'),
                                  pw.Text('Acceso a atención médica: ${member.accessToHealthcare}'),
                                  pw.SizedBox(height: 8),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      pw.SizedBox(height: 16),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final pdfFile = File("${output.path}/families.pdf");

    await pdfFile.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('PDF generated successfully at ${pdfFile.path}'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Familias'),
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
                    controller: _barrioController,
                    decoration: InputDecoration(labelText: 'Barrio'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el barrio.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Dirección'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la dirección.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Teléfono'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el teléfono.';
                      }
                      if (int.tryParse(value) == null) {
                        return 'El teléfono debe ser un número.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Fecha'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la fecha.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _headOfFamilyController,
                    decoration: InputDecoration(labelText: 'Jefe de familia'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el jefe de familia.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addFamily(context.read<FamilyData>());
                    },
                    child: Text('Agregar Familia'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      List<Family> families = context.read<FamilyData>().families;
                      _generatePDF(families);
                    },
                    child: Text('Generar PDF de Familias'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Familias Registradas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<FamilyData>(
              builder: (context, familyData, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: familyData.families.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text('Barrio: ${familyData.families[index].barrio}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dirección: ${familyData.families[index].address}'),
                            Text('Teléfono: ${familyData.families[index].phone.toString()}'),
                            Text('Fecha: ${familyData.families[index].date}'),
                            Text('Jefe de familia: ${familyData.families[index].headOfFamily}'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _addFamilyMember(context.read<FamilyData>(), index, FamilyMember(
                              name: "Member Name",
                              surname: "Member Surname",
                              kid: true,
                              nid: "12345",
                              relationship: 1,
                              gender: "Male",
                              age: 30,
                              educationLevel: 1,
                              healthStatus: 1,
                              accessToHealthcare: 1,
                            ));
                          },
                          child: Text('Add Member'),
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
