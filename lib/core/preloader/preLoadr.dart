
import 'package:flutter/material.dart';


class Preloader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Spacer(),

      CircularProgressIndicator(),
      Spacer(),

    ],);

    // Center(
    //   child: Container(
    //     width: 90.0,
    //     alignment: Alignment.center,
    //     child: Image(
    //       image: AssetImage('assets/images/logo_animation.gif'),
    //     ),
    //   ));
  }
}