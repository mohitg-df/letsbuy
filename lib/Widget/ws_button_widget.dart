// import 'package:flutter/material.dart';
//
// class WSbuttonwidget extends StatelessWidget {
//   const WSbuttonwidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeInLeft(
//       duration: const Duration(seconds: 1),
//       animate: true,
//       child: Column(
//         children: [
//           AutoSizeText(
//             "Wholesale".toUpperCase(),
//             style: typesstyle(context),
//           ),
//           AutoSizeText(
//             "All Product at one place in Wholesale Price.",
//             style: detailswholesale(context),
//           ),
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Add Whloesale Product
//
//               // Container(
//               //   margin: EdgeInsets.symmetric(vertical: 20),
//               //   padding: EdgeInsets.all(15),
//               //   decoration: BoxDecoration(
//               //     color: Color(0xFF372930),
//               //     borderRadius: BorderRadius.circular(34),
//               //   ),
//               //   child: Row(
//               //     children: <Widget>[
//               //       Container(
//               //         padding: EdgeInsets.all(8),
//               //         height: 28,
//               //         width: 28,
//               //         decoration: const BoxDecoration(
//               //           color: kPrimaryColor,
//               //           shape: BoxShape.circle,
//               //         ),
//               //         child: Container(
//               //           decoration: const BoxDecoration(
//               //             color: Color(0xFF372930),
//               //             shape: BoxShape.circle,
//               //           ),
//               //         ),
//               //       ),
//               //       SizedBox(width: 15),
//               //       InkWell(
//               //         onTap: () {
//               //           Navigator.of(context).push(
//               //             PageRouteBuilder(
//               //               pageBuilder:
//               //                   (context, animation, secondaryAnimation) =>
//               //                       Wholesaleaddproscreen(
//               //                 custid: widget.custid,
//               //                 custfname: widget.custfname,
//               //               ),
//               //               transitionsBuilder: (context, animation,
//               //                   secondaryAnimation, child) {
//               //                 var begin = const Offset(0.0, 1.0);
//               //                 var end = Offset.zero;
//               //                 var curve = Curves.easeInBack;
//               //
//               //                 var tween = Tween(begin: begin, end: end)
//               //                     .chain(CurveTween(curve: curve));
//               //
//               //                 return SlideTransition(
//               //                   position: animation.drive(tween),
//               //                   child: child,
//               //                 );
//               //               },
//               //             ),
//               //           );
//               //           // print("User Tap Wholesale Button");
//               //         },
//               //         child: AutoSizeText(
//               //           "Inventory".toUpperCase(),
//               //           textAlign: TextAlign.center,
//               //           style: getstarted(context),
//               //         ),
//               //       ),
//               //       const SizedBox(width: 15),
//               //     ],
//               //   ),
//               // ),
//               // space between both the buttons
//               SizedBox(
//                 width: 2 * MediaQuery.of(context).size.width * 0.01,
//               ),
//               // Buy Products
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 20),
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF372930),
//                   borderRadius: BorderRadius.circular(34),
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       height: 28,
//                       width: 28,
//                       decoration: const BoxDecoration(
//                         color: kPrimaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF372930),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     // Add Navigation location
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(
//                           PageRouteBuilder(
//                             pageBuilder:
//                                 (context, animation, secondaryAnimation) =>
//                                 WSUserProductList(
//                                   custid: widget.custid,
//                                   custfname: widget.custfname,
//                                 ),
//                             transitionsBuilder: (context, animation,
//                                 secondaryAnimation, child) {
//                               var begin = const Offset(0.0, 1.0);
//                               var end = Offset.zero;
//                               var curve = Curves.easeInBack;
//
//                               var tween = Tween(begin: begin, end: end)
//                                   .chain(CurveTween(curve: curve));
//
//                               return SlideTransition(
//                                 position: animation.drive(tween),
//                                 child: child,
//                               );
//                             },
//                           ),
//                         );
//                         // print("User Tap Buy Product Wholesale Button");
//                       },
//                       child: AutoSizeText(
//                         "Buy Products".toUpperCase(),
//                         textAlign: TextAlign.center,
//                         style: getstarted(context),
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
