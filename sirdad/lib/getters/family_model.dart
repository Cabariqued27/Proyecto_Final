import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class FamilyModel extends ChangeNotifier {
  final unfocues = FocusNode();
  //El Barrio
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  //Dirección
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  //Celular
  TextEditingController? textController3;
  String? Function(BuildContext, String?)?
      textController3Validator; //revisar si corresponde

  //Fecha
  TextEditingController? textController4;
  String? Function(BuildContext, String)? textController4Validator;

  //Jefe del Hogar
  TextEditingController? textController5;
  String? Function(BuildContext, String)? textController5Validator;
}