import 'package:flutter/material.dart';
import 'constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Arabic Font Size",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Slider(
                    value: arabicFontSize,
                    min: 20,
                    max: 40,
                    onChanged: (value) {
                      setState(() {
                        arabicFontSize = value;
                      });
                    },
                  ),
                  Text(
                    "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                      fontFamily: "quran",
                      fontSize: arabicFontSize,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Divider(),
                  ),
                  const Text(
                    "Mushaf Mode Font Size",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: musahfFontSize,
                    max: 50,
                    min: 20,
                    onChanged: (value) {
                      setState(() {
                        musahfFontSize = value;
                      });
                    },
                  ),
                  Text("‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
                    style: TextStyle(
                    fontFamily: "quran",
                    fontSize: musahfFontSize,
                  ),
                  textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: (){
                        setState(() {
                          arabicFontSize = 28.0;
                          musahfFontSize = 40.0;
                        });
                        saveSettings();
                      },
                          child: const Text("Reset",),),
                      ElevatedButton(
                        onPressed: (){
                        setState(() {
                          saveSettings();
                          Navigator.of(context).pop();
                        });
                      },
                        child: const Text("Save",),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
