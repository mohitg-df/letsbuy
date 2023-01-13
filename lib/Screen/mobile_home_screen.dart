import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/API/product_list_API.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Mobilehomescreen extends StatefulWidget {
  const Mobilehomescreen({Key? key}) : super(key: key);

  @override
  State<Mobilehomescreen> createState() => _MobilehomescreenState();
}

class _MobilehomescreenState extends State<Mobilehomescreen> {
  List<Product> product = [];
  String query = '';

  @override
  void initState() {
    wsapicall();
    // Future.delayed(Duration(milliseconds: 1500),(){
    //   foundlocationlist.addAll(product);
    // });
    super.initState();
  }

  Future wsapicall() async {
    final product = await Productlistapi.getwsProducts(context, query);

    setState(() => this.product = product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ScopedModelDescendant<Prodlistmodel>(
                    builder: (context, child, model) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber.shade400,
                      radius: 20,
                      child: Text(
                        '${product[index].name![0].toUpperCase()}',
                        style: TextStyle(color: Colors.black),
                      ), //Text
                    ),
                    title: AutoSizeText("${product[index].name}"),
                    subtitle:
                        AutoSizeText("Quatity- ${product[index].quantity}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                            "${product[index].prize} / ${product[index].unit}"),
                        SizedBox(
                          width: 15.0,
                        ),
                        product[index].itemOrderCount != null &&
                                product[index].itemOrderCount != 0
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      model.removeProduct(model.cart[index]);
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  AutoSizeText(
                                      "${product[index].itemOrderCount}"),
                                  IconButton(
                                    onPressed: () {
                                      model.updateProduct(
                                          model.cart[index],
                                          model.cart[index].itemOrderCount! +
                                              1);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              )
                            : OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  model.addProduct(product[index]);
// print("UI: ${product[index]}");
                                  const snackBar = SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Item Added in Cart'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: AutoSizeText("Add to Cart"),
                              ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
