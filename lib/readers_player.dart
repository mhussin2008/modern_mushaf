import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

import 'Image_Selector.dart';



class readers_player extends StatefulWidget {
  const readers_player({super.key});

  @override
  State<readers_player> createState() => _readers_playerState();
}

class _readers_playerState extends State<readers_player> {
  var txtFindController=TextEditingController();
  String searchValue = '';

  // final List<String> _suggestions = [
  // 'عبد الباسط',
  // 'الحصرى',
  // 'المنشاوى',
  // 'البنا',
  //   ];

  final List<String> _suggestions = ['Afeganistan', 'Albania', 'Algeria', 'Australia', 'Brazil', 'German', 'Madagascar', 'Mozambique', 'Portugal', 'Zambia'];
  Future<List<String>> _fetchSuggestions(String searchValue) async {
    //await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

        // appBar: AppBar(title: Text('H'),
        //
        //   ),
     // endDrawer: Drawer(child: Text('j')),

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

                  )



            ]),
            Container(
              width: 345,
             height: 160,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: Image.asset("assets/images/background1.png").image,
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(

                width: double.infinity,
                height: 500,
                child: Image_Selector())

        //     // Container(
        //     //   width: 345,
        //     //   height: 60,
        //     //   decoration: ShapeDecoration(
        //     //     shape: RoundedRectangleBorder(
        //     //       side: BorderSide(
        //     //         width: 2.50,
        //     //         //strokeAlign: BorderSide.strokeAlignCenter,
        //     //         color: Colors.blue,
        //     //       ),
        //     //       borderRadius: BorderRadius.circular(11),
        //     //     ),
        //     //   ),
        //     //   child:
        //     //   // EasySearchBar(
        //     //   //     title: const Text('Example'),
        //     //   //     onSearch: (value) {
        //     //   //       setState(() => searchValue = value);
        //     //   //
        //     //   //     },
        //     //   //     suggestions: _suggestions
        //     //   // ),
        //     //
        //     //   // EasySearchBar(
        //     //   //   onSuggestionTap: (_shearchString){
        //     //   //
        //     //   //   },
        //     //   //
        //     //   //   showClearSearchIcon: true,
        //     //   //     title: const Text('اختر اسم القارئ'),
        //     //   //     onSearch: (value) => setState(() => searchValue = value),
        //     //   //     backgroundColor: Colors.white,
        //     //   //      foregroundColor: Colors.black,
        //     //   //      // actions: [
        //     //   //     //   IconButton(icon: const Icon(Icons.person), onPressed: () {})
        //     //   //     // ],
        //     //   //     asyncSuggestions: (value) async =>
        //     //   //     await _fetchSuggestions(value)),
        //     // )
        //     //Image.asset('assets/images/background1.png')
          ],
        ),
      ),
    );
  }
}
