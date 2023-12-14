import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/firebase_options.dart';
import 'package:sirdad/getters/volunteer_model.dart';
import 'package:sirdad/pages/login_page.dart';
import 'package:sirdad/widget/admin_widget.dart';
import 'package:sirdad/widget/event_widget.dart';
import 'package:sirdad/widget/family_widget.dart';
import 'package:sirdad/widget/member_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseDatabase database;
  database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
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
        ChangeNotifierProvider(create: (_) => volunteerData),
        ChangeNotifierProvider(create: (_) => familyData),
        ChangeNotifierProvider(create: (_) => memberData),
        ChangeNotifierProvider(create: (_) => eventData),
        //ChangeNotifierProvider(create: (_) => userProvider),
        // ChangeNotifierProvider(create: (_) => )

        //Colocar aquí todos los ChangeNotifierProvider de los modelos que se van a usar
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
          home: VolunteerListScreen()
          //const FormatWidget()
          // ChangeNotifierProvider(
          //   create: (context) => familyModel,
          //   child: const FormatWidget(),

          // )
          ),
    );
  }
}
