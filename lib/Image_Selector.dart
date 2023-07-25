import 'package:flutter/material.dart';
import 'package:modern_mushaf/selected_qary_recite.dart';
//import 'package:modern_mushaf/generated/assets.dart';

// https://api-docs.quran.com/quran.com/v4

// https://alquran.cloud/api


List<String> qary_images=['abdelbasit',
'afasy',
  'agamy',
  'akhdar',
  'ayoob',
  'gebril',
  'hosary',
  'hozaify',
  'maher',
  'refaey',
  'shahriar',
  'shatry',
  'shreem',
  'sowayed'
];
List<String> qary_arab_name=[
  'الشيخ عبدالباسط عبدالصمد',
  'الشيخ مشاري العفاسي',
  'الشيخ أحمد بن علي العجمي',
  'الشيخ إبراهيم الاخضر',
  'الشيخ محمد ايوب',
  'الشيخ محمد جبريل',
  'الشيخ محمود خليل الحصري',
  'الشيخ علي بن عبدالرحمن الحذيفي',
  'الشيخ ماهر المعيقلي',
  'الشيخ هاني الرفاعي',
  'الشيخ شهريار برهيزكار',
  'الشيخ ابو بكر الشاطري',
  'الشيخ سعود الشريم',
  'الشيخ ايمن سويد'
];

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



        qary_images.asMap().entries.map  ((entry) {
          int SelectedIdx=entry.key  ;

          print(SelectedIdx);
          return
            Column(
              //height: 400,
            children :[

              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => selected_qary_recite(SelectedIdx)));
                },

                child: Image.asset(
                'assets/images/qorra_images/${entry.value}.jpg'
          ,width: 140,
            height: 140,
          ),
              ) ,

              Text(qary_arab_name[SelectedIdx])
            ,SizedBox(height: 20,)
            ]
          //Text(qary_arab_name[qary_images.indexOf(e)])
          );




        }).toList())


        )
    ;
  }
}