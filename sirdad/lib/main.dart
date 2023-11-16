import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/firebase_options.dart';

import 'package:sirdad/getters/miembro_model.dart';
import 'package:sirdad/provider/members_provider.dart';
import 'package:sirdad/widget/acceso_widget.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/format_widget.dart';
import 'package:sirdad/widget/login_widget.dart';
import 'package:sirdad/widget/miembro_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    final app = Firebase.app();
    print("Firebase se ha inicializado correctamente: ${app.name}");
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }

  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => miembroModel),
        ChangeNotifierProvider(create: (_) => FamilyModel),
        ChangeNotifierProvider(create: (_) => memberData),
        ChangeNotifierProvider(create: (_) => EventModel),
        ChangeNotifierProvider(create: (_) => accesoModel),
        // ChangeNotifierProvider(create: (_) => )

        //Colocar aquí todos los ChangeNotifierProvider de los modelos que se van a usar
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
          home: MyApp()
          //const FormatWidget()
          // ChangeNotifierProvider(
          //   create: (context) => familyModel,
          //   child: const FormatWidget(),

          // )
          ),
    );
  }
}

