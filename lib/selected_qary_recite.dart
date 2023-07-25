import 'package:flutter/material.dart';
import 'package:modern_mushaf/Image_Selector.dart';
import 'package:modern_mushaf/main.dart';
import '../qurantext/constant.dart';


class selected_qary_recite extends StatefulWidget {
   final qaryIndex;
   selected_qary_recite(int  this.qaryIndex, {super.key});

  @override
  State<selected_qary_recite> createState() => _selected_qary_reciteState();
}

class _selected_qary_reciteState extends State<selected_qary_recite> {
  @override
  Widget build(BuildContext context) {
    print(widget.qaryIndex);
    double s_width = MediaQuery.of(context).size.width;
    double s_height = MediaQuery.of(context).size.height;


      return  Scaffold(
        appBar: AppBar(title: Row(children: [Text(qary_arab_name[widget.qaryIndex])
        ,Image.asset(
            'assets/images/qorra_images/${qary_images[widget.qaryIndex]}.jpg'
            ,width: 40,
            height: 40,
          )
        ]
        ),


        ),
        body: SafeArea(

          child: SingleChildScrollView(
            child: SizedBox(
              width: s_width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:



                   arabicName.asMap().entries.map((e) =>


                      SizedBox(
                        width: s_width-100,
                        child: TextButton(child: Text(e.value['name'],textDirection: TextDirection.rtl
                          ,style: TextStyle(fontFamily: 'quran',fontSize: 30),

                        ),

                          onPressed: () {  },

                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red)
                                    )
                                )
                            )


                        ),
                      )


                  ).toList()


              ),
            ),
          ),
        ),

    );
  }
}
