import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../getters/acceso_model.dart';
import '../models/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

UserProvider accesoModel = UserProvider();

class AccesoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Administrar Usuarios',
        theme: ThemeData(
          primarySwatch: Colors.orange, // Color principal de la aplicación
          hintColor: Colors.deepOrangeAccent, // Color de acento
          fontFamily: 'Roboto', // Fuente predeterminada
        ),
        home: UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios con Acceso'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final users = userProvider.users;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                title: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Cédula: ${user.idv}'),
                    Text('Teléfono: ${user.phonev}'),
                    Text('ONG: ${user.ong}'),
                    Text('Sign: ${user.sign}'),
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Muestra un diálogo para agregar un nuevo usuario
          showDialog(
            context: context,
            builder: (context) => AddUserDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddUserDialog extends StatefulWidget {
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

  // Future<void> _addUser(UserProvider userProvider) async {
  //   if (_formKey.currentState!.validate()) {
  //     String name = _nameController.text;
  //     int id = int.parse(_idController.text);
  //     int phone = int.parse(_phoneController.text);
  //     String ong = _ongController.text;
  //     String sign = _signController.text;
  //     String news = _newsController.text;

  //     User newUser = User(
  //         name= name, false,
  //         idv: id,
  //         phonev: phone,
  //         ong: ong,
  //         sign: sign,
  //         news: news);

  //     userProvider.addUser(newUser);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final accesoModel = context.watch<UserProvider>();
    return AlertDialog(
      title: Text('Agregar Nuevo Usuario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Usuario',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Cédula',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            TextField(
              controller: _ongController,
              decoration: InputDecoration(
                labelText: 'ONG',
              ),
            ),
            TextField(
              controller: _signController,
              decoration: InputDecoration(
                labelText: 'Sign',
              ),
            ),
            TextField(
              controller: _newsController,
              decoration: InputDecoration(
                labelText: 'Noticias',
              ),
            ),
          ],
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
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);

            userProvider.addUser(User(
              _nameController.text,
              _passwordController.text,
              false,
              idv: int.parse(_idController.text),
              phonev: int.parse(_phoneController.text),
              ong: _ongController.text,
              sign: _signController.text,
              news: _newsController.text,
            ));
            print(userProvider.users[0].name);
            Navigator.of(context).pop();
          },
        ),
      ],
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
