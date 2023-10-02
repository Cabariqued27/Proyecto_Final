
import 'package:flutter/material.dart';
import 'package:sirdad/models/family.dart';
import 'package:sirdad/models/member.dart';
import 'package:sirdad/models/volunteer.dart';
import 'models/event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


 void main() async {

   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
   runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

    
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Flutter Demo',
       theme: ThemeData(
          
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         useMaterial3: true,
       ),
       home: const MyHomePage(title: 'SIRDAD'),
     );
   }
 }

 class MyHomePage extends StatefulWidget {
   const MyHomePage({super.key, required this.title});

    

   final String title;

   @override
   State<MyHomePage> createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   String events='';
   String familys='';
   String members='';
   String volunteers='';



   @override
   void initState(){
     getEvents();
     getFamilys();
     getMembers();
     getVolunteers();
     super.initState();
   }


 getVolunteers() async {
   List volunteers = await Volunteer().getVolunteers();
   print('Voluntarios obtenidas: $volunteers');
   setState(() {
     this.volunteers = volunteers.toString();
   });
 }

   getFamilys() async {
   List familys = await Family().getFamilys();
   print('Familias obtenidas: $familys');
   setState(() {
     this.familys = familys.toString();
   });
 }
   getEvents()async{
     List events = await Event().getEvents();
     print('Eventos obtenidas: $events');
     setState(() {
       this.events=events.toString();
     });
   }
   getMembers()async{
     List members = await Member().getMembers();
     print('Miembros obtenidos: $members');
     setState(() {
       this.members=members.toString();
     });
   }
  



  void _incrementCounter() async {
   Event event = Event(name: 'davidcabarique', description: 'prueba', date: 'hoy');
   await event.save();
  
   Family family = Family(barrio: 'salamanca', address: 'asdasd', phone: 5465465465, date: 'asdasddd', eventId: 1);
   await family.save();

   
   

   Volunteer volunteer = Volunteer(namev: 'primerv', nidv:55, phonev: 3225, ong: 'siu', sign: 'firma', news: 'no paso nada');
   await volunteer.save();

   await getEvents();
   await getFamilys();
   await getMembers();
   await getVolunteers();
  
    //Actualiza las variables y la interfaz de usuario
    setState(() {
     //No es necesario asignar las variables nuevamente aquí
      events;
      familys;
      members;
      volunteers;
   });
 }

   @override
   Widget build(BuildContext context) {
      /*This method is rerun every time setState is called, for instance as done
      by the _incrementCounter method above.
     
      The Flutter framework has been optimized to make rerunning build methods
      fast, so that you can just rebuild anything that needs updating rather
      than having to individually change instances of widgets.*/
     return Scaffold(
       appBar: AppBar(
          
         title: Text(widget.title),
       ),
       body: Center(
         // Center is a layout widget. It takes a single child and positions it
          //in the middle of the parent.
         child: Column(
            
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             const Text(
               'You have pushed the button this many times:',
             ),
             Text(
               events,
               style: Theme.of(context).textTheme.headlineMedium,
             ),
             Text(
               familys,
               style: Theme.of(context).textTheme.headlineMedium,
             ),Text(
               members,
               style: Theme.of(context).textTheme.headlineMedium,
             ),Text(
               volunteers,
               style: Theme.of(context).textTheme.headlineMedium,
             ),

           ],
         ),
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: _incrementCounter,
         tooltip: 'Increment',
         child: const Icon(Icons.add),
       ),  //This trailing comma makes auto-formatting nicer for build methods.
     );
   }
 }