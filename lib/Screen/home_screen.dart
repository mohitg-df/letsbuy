import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:letsbuy/Screen/cart_screen.dart';
import 'package:letsbuy/Screen/r_list_screen.dart';
import 'package:letsbuy/Screen/ws_list_screen.dart';
import 'package:letsbuy/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:side_navigation/side_navigation.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<int>? _selectdfile;

  Uint8List? _bytesdata;

  int selectedIndex = 3;

  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    WSlistscreen(),
    Rlistscreen(),
    Cartscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            "${appbar_title}",
            style: appbar__title_style(),
          ),
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
                _startwebupload();
                // gethttp();
              },
            ),
          ],
        ),
        body: Row(
          children: [
            SideNavigationBar(
              expandable: true,
              // initiallyExpanded = true,
              // header: SideNavigationBarHeader(
              //   image: Image.asset(
              //     "assets/product.png",
              //     width: 3 * MediaQuery.of(context).size.width * 0.01,
              //     height: 3 * MediaQuery.of(context).size.width * 0.01,
              //   ),
              //   title: Text('Title widget'),
              //   subtitle: Text('Subtitle widget'),
              // ),
              // footer: SideNavigationBarFooter(
              //   label: InkWell(
              //     onTap: (){},
              //     child: Text('Logout'),
              //   ),
              // ),
              selectedIndex: selectedIndex,
              items: const [
                SideNavigationBarItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                ),
                SideNavigationBarItem(
                  icon: Icons.shopping_bag_sharp,
                  label: 'Wholesale',
                ),
                SideNavigationBarItem(
                  icon: Icons.shopping_bag_sharp,
                  label: 'Retail',
                ),
                SideNavigationBarItem(
                  icon: Icons.shopping_cart,
                  label: 'Cart',
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: views.elementAt(selectedIndex),
            ),
          ],
        ),
      ),
    );
  }

  // Download file function
  _launchURLBrowser() async {
    var url = Uri.parse("${base_url}/hp/download");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Select the Photo from  any location function
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
          uploadimage(_selectdfile);
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  // Upload Selected Photo to the server function
  Future uploadimage(file) async {
    // print(_selectdfile);
    var headers = {'Authorization': 'Bearer ${bearer_token}'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${base_url}/hp/user/upload'));
    request.files.add(
      await http.MultipartFile.fromBytes('file', file,
          filename: "productetail.xlsx"),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(headers);
    print(response.statusCode);
    print(jsonDecode(await response.stream.bytesToString()));

    response.statusCode == 200
        ? showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Simple Alert"),
          content: Text("This is an alert message."),
          actions: [

          ],
        );
      },
    )
    : print("File Not Uploaded");
  }

}
