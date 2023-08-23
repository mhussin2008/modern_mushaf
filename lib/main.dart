import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_mushaf/qurantext/constant.dart';
import 'splash_screen.dart';



List arabic = [];
//List malayalam = [];
//List quran = [];
List recitations=[];


Future readJson() async{
  arabic=await rootBundle.loadStructuredData("assets/text/hafs_smart_v8.json", (String s) async {
    return json.decode(s)['quran'];
  });

  // final String response = await rootBundle.loadString("assets/text/hafs_smart_v8.json");
  // final data = json.decode(response);
  //arabic = data['quran'];
  return ; //quran = [arabic];
}






void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await readJson();
      await getSettings();
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'تطبيق المصحف'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Splash_Screen()
      ),
    );
  }
}
