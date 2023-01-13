import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

dynamic base_url = "http://ec2-35-78-234-61.ap-northeast-1.compute.amazonaws.com:8080/dukanapp/api/dukan";
dynamic bearer_token = "d7896a38-7bd8-4e89-9284-3d0eede6f769";
dynamic appbar_title = "Let'S Buy";

const kPrimaryColor = Color(0xFFFFC200);
const kTextcolor = Color(0xFF241424);
const kDarkButton = Color(0xFF372930);

const apptextxcolor = Colors.white;
dynamic _notpagereload;


TextStyle appbar__title_style() => GoogleFonts.acme(
  textStyle: TextStyle(
    color: apptextxcolor,
    fontSize: 18,
  ),
);

TextStyle product_heading_style(context) => TextStyle(
  fontSize: 2 * MediaQuery.of(context).size.width * 0.01,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.0,
);

TextStyle product_prize_style(context) => TextStyle(
  fontSize: 1 * MediaQuery.of(context).size.width * 0.01,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.0,
);
