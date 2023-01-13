import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:letsbuy/Screen/cart_screen.dart';
import 'package:letsbuy/Screen/r_list_screen.dart';
import 'package:letsbuy/Screen/ws_list_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:letsbuy/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({Key? key}) : super(key: key);

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  List<int>? _selectdfile;
  Uint8List? _bytesdata;

  _startwebupload() async {
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
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadimage() async {
    // print(_selectdfile);
    var headers = {'Authorization': 'Bearer ${bearer_token}'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${base_url}/hp/user/upload'));
    request.files.add(
      await http.MultipartFile.fromBytes('file', _bytesdata!,
          filename: "Anyname"),
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText("Flutter Demo"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cartscreen()),
                  );
                },
                icon: Icon(Icons.shopping_bag),
              ),
            ],
            bottom: TabBar(
              automaticIndicatorColorAdjustment: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(3.0),
              tabs: [
                Tab(
                  child: AutoSizeText("Wholesale"),
                ),
                Tab(
                  child: AutoSizeText("Retail"),
                ),
                Tab(
                  child: AutoSizeText("Image"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              WSlistscreen(),
              Rlistscreen(),
              _bytesdata != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.memory(_bytesdata!, width: 200, height: 300),
                          MaterialButton(
                            onPressed: () => uploadimage(),
                            child: Text("Upload"),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.mode_rounded,
            children: [
              SpeedDialChild(
                child: Icon(Icons.download),
                label: "Download",
                backgroundColor: Colors.blueGrey,
                onTap: () {
                  _launchURLBrowser();
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.upload),
                label: "Upload File",
                backgroundColor: Colors.blueGrey,
                onTap: () async {
                  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

                  if (selectedDirectory == null) {
                    print(selectedDirectory);
                    // User canceled the picker
                  }
                  else{
                    print("user Cancel the selected file");
                  }
                  // _startwebupload();
                  // Future.delayed(Duration(seconds: 2), () {
                  //   uploadimage();
                  // });

                  // uploadfile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURLBrowser() async {
    var url = Uri.parse("${base_url}/hp/download");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// final Dio dio = Dio();
// bool loading = false;
// double progress = 0;
//
// Future<bool> savefile(String url, String filename) async {
//   Directory directory;
//
//   try {
//     if (Platform.isAndroid) {
//       if (await _requestpermission(Permission.storage)) {
//         directory = (await getExternalStorageDirectory())!;
//         print(directory.path);
//         String newpath = "";
//         List<String> folders = directory.path.split("/");
//         // /storage/emulated/0/Android/data/com.example.letsbuy/files
//         for (int x = 1; x < folders.length; x++) {
//           String folder = folders[x];
//           if (folder != "Android") {
//             newpath += "/" + folder;
//           } else {
//             break;
//           }
//         }
//         newpath = newpath + "/letsbuy";
//         directory = Directory(newpath);
//         print(directory);
//       } else {
//         return false;
//       }
//     } else {
//       if (await _requestpermission(Permission.storage)) {
//         directory = await getTemporaryDirectory();
//       } else {
//         return false;
//       }
//     }
//     if (!await directory.exists()) {
//       await directory.create(recursive: true);
//     }
//     if (await directory.exists()) {
//       File savefile = File(directory.path + "/$filename");
//       await dio.download(url, savefile.path,
//           onReceiveProgress: (downloaded, totalsize) {
//             setState(() {
//               progress = downloaded / totalsize;
//             });
//           });
//       // For IOS
//       // if(Platform.isIOS){
//       //   ImageGall
//       // }
//       return true;
//     }
//   } catch (e) {
//     print(e);
//   }
//   return false;
// }
//
// _requestpermission(Permission permission) async {
//   if (await permission.isGranted) {
//     return true;
//   } else {
//     var result = await permission.request();
//     result == PermissionStatus.granted ? true : false;
//   }
// }

// downloadfile() async {
//   setState(() {
//     loading = true;
//     progress = 0;
//   });
//   var downloaded =
//   await savefile("${base_url}/hp/download", "productdetails.xlsx");
//   if (downloaded) {
//     print("File Downloaded");
//   } else {
//     print("Problem Downloading File");
//   }
// }
}
