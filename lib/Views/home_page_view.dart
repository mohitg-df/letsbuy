import 'package:flutter/material.dart';
import 'package:letsbuy/Screen/mobile_home_screen.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return HomepageView();
        }
        // else if (constraints.maxWidth > 840 &&
        //     constraints.maxWidth < 1200) {
        //   return tab_home_page();
        // }
        else {
          return Mobilehomescreen();
        }
      },
    );
  }
}
