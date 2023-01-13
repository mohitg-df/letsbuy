import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/PDF/labour_pdf.dart';
import 'package:letsbuy/constant.dart';

class Paymenttypescreen extends StatefulWidget {
  const Paymenttypescreen({Key? key}) : super(key: key);

  @override
  State<Paymenttypescreen> createState() => _PaymenttypescreenState();
}

class _PaymenttypescreenState extends State<Paymenttypescreen> {

  bool viewVisible = false;

  showprintoption(){
    setState(() {
      viewVisible = true;
    });
  }

  hideprintoption(){
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AutoSizeText(
            "You have selected items in COD",
            style: product_prize_style(context),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {
              showprintoption();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey.withOpacity(0.45),
              ),
              width: 6 * MediaQuery.of(context).size.width * 0.01,
              height: 4 * MediaQuery.of(context).size.height * 0.01,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Proceed",
                  style: product_prize_style(context),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              hideprintoption();
              Future.delayed(Duration(milliseconds: 1200),(){
                Navigator.of(context).pop();
              });
            },
            child: Text(
              "Cancel",
              style: product_prize_style(context),
            ),
          ),
          Divider(
            color: Colors.black26,
          ),
          SizedBox(
            height: 20.0,
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: viewVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Labourpdf()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.45),
                    ),
                    width: 6 * MediaQuery.of(context).size.width * 0.01,
                    height: 4 * MediaQuery.of(context).size.height * 0.01,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Labour Print",
                        style: product_prize_style(context),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.45),
                    ),
                    width: 6 * MediaQuery.of(context).size.width * 0.01,
                    height: 4 * MediaQuery.of(context).size.height * 0.01,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "English Print",
                        style: product_prize_style(context),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey.withOpacity(0.45),
                    ),
                    width: 6 * MediaQuery.of(context).size.width * 0.01,
                    height: 4 * MediaQuery.of(context).size.height * 0.01,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Hindi Print",
                        style: product_prize_style(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
