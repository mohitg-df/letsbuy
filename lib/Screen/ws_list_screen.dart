import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/Model/product_unit_model.dart';
import 'package:letsbuy/Screen/cart_screen.dart';
import 'package:letsbuy/Widget/ws_list_widget.dart';
import 'package:letsbuy/constant.dart';

class WSlistscreen extends StatefulWidget {
  const WSlistscreen({Key? key}) : super(key: key);

  @override
  State<WSlistscreen> createState() => _WSlistscreenState();
}

class _WSlistscreenState extends State<WSlistscreen> {
  List<String> _units = ["KG", "Gram", "Quantal"];

  String? _selectunit;

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
              "Wholesale Product",
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
                    child: WSlistwidget(),
                  ),
                  // VerticalDivider(
                  //   color: Colors.black,
                  //   thickness: 2,
                  // ),
                  // Container(
                  //   margin: EdgeInsets.all(8.0),
                  //   width: 12 * MediaQuery.of(context).size.width * 0.01,
                  //   height: double.infinity,
                  //   // color: Colors.lightGreen,
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
                  //           separatorBuilder: (_, __) =>
                  //               const SizedBox(height: 5),
                  //           itemBuilder: (context, index) {
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
                  //         ),
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
