import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sirdad/getters/family_model.dart';
import 'package:sirdad/models/event.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/widget/format_widget.dart';
import 'package:sirdad/widget/miembro_widget.dart';

FamilyModel familyModel = FamilyModel();

class FamilyWidget extends StatefulWidget {
  const FamilyWidget({Key? key}) : super(key: key);

  @override
  _FamilyWidgetState createState() => _FamilyWidgetState();
}

class _FamilyWidgetState extends State<FamilyWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final familyModel = context.watch<FamilyModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:
            Colors.white, // Cambia el color de fondo según tus preferencias
        appBar: AppBar(
          backgroundColor: Colors
              .blue, // Cambia el color de la barra de navegación según tus preferencias
          automaticallyImplyLeading: false,
          title: Text(
            'JEFE DE FAMILIA',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: familyModel.textController1,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                          labelText: 'Barrio', border: OutlineInputBorder()),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        familyModel.textController1 =
                            TextEditingController(text: value);
                      },
                      validator: (value) {
                        // Implementa la lógica de validación aquí si es necesario
                        return null; // Retorna null si la validación es exitosa
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: familyModel.textController2,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                          labelText: 'Dirección', border: OutlineInputBorder()),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        familyModel.textController2 =
                            TextEditingController(text: value);
                      },
                      validator: (value) {
                        // Implementa la lógica de validación aquí si es necesario
                        return null; // Retorna null si la validación es exitosa
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: familyModel.textController3,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                          labelText: 'Celular', border: OutlineInputBorder()),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      onChanged: (value) {
                        familyModel.textController3 =
                            TextEditingController(text: value);
                      },
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: familyModel.textController4,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                          labelText: 'Fecha', border: OutlineInputBorder()),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      onChanged: (value) {
                        familyModel.textController4 =
                            TextEditingController(text: value);
                      },
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: familyModel.textController5,
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                          labelText: 'Jefe del Hogar',
                          border: OutlineInputBorder()),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      onChanged: (value) {
                        familyModel.textController5 =
                            TextEditingController(text: value);
                      },
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 134,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 1.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          String _phone_text =
                              familyModel.textController3!.text;

                          int _phone =
                              int.parse(familyModel.textController3!.text);
                          int _nid = int.parse(_phone_text);

                          Event event = Event(
                              name: 'primer', description: 'dd', date: 'eee');
                          await event.save();
                          //Este es tú objeto de prueba
                          Family family = Family(
                              barrio: familyModel.textController1!.text,
                              address: familyModel.textController2!.text,
                              phone: _phone,
                              eventId: 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormatWidget()),
                          );
                          await family.save();

                          //icrementCounter();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => MyApp()),
                          // );
                        },
                        child: Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
