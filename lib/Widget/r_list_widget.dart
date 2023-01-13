import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letsbuy/API/product_list_API.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/constant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class Rlistwidget extends StatefulWidget {
  @override
  RlistwidgetState createState() => RlistwidgetState();
}

class RlistwidgetState extends StateMVC<Rlistwidget> {
  List<Product> product = [];
  String query = '';

  List<int>? _selectdfile;
  Uint8List? _bytesdata;

  _startwebupload(id) async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesdata =
              Base64Decoder().convert(reader.result.toString().split(",").last);

          _selectdfile = _bytesdata;
          uploadimage(_selectdfile,id);
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadimage(file, id) async {
    // print(_selectdfile);
    var headers = {'Authorization': 'Bearer ${bearer_token}'};
    var request = http.MultipartRequest('POST',
        Uri.parse('${base_url}/hp/user/uploadImage?pid=${id.toString()}'));
    request.files.add(
      await http.MultipartFile.fromBytes('file', file,),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(headers);
    print(response.statusCode);
    var jsondata = jsonDecode(await response.stream.bytesToString());
    print(jsondata);

    response.statusCode == 200
        ? print("File Uploaded")
        : print("File Not Uploaded");
  }


  @override
  void initState() {
    super.initState();
    wsapicall();
  }

  Future wsapicall() async {
    final product = await Productlistapi.getrProducts(context, query);

    setState(() => this.product = product);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Productlistapi.getrProducts(context, query),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () {
                return Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    wsapicall();
                    // print("Pull to Refresh the list");
                  });
                });
              },
              child: wholesaleproduct(),
            );
          }
        });
  }

  Widget wholesaleproduct() {
    return Column(
      children: [
        // buildSearch(),
        Expanded(
          child: product.isNotEmpty
              ? GridView.builder(
            itemCount: product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 25.0,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return ScopedModelDescendant<Prodlistmodel>(
                builder: (context, child, model) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 2 * MediaQuery.of(context).size.width * 0.01,
                      right:
                      0.01 * MediaQuery.of(context).size.width * 0.01,
                      bottom: 10.0,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 10.0,
                          bottom: 5.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    child: Image.network(
                                      "${base_url}/hp/user/download/${product[index].id}",
                                      fit: BoxFit.cover,
                                      height: 620,
                                      width: 400,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        print("Camera Button Click");
                                        print("Camera Button Click");
                                        // pickImageGallery(product[index].id);
                                        _startwebupload(product[index].id);
                                      },
                                      child: CircleAvatar(
                                        radius: 1.2 *
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.01,
                                        backgroundColor:
                                        Color(0xff94d500),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 1.2 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AutoSizeText(
                              "${product[index].name}(${product[index].unit})",
                              style: product_prize_style(context),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            AutoSizeText(
                              "₹ ${product[index].prize}",
                              style: product_prize_style(context),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.amber,
                                  size: 1.2 *
                                      MediaQuery.of(context).size.width *
                                      0.01,
                                ),
                                product[index].itemOrderCount != null &&
                                    product[index].itemOrderCount != 0
                                    ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: Colors.blueGrey
                                        .withOpacity(0.45),
                                  ),
                                  width: 6 *
                                      MediaQuery.of(context)
                                          .size
                                          .width *
                                      0.01,
                                  height: 4 *
                                      MediaQuery.of(context)
                                          .size
                                          .height *
                                      0.01,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          model.removeProduct(
                                              model.cart[index]);
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 1.2 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                      ),
                                      AutoSizeText(
                                        "${product[index].itemOrderCount}",
                                        style: product_prize_style(
                                            context),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          model.updateProduct(
                                              model.cart[index],
                                              model.cart[index]
                                                  .itemOrderCount! +
                                                  1);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 1.2 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    : InkWell(
                                  onTap: () {
                                    model
                                        .addProduct(product[index]);
                                    // print("UI: ${product[index]}");
                                    const snackBar = SnackBar(
                                      duration:
                                      Duration(seconds: 1),
                                      content: Text(
                                          'Item Added in Cart'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      color: Colors.blueGrey
                                          .withOpacity(0.45),
                                    ),
                                    width: 6 *
                                        MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.01,
                                    height: 4 *
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                        0.01,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add to Cart",
                                        style: product_prize_style(
                                            context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
              : Center(
            child: AutoSizeText(
              "No Item Found List",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ListView.builder(
//     itemCount: product.length,
//     itemBuilder: (context, index) {
//       return ScopedModelDescendant<Prodlistmodel>(
//           builder: (context, child, model) {
//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.amber.shade400,
//                 radius: 20,
//                 child: Text(
//                   '${product[index].name![0].toUpperCase()}',
//                   style: TextStyle(color: Colors.black),
//                 ), //Text
//               ),
//               title: AutoSizeText("${product[index].name}"),
//               subtitle:
//               AutoSizeText("Quatity- ${product[index].quantity}"),
//               trailing: product[index].itemOrderCount != null && product[index].itemOrderCount != 0
//                   ?
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       model.removeProduct(model.cart[index]);
//                     },
//                     icon: Icon(Icons.remove),
//                   ),
//                   AutoSizeText("${product[index].itemOrderCount}"),
//                   IconButton(
//                     onPressed: () {
//                       model.updateProduct(model.cart[index],
//                           model.cart[index].itemOrderCount! + 1);
//                     },
//                     icon: Icon(Icons.add),
//                   ),
//                 ],
//               )
//                   :
//               OutlinedButton(
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   model.addProduct(product[index]);
//                   // print("UI: ${product[index]}");
//                   const snackBar = SnackBar(
//                     duration: Duration(seconds: 1),
//                     content: Text('Item Added in Cart'),
//                   );
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(snackBar);
//                 },
//                 child: AutoSizeText("Add to Cart"),
//               ),
//             );
//           });
//     })
