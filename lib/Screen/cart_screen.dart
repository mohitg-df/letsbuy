import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/Screen/payment_type_screen.dart';
import 'package:letsbuy/Widget/cart_widget.dart';
import 'package:letsbuy/constant.dart';
import 'package:scoped_model/scoped_model.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({Key? key}) : super(key: key);

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
              "Your Orders",
              style: product_heading_style(context),
            ),
            Divider(
              color: Colors.black26,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Cartwidget(),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    width: 20 * MediaQuery.of(context).size.width * 0.01,
                    height: double.infinity,
                    child: ScopedModel.of<Prodlistmodel>(context,
                                    rebuildOnChange: true)
                                .cart
                                .length ==
                            0
                        ? Center(
                            child: Text(
                              "No Items For Billing",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              AutoSizeText(
                                "Checkout Items",
                                style: product_prize_style(context),
                              ),
                              Divider(
                                color: Colors.black26,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    right: 2.0,
                                    left: 2.0,
                                    bottom: 8.0,
                                  ),
                                  child: ListView.builder(
                                    itemCount: ScopedModel.of<Prodlistmodel>(
                                            context,
                                            rebuildOnChange: true)
                                        .total,
                                    itemBuilder: (context, index) {
                                      return ScopedModelDescendant<
                                          Prodlistmodel>(
                                        builder: (context, child, model) {
                                          final totalprice = model
                                                  .cart[index].itemOrderCount! *
                                              model.cart[index].prize!;
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: AutoSizeText(
                                                    "${model.cart[index].name}",
                                                    style: product_prize_style(
                                                        context),
                                                  ),
                                                  subtitle: AutoSizeText(
                                                    "Quantity: ${model.cart[index].itemOrderCount}",
                                                    style: product_prize_style(
                                                        context),
                                                  ),
                                                  trailing: AutoSizeText(
                                                    "₹ ${totalprice}",
                                                    style: product_prize_style(
                                                        context),
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.black26,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        //this right here
                                        child: Container(
                                          height: 200,
                                          width: 600,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Paymenttypescreen(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blueGrey.withOpacity(0.45),
                                  ),
                                  width: 6 *
                                      MediaQuery.of(context).size.width *
                                      0.01,
                                  height: 4 *
                                      MediaQuery.of(context).size.height *
                                      0.01,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Checkout",
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
            ),
          ],
        ),
      ),
    );
  }
}
