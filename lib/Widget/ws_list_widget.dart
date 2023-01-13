import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:letsbuy/API/product_list_API.dart';
import 'package:letsbuy/Model/product_list_model.dart';
import 'package:letsbuy/constant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class WSlistwidget extends StatefulWidget {
  @override
  WSlistwidgetState createState() => WSlistwidgetState();
}

class WSlistwidgetState extends StateMVC<WSlistwidget> {
  List<Product> product = [];
  String query = '';
  List<int>? _selectdfile;

  Uint8List? _bytesdata;

  // final ImagePicker _picker = ImagePicker();
  // XFile? _imageFile;

  // List<int>? _selectdfile;
  // Uint8List? _bytesdata;
  //
  // _startwebupload(id) async {
  //   print(id);
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true;
  //   uploadInput.draggable = true;
  //   uploadInput.click();
  //
  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files;
  //     final file = files![0];
  //     final reader = html.FileReader();
  //
  //     reader.onLoadEnd.listen((event) {
  //       setState(() {
  //         _bytesdata =
  //             Base64Decoder().convert(reader.result.toString().split(",").last);
  //
  //         _selectdfile = _bytesdata;
  //         // print("selected file: ${_selectdfile.toString()}");
  //         print("bytes file: ${_bytesdata.toString()}");
  //         uploadimage(_bytesdata, id);
  //       });
  //     });
  //     reader.readAsDataUrl(file);
  //   });
  // }
  // //
  // Future uploadimage(file, id) async {
  //   print(file);
  //   var headers = {'Authorization': 'Bearer ${bearer_token}'};
  //   var request = http.MultipartRequest('POST',
  //       Uri.parse('${base_url}/hp/user/uploadImage?pid=${id.toString()}'));
  //   request.files.add(
  //     await http.MultipartFile.fromPath('gifFile', file!.toString()),
  //   );
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   print(headers);
  //   print(response.statusCode);
  //   print(jsonDecode(await response.stream.bytesToString()));
  //
  //   response.statusCode == 200
  //       ? print("File Uploaded")
  //       : print("File Not Uploaded");
  // }

  // List<Product> foundlocationlist = [];

  // Future pickImageGallery(id) async {
  //   try {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     _imageFile = await pickedFile;
  //     print(_imageFile);
  //     await uploadImage(id, _imageFile?.path);
  //   } catch (e) {
  //     print("Image Picker error $e");
  //   }
  // }
  //
  // Future uploadImage(id, filepath) async {
  //   var headers = {
  //     'Authorization': 'Bearer d7896a38-7bd8-4e89-9284-3d0eede6f769'
  //   };
  //   var request = http.MultipartRequest('POST',
  //       Uri.parse("${base_url}/hp/user/uploadImage?pid=${id.toString()}"));
  //   request.headers.addAll(headers);
  //   request.files.add(await http.MultipartFile.fromPath('image', filepath));
  //   var res = await request.send();
  //   var responseData = await res.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   var d = jsonDecode(responseString);
  //   print("Response ${d.toString()}");
  // }

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
        Uri.parse('${base_url}hp/user/uploadImage?pid=${id.toString()}'));
    request.files.add(
      await http.MultipartFile.fromBytes('file', file,),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(headers);
    print(response.statusCode);
    print(jsonDecode(await response.stream.bytesToString()));

    response.statusCode == 200
        ? print("File Uploaded")
        : print("File Not Uploaded");
  }

  @override
  void initState() {
    wsapicall();
    // Future.delayed(Duration(milliseconds: 1500),(){
    //   foundlocationlist.addAll(product);
    // });
    super.initState();
  }

  // void runSearchFilter(enteredText) {
  //   var results = List.filled(foundlocationlist.length, "0", growable: true);
  //
  //   if (enteredText.isEmpty) {
  //     results = product.cast<String>();
  //   } else {
  //     product.where((product) => product.name
  //         .toString()
  //         .toLowerCase()
  //         .contains(enteredText.toLowerCase())).toList();
  //   }
  //   setState(() {
  //     foundlocationlist = results.cast<Product>();
  //   });
  // }

  @override
  void dispose() {
    // debouncer?.cancel();
    super.dispose();
  }

  Future wsapicall() async {
    final product = await Productlistapi.getwsProducts(context, query);

    setState(() => this.product = product);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Productlistapi.getwsProducts(context, query),
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
        Expanded(
          child: product.isNotEmpty
              ? GridView.builder(
                  itemCount: product.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
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
                                    // child: FadeInImage(
                                    //   image: NetworkImage(
                                    //       "http://media.geeksforgeeks.org/wp-content/uploads/20210318103632/gfg-300x300.png"),
                                    //   placeholder: AssetImage(
                                    //     "assets/product.png",
                                    //   ),
                                    // ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: Image.network(
                                            "${product[index].imageurl}",
                                            fit: BoxFit.cover,
                                            height: 620,
                                            width: 400,
                                          ),
                                          // Image.asset(
                                          //   "assets/homepageimage.png",
                                          //   // "${product[index].imageurl}",
                                          //   fit: BoxFit.cover,
                                          //   height: 620,
                                          //   width: 400,
                                          // ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () async {
                                              print("Camera Button Click");
                                              // pickImageGallery(product[index].id);
                                              // _startwebupload(product[index].id);
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
                                    "${product[index].name}",
                                    style: product_prize_style(context),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  AutoSizeText(
                                    "₹ ${product[index].prize} / ${product[index].unit}",
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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

  Widget mobilehomeview() {
    return Column(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                })),
      ],
    );
  }
}
