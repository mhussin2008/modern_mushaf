import 'package:flutter/material.dart';
import 'splash_screen2.dart';

class Splash_Screen extends StatelessWidget {
  Splash_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    return Center(
      child: TextButton(
// splashscreenyDB (3:5)
        onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Splash_Screen2()));


          print('clicked');},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Center(

          child: Container(
            color: Colors.white,
            width: 300 * fem,
            height: 600 * fem,
            child: Image(
                image: AssetImage('assets/pictures/image_mushaf.png')),
          ),
        ),
      ),
    );
  }
}
