import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirdad/provider/members_provider.dart';

import 'package:sirdad/widget/miembro_widget.dart';

// class FormatWidget extends StatefulWidget {
//   const FormatWidget({super.key});

//   @override
//   _FormatWidgetState createState() => _FormatWidgetState();
// }

// class _FormatWidgetState extends State<FormatWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           title: const Text(
//             'EDAN',
//             style: TextStyle(
//               fontFamily: 'outfit',
//               color: Colors.white,
//               fontSize: 22,
//             ),
//           ),
//           actions: [],
//           centerTitle: false,
//           elevation: 2,
//         ),
//         body: Consumer<Members_Provider>(
//             child: const Text("no hay miembros"),
//             builder: (_, membersProvider, child) => (child != null &&
//                     membersProvider.members.isEmpty)
//                 ? child
//                 : ListView.builder(
//                     padding: EdgeInsets.all(8.0),
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: ( context, index){
//                       [
//                         ListTile(
//                             title:  Text(membersProvider.members[index].name),
//                             subtitle: Text(membersProvider.members[index].nid.toString()),
//                             // title: Text(
//                             //   'Hijo',
//                             // ),
//                             // subtitle: Text(
//                             //   'cedula',
//                             //   style: TextStyle(color: Colors.grey),
//                             // ),
//                             // trailing: Icon(
//                             //   Icons.arrow_forward_ios,
//                             //   color: Colors.grey,
//                             //   size: 20,
//                             // ),
//                             ),
//                         Expanded(
//                             child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             // cambiar por un child y agregar la estructura de la lista de miembros en format_privider
//                             Align(
//                               alignment: AlignmentDirectional(0.0, 1.0),
//                               child: Ink(
//                                 decoration: const ShapeDecoration(
//                                     color: Color.fromARGB(255, 193, 102, 209),
//                                     shape: CircleBorder(
//                                         side: BorderSide(
//                                             color: Colors.deepPurple,
//                                             width: 3))),
//                                 child: IconButton(
//                                   color: Colors.white,
//                                   iconSize: 50,
//                                   icon: Icon(
//                                     Icons.add,
//                                     size: 24,
//                                   ),
//                                   onPressed: () async {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const Miembro_Widget()));
//                                   },
//                                 ),
//                               ),
//                             )
//                           ],
//                         ))
//                       ];
//                     },
//                   )),
//       ),
//     );
//   }
// }
