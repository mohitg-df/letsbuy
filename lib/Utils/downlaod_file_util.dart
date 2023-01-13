import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:letsbuy/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloadfileutil extends StatefulWidget {
  const Downloadfileutil({Key? key}) : super(key: key);

  @override
  State<Downloadfileutil> createState() => _DownloadfileutilState();
}

class _DownloadfileutilState extends State<Downloadfileutil> {

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<bool> savefile(String url, String filename) async {
    Directory directory;

    try {
      if (Platform.isAndroid) {
        if (await _requestpermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          print(directory.path);
          String newpath = "";
          List<String> folders = directory.path.split("/");
          // /storage/emulated/0/Android/data/com.example.letsbuy/files
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newpath += "/" + folder;
            } else {
              break;
            }
          }
          newpath = newpath + "/letsbuy";
          directory = Directory(newpath);
          print(directory);
        } else {
          return false;
        }
      } else {
        if (await _requestpermission(Permission.storage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File savefile = File(directory.path + "/$filename");
        await dio.download(url, savefile.path,
            onReceiveProgress: (downloaded, totalsize) {
              setState(() {
                progress = downloaded / totalsize;
              });
            });
        // For IOS
        // if(Platform.isIOS){
        //   ImageGall
        // }
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  _requestpermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      result == PermissionStatus.granted ? true : false;
    }
  }

  downloadfile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded =
    await savefile("${base_url}/hp/download", "productdetails.xlsx");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? LinearProgressIndicator(
          minHeight: 10,
          value: progress,
        )
            : ElevatedButton.icon(
          icon: Icon(Icons.download),
          onPressed: () {
            downloadfile();
          },
          label: Text("Download Video"),
        ),
      ),
    );
  }
}
