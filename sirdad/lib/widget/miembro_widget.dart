import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sirdad/getters/miembro_model.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/provider/members_provider.dart';
import 'package:sirdad/widget/reload.dart';

MiembroModel miembroModel = MiembroModel();

class Miembro_Widget extends StatefulWidget {
  //final SharedData sharedData;

  const Miembro_Widget({Key? key}) : super(key: key);

  @override
  _Miembro_Widget createState() => _Miembro_Widget();
}

class _Miembro_Widget extends State<Miembro_Widget> {
  @override
  void dispose() {
    // textController1.dispose();
    // textController2.dispose();
    // textController3.dispose();
    // textController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final miembroModel = context.watch<MiembroModel>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white, // Cambiar al color deseado
        appBar: AppBar(
          backgroundColor: Colors.blue, // Cambiar al color deseado
          title: Text(
            'Familiar',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextFormField(
                  controller: miembroModel.textController1,
                  decoration: InputDecoration(
                    labelText: 'Nombre...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    miembroModel.textController1 =
                        TextEditingController(text: value);
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                        controller: miembroModel
                            .textController2, // Cambiar a tu controller adecuado
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Apellido...',
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 20, color: Colors.black)),
                          // Aquí puedes personalizar los estilos de acuerdo a tus preferencias
                          // labelStyle: TextStyle(
                          //   fontSi>ze: 16,
                          //   color: Colors.black, // Cambiar al color deseado
                          // ),
                          // hintStyle: TextStyle(
                          //   fontSize: 16,
                          //   color: Colors.black, // Cambiar al color deseado
                          // ),
                          // enabledBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.grey, // Cambiar al color deseado
                          //     width: 2,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.blue, // Cambiar al color deseado
                          //     width: 2,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          // errorBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.red, // Cambiar al color deseado
                          //     width: 2,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          // focusedErrorBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors.red, // Cambiar al color deseado
                          //     width: 2,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Cambiar al color deseado
                        ),
                        onChanged: (value) {
                          miembroModel.textController2 =
                              TextEditingController(text: value);
                        }
                        // Agregar validadores según tus necesidades
                        ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DropdownButtonFormField(
                              //controller: GroupController(),
                              value: miembroModel.DropDownValue1,
                              decoration: const InputDecoration(
                                hintText: "Documento de identidad...",
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text("Documento de identidad..."),
                                  value: -1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Registro civil"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Tarjeta de Identidad"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("Cedula ciudadana"),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text("Cedula extranjera"),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text("Indocumentado"),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text("No sabe/No  responde"),
                                  value: 6,
                                ),
                              ],
                              onChanged: (value) {
                                miembroModel.DropDownValue1 = value as int;
                                int save = miembroModel.DropDownValue1 as int;
                                print("Tipo de documento: $save");
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextFormField(
                  controller: miembroModel
                      .textController3, // Asegúrate de tener el controlador adecuado
                  autofocus: true,
                  obscureText: false,
                  onChanged: (value) {
                    miembroModel.textController3 =
                        TextEditingController(text: value);
                    String save;
                    save = miembroModel.textController3!.text;
                    print("Número de documento: $save");
                  },
                  decoration: InputDecoration(
                    labelText: 'Número del documento..',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Cambia al color deseado
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: miembroModel.DropDownValue2,
                        decoration: InputDecoration(
                            hintText: 'Parentesco...',
                            border: OutlineInputBorder()),
                        items: [
                          DropdownMenuItem(
                            child: Text("Parentesco..."),
                            value: -1,
                          ),
                          DropdownMenuItem(
                            child: Text("Jefe del Hogar"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Esposo(a)"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Hijo(a)"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("primo(a)"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Tío"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Nieto(a)"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Suegro(a)"),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text("Yerno/Nuera"),
                            value: 8,
                          ),
                        ],
                        onChanged: (value) {
                          miembroModel.DropDownValue2 = value as int;
                          //sharedData.seledtedDropdownParentesco = value!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: miembroModel.DropDownValue3,
                        decoration: const InputDecoration(
                            hintText: 'Genero...',
                            border: OutlineInputBorder()),
                        items: const [
                          // EN ESTA PARTE SE DEBERIA TOMAR LOS VALUE PARA MANDARLOS A LA BD
                          DropdownMenuItem(
                            child: Text("Genero..."),
                            value: " ",
                          ),
                          DropdownMenuItem(
                            child: Text("Femenino"),
                            value: "F",
                          ),
                          DropdownMenuItem(
                            child: Text("Masculino"),
                            value: "M",
                          ),
                        ],
                        onChanged: (value) {
                          miembroModel.DropDownValue3 = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextFormField(
                  controller: miembroModel
                      .textController4, // Asegúrate de tener el controlador adecuado
                  autofocus: true,
                  obscureText: false,
                  decoration: const InputDecoration(
                      hintText: 'Edad', border: OutlineInputBorder()),
                  onChanged: (value) {
                    miembroModel.textController4 =
                        TextEditingController(text: value);
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Cambia al color deseado
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: miembroModel.DropDownValue4,
                        decoration: const InputDecoration(
                            hintText: 'Etnia', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                            child: Text("Etnia..."),
                            value: -1,
                          ),
                          DropdownMenuItem(
                            child: Text("Afrocolombiano"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Indigena"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Gitano/Rom"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Raizal"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Otro"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Sin Información"),
                            value: 6,
                          ),
                        ],
                        onChanged: (value) {
                          miembroModel.DropDownValue4 = value as int;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DropdownButtonFormField(
                      //controller: GroupController(),
                      value: miembroModel.DropDownValue5,
                      decoration: const InputDecoration(
                          hintText: 'Estado de salud',
                          border: OutlineInputBorder()),
                      items: const [
                        // EN ESTA PARTE SE DEBERIA TOMAR LOS VALUE PARA MANDARLOS A LA BD
                        DropdownMenuItem(
                          child: Text("Estado de Salud.."),
                          value: -1,
                        ),
                        DropdownMenuItem(
                          child: Text("Requiere atención médica"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("No requiere atención médica"),
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {
                        miembroModel.DropDownValue5 = value as int;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DropdownButtonFormField(
                      //controller: GroupController(),
                      value: miembroModel.DropDownValue6,
                      decoration: const InputDecoration(
                          hintText: 'Regimen', border: OutlineInputBorder()),
                      items: const [
                        // EN ESTA PARTE SE DEBERIA TOMAR LOS VALUE PARA MANDARLOS A LA BD
                        DropdownMenuItem(
                          child: Text("Afiliación al regimen de salud..."),
                          value: -1,
                        ),
                        DropdownMenuItem(
                          child: Text("Contributivo"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Subsidiado"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Sin afiliación"),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        miembroModel.DropDownValue6 = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DropdownButtonFormField(
                      value: miembroModel.DropDownValue7,
                      decoration: const InputDecoration(
                          hintText: 'Estado del inmueble',
                          border: OutlineInputBorder()),
                      items: const [
                        // EN ESTA PARTE SE DEBERIA TOMAR LOS VALUE PARA MANDARLOS A LA BD
                        DropdownMenuItem(
                          child: Text("Estado del inmueble..."),
                          value: -1,
                        ),
                        DropdownMenuItem(
                          child: Text("Habitable"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("No Habitable"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Destruida"),
                          value: 3,
                        ),
                      ],
                      onChanged: (value) {
                        miembroModel.DropDownValue7 = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: miembroModel.DropDownValue8,
                            decoration: const InputDecoration(
                                hintText: 'Necesidades',
                                border: OutlineInputBorder()),
                            items: [
                              DropdownMenuItem(
                                child: Text("Necesidades..."),
                                value: -1,
                              ),
                              DropdownMenuItem(
                                child: Text("AHE ALIMEN"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("AHE NO ALIMEN"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("MAT.REHAB DE VIVIENDA"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("SUB.ARRIENDO"),
                                value: 4,
                              ),
                            ],
                            onChanged: (value) {
                              miembroModel.DropDownValue8 = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 134,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: ElevatedButton(
                        onPressed: () async {
                          int _kid = miembroModel.DropDownValue1!.toInt();
                          //print("type_id: $_kid");
                          String nid_text = miembroModel.textController3!.text;

                          int _age =
                              int.parse(miembroModel.textController4!.text);
                          int _nid = int.parse(nid_text);

                          //Este es tú objeto de prueba
                          Member member = Member(
                            name: miembroModel.textController1!.text,
                            surname: miembroModel.textController2!.text,
                            kid: _kid,
                            nid: _nid,
                            rela: miembroModel.DropDownValue2 as int,
                            gen: miembroModel.DropDownValue3 as String,
                            age: _age,
                            et: miembroModel.DropDownValue4 as int,
                            heal: miembroModel.DropDownValue5 as int,
                            aheal: miembroModel.DropDownValue6 as int,
                            familyId: 8,
                          );
                          print("surname:");
                          print(member.surname);
                          //icrementCounter();
                          await member.save();
                      // AQUÍ TENDRÍA QUE HACER EL CAMBIO DE ESTADO HACIA LA PANTALLA DE EDAN
                      Provider.of<Members_Provider>(context, listen: false).addMember(member);
                          Navigator.pop(context);
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
