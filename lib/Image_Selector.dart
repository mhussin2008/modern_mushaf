import 'package:flutter/material.dart';

List<String> qary_images=['abdelbasit','hosary','ismail','seddiq'];
List<String> qary_arab_name=['عبدالباسط','الحصرى','مصطفى اسماعيل','محمد صديق المنشاوى'];

class Image_Selector extends StatefulWidget {
   Image_Selector({super.key});

  @override
  State<Image_Selector> createState() => _Image_SelectorState();
}

class _Image_SelectorState extends State<Image_Selector> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(children:



        qary_images.map((e) {
          return
            Column(
            children :[Image.asset(
              'assets/pictures/qary_pics/${e}.png'
          ,width: 140,
            height: 140,
          ) ,
          Text(qary_arab_name[qary_images.indexOf(e)])
          ]);




        }).toList())


        )
    ;
  }
}
