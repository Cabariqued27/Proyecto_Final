
import 'package:flutter/material.dart';
import 'package:sirdad/presentation/widget/miembro_widget.dart';
//import 'package:flutter_flow/flutter_flow.dart';

// import 'package:flutter_flow/flutter_flow_checkbox_group.dart';
// import 'package:flutter_flow/flutter_flow_drop_down.dart';
// import 'package:flutter_flow/flutter_flow_theme.dart';
// import 'package:flutter_flow/form_field_controller.dart';

class MiembroModel extends ChangeNotifier {
  final unfocusNode = FocusNode();
  //Este es el de Nombre
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  //Este es el de Apellido
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  // este es el del tipo de documento
  int? DropDownValue1; //originalmente estaban en String y los cambie por int
  int? DropDownButtonController1;

  //este text es para el numero del documento
  TextEditingController? textController3;
  String? Function(BuildContext, String?)?
      textController3Validator; //revisar si corresponde
  //este el de parentesco
  int? DropDownValue2;
  List<String>? DropDownButtonController2;

  //este es el de genero
  String? DropDownValue3;
  List<String>? DropDownButtonController3;

  // bool? SimpleGroupedCheckboxValue1;
  // GroupController? SimpleGroupedCheckboxValueController1;
  // List<String>? SimpleGroupedCheckboxValue2;
  // List<String>? SimpleGroupedCheckboxValueController2;

  // List<String>? checkboxGroupValues4;
  // FormFieldController<List<String>>? checkboxGroupValueController4;
  //este es el de ingresar la edad
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

//este es el de etnia
  int? DropDownValue4;
  List<String>? DropDownButtonController4;
  // List<String>? DropDownValue3;
  // List<String>? DropDownButtonController3;

// este es el de estado de salud
  int? DropDownValue5;
  List<String>? DropDownButtonController5;
  // List<String>? SimpleGroupedCheckboxValue3;
  // List<String>? SimpleGroupedCheckboxValueController3;

  // este es el de regimen
  int? DropDownValue6;
  List<String>? DropDownButtonController6;
  // List<String>? SimpleGroupedCheckboxValue4;
  // List<String>? SimpleGroupedCheckboxValueController4;

  // este es el de estado del inmueble
   int? DropDownValue7;
   List<String>? DropDownButtonController7;

  //este es necesidades
  int? DropDownValue8;
  List<String>? DropDownButtonController8;

  // List<String>? checkboxGroupValues10;
  // FormFieldController<List<String>>? checkboxGroupValueController10;
  // List<String>? checkboxGroupValues11;
  // FormFieldController<List<String>>? checkboxGroupValueController11;

  void dispose() {
    unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
  }
}
