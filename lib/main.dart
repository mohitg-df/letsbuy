import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/Screen/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp(
    model: Prodlistmodel(),
  ));
}

class MyApp extends StatelessWidget {
  final Prodlistmodel model;

  const MyApp({Key? key, required this.model}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Prodlistmodel>(
      model: model,
      child:   MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Homescreen(),
      ),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   bool viewVisible = true;
//
//   void showWidget() {
//     setState(() {
//       viewVisible = true;
//     });
//   }
//
//   void hideWidget() {
//     setState(() {
//       viewVisible = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Demo Mode"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Visibility(
//                 maintainSize: true,
//                 maintainAnimation: true,
//                 maintainState: true,
//                 visible: viewVisible,
//                 child: Container(
//                   height: 200,
//                   width: 200,
//                   color: Colors.green,
//                   margin: EdgeInsets.only(top: 50, bottom: 30),
//                   child: Center(
//                     child: Text(
//                       'Show Hide Text View Widget in Flutter',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 23,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               MaterialButton(
//                 child: Text('Hide Widget on Button Click'),
//                 onPressed: hideWidget,
//                 color: Colors.pink,
//                 textColor: Colors.white,
//                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//               ),
//               MaterialButton(
//                 child: Text('Show Widget on Button Click'),
//                 onPressed: showWidget,
//                 color: Colors.pink,
//                 textColor: Colors.white,
//                 padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

