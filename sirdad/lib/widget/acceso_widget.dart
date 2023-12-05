import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sirdad/models/volunteer.dart';
import '../getters/acceso_model.dart';
import 'package:provider/provider.dart';

final UserProvider userProvider = UserProvider();

class AccesoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => userProvider,
      child: MaterialApp(
        title: 'Administrar Usuarios',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          hintColor: Colors.deepOrangeAccent,
          fontFamily: 'Roboto',
        ),
        home: UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.getVolunteers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios con Acceso'),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 10.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final users = userProvider.users;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      '${user.namev} (${user.idv})',
                      style: TextStyle(
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
                        userProvider.toggleUserAccess(index);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddUserDialog(userProvider: userProvider),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddUserDialog extends StatefulWidget {
  final UserProvider userProvider;

  const AddUserDialog({required this.userProvider});

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ongController = TextEditingController();
  final TextEditingController _signController = TextEditingController();
  final TextEditingController _newsController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.orange, width: 2.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOrangeBorderedTextField(
                controller: _nameController,
                labelText: 'Nombre del Usuario',
              ),
              _buildOrangeBorderedTextField(
                controller: _passwordController,
                labelText: 'Contraseña',
              ),
              _buildOrangeBorderedTextField(
                controller: _idController,
                labelText: 'Cédula',
              ),
              _buildOrangeBorderedTextField(
                controller: _phoneController,
                labelText: 'Teléfono',
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              _buildOrangeBorderedTextField(
                controller: _ongController,
                labelText: 'ONG',
              ),
              _buildOrangeBorderedTextField(
                controller: _signController,
                labelText: 'Sign',
              ),
              _buildOrangeBorderedTextField(
                controller: _newsController,
                labelText: 'Noticias',
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancelar',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Agregar',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          onPressed: () {
            widget.userProvider.addUser(Volunteer(
              namev: _nameController.text,
              password: _passwordController.text,
              hasAccess: true,
              idv: (_idController.text),
              phonev: int.parse(_phoneController.text),
              ong: _ongController.text,
              sign: _signController.text,
              news: _newsController.text,
            ));
            dbRef = FirebaseDatabase.instance.ref().child('volunteers');
            dbRef.push().set({
              'namev': _nameController.text,
              'password': _passwordController.text,
              'hasAccess': true,
              'idv': (_idController.text),
              'phonev': int.parse(_phoneController.text),
              'ong': _ongController.text,
              'sign': _signController.text,
              'news': _newsController.text,
            });

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildOrangeBorderedTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _phoneController.dispose();
    _ongController.dispose();
    _signController.dispose();
    _newsController.dispose();
    super.dispose();
  }
}
