import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/Model/product_unit_model.dart';
import 'package:letsbuy/Screen/cart_screen.dart';
import 'package:letsbuy/Widget/r_list_widget.dart';
import 'package:letsbuy/constant.dart';

class Rlistscreen extends StatefulWidget {
  const Rlistscreen({Key? key}) : super(key: key);

  @override
  State<Rlistscreen> createState() => _RlistscreenState();
}

class _RlistscreenState extends State<Rlistscreen> {
  List<String> _units = [
    "KG","Gram","Quantal"
  ];

  String? _selectunit;

  List<Product> product = [];



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            AutoSizeText(
              "Retail Product",
              style: product_heading_style(context),
            ),
            Divider(
              color: Colors.black26,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Rlistwidget(),
                  ),
                  // VerticalDivider(
                  //   color: Colors.black,
                  //   thickness: 2,
                  // ),
                  // Container(
                  //   margin: EdgeInsets.all(8.0),
                  //   width: 12 * MediaQuery.of(context).size.width * 0.01,
                  //   height: double.infinity,
                  //   child: Column(
                  //     children: [
                  //       AutoSizeText(
                  //         "Search By Unit",
                  //         style: product_prize_style(context),
                  //       ),
                  //       Divider(
                  //         color: Colors.black26,
                  //       ),
                  //       Expanded(
                  //         child: ListView.separated(
                  //           controller: ScrollController(),
                  //           itemCount: _units.length,
                  //           separatorBuilder: (_, __)=> const SizedBox(height: 5),
                  //           itemBuilder: (context, index){
                  //             return RadioListTile(
                  //               title: Text(_units[index].toString()),
                  //               value: _units[index],
                  //               groupValue: _selectunit,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   _selectunit = value.toString();
                  //                 });
                  //               },
                  //             );
                  //           },
                  //
                  //         ),
                  //         // ListView.builder(
                  //         //   itemCount: _units.length,
                  //         //   itemBuilder: (context, index) {
                  //         //     return ListTile(
                  //         //       leading: RadioListTile(
                  //         //           value: "${_units[index]}",
                  //         //           groupValue: _selectunit,
                  //         //           onChanged: (value) {
                  //         //             setState(() {
                  //         //               _selectunit = value.toString();
                  //         //             }); //selected value
                  //         //           }),
                  //         //       title: Text("${_units[index].unitname}"),
                  //         //     );
                  //         //   },
                  //         // ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
