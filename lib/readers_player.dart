import 'package:flutter/material.dart';

import 'Image_Selector.dart';


class readers_player extends StatefulWidget {
  const readers_player({super.key});
  @override
  State<readers_player> createState() => _readers_playerState();
}

class _readers_playerState extends State<readers_player> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[

                  IconButton(onPressed: () async {
                    Navigator.of(context).pop()   ;
                  },
                      icon: Icon(Icons.arrow_back)
                  ),
                  const Image(
                      width: 24,
                      height: 24,
                      image: AssetImage('assets/pictures/img1.png')),
                  const Image(
                      width: 57.40,
                      height: 68,
                      image: AssetImage('assets/pictures/image_mushaf.png'))
                  , IconButton(onPressed: (){},
                      icon: Image.asset(
                          width:30,height:30,
                          'assets/pictures/img2.png')
                  ),


            ]),
           Container(
                width: double.infinity,
                height: 600,
                child: Image_Selector())
          ],
        ),
      ),
    );
  }
}
