import 'package:flutter/material.dart';
//import 'package:modern_mushaf/selected_qary_recite.dart';
import 'package:modern_mushaf/selected_qary_recite2.dart';
//import 'package:modern_mushaf/generated/assets.dart';

// https://api-docs.quran.com/quran.com/v4

// https://alquran.cloud/api


List<String> qary_images=[
  'abdelbasit',
'afasy',
  'basfar','shatry',
  'agamy','refaey','hosary','hozaify',
  'akhdar','maher',
  'ayoob',
  'gebril',
  'shreem',



  'shahriar',


  'sowayed'
];
List<String> qary_arab_name=[
  'الشيخ عبدالباسط عبدالصمد',
  'الشيخ مشاري العفاسي',
  'الشيخ عبدالله بصفر','الشيخ ابو بكر الشاطري',
  'الشيخ أحمد بن علي العجمي','الشيخ هاني الرفاعي', 'الشيخ محمود خليل الحصري',
  'الشيخ علي بن عبدالرحمن الحذيفي',
  'الشيخ إبراهيم الاخضر', 'الشيخ ماهر المعيقلي',
  'الشيخ محمد ايوب',
  'الشيخ محمد جبريل',
  'الشيخ سعود الشريم',



  'الشيخ شهريار برهيزكار',


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
    return
     SingleChildScrollView(
              child: Column(

          children:



        qary_images.asMap().entries.map  ((entry) {
          int SelectedIdx=entry.key  ;

          //print(qary_images[SelectedIdx]);
          return
            Column(
              mainAxisSize: MainAxisSize.min,
            children :[

              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => selected_qary_recite2(SelectedIdx)));
                },

                child: Image.asset(
                'assets/images/qorra_images/${entry.value}.jpg'
          ,width: 120,
            height: 120,
          ),
              ) ,

              Text(qary_arab_name[SelectedIdx])
            ,SizedBox(height: 20,)
            ]
          //Text(qary_arab_name[qary_images.indexOf(e)])
          );
       }).toList()
              )
     )

    ;
  }
}
