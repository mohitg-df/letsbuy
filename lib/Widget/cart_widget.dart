import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/constant.dart';
import 'package:scoped_model/scoped_model.dart';

class Cartwidget extends StatelessWidget {
  const Cartwidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel.of<Prodlistmodel>(context, rebuildOnChange: true)
                .cart
                .length ==
            0
        ? Center(
            child: Text(
              "No items in Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        ScopedModel.of<Prodlistmodel>(context).clearCart();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: Colors.blueGrey
                              .withOpacity(0.45),
                        ),
                        width: 6 * MediaQuery.of(context).size.width *0.01,
                        height: 4 * MediaQuery.of(context).size.height * 0.01,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Clear All",
                            style: product_prize_style(
                                context),
                          ),
                        ),
                      ),
                    ),
                    AutoSizeText(
                      "Total: \u20B9 " + ScopedModel.of<Prodlistmodel>(context,
                          rebuildOnChange: true)
                          .totalCartValue
                          .toString(),
                      style: product_prize_style(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ScopedModel.of<Prodlistmodel>(context,
                            rebuildOnChange: true)
                        .total,
                    itemBuilder: (context, index) {
                      return ScopedModelDescendant<Prodlistmodel>(
                        builder: (context, child, model) {
                          final totalprice = model.cart[index].itemOrderCount! *
                              model.cart[index].prize!;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: AutoSizeText(
                                    "${model.cart[index].name}",
                                    style: product_prize_style(context),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: AutoSizeText(
                                      "${model.cart[index].itemOrderCount} * ₹ ${model.cart[index].prize} = ₹ ${totalprice}",
                                      style: product_prize_style(context),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          model
                                              .removeProduct(model.cart[index]);
                                        },
                                        child: Icon(Icons.remove),
                                      ),
                                      SizedBox(
                                        width: 0.8 *
                                            MediaQuery.of(context).size.width *
                                            0.01,
                                      ),
                                      AutoSizeText(
                                        "${model.cart[index].itemOrderCount}",
                                        style: product_prize_style(context),
                                      ),
                                      SizedBox(
                                        width: 1 *
                                            MediaQuery.of(context).size.width *
                                            0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.updateProduct(
                                              model.cart[index],
                                              model.cart[index]
                                                      .itemOrderCount! +
                                                  1);
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ],
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
              ],
            ),
          );
  }
}
