import 'package:flutter/material.dart';

class FamilyChiefWidget extends StatefulWidget {
  const FamilyChiefWidget({Key? key}) : super(key: key);

  @override
  _FamilyChiefWidgetState createState() => _FamilyChiefWidgetState();
}

class _FamilyChiefWidgetState extends State<FamilyChiefWidget> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: textController1,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Barrio',
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      validator: (value) {
                        // Implementa la lógica de validación aquí si es necesario
                        return null; // Retorna null si la validación es exitosa
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: textController2,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Dirección',
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      validator: (value) {
                        // Implementa la lógica de validación aquí si es necesario
                        return null; // Retorna null si la validación es exitosa
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: textController3,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        labelStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        hintStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.black, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.blue, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: textController4,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        labelStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        hintStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.black, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.blue, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: textController5,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Jefe del Hogar',
                        labelStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        hintStyle: TextStyle(
                            fontSize: 16), // Cambia el estilo si es necesario
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.black, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.blue, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Colors.red, // Cambia el color si es necesario
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: TextStyle(
                          fontSize: 16), // Cambia el estilo si es necesario
                      validator: (value) {
                        // Agrega la lógica de validación si es necesario
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
