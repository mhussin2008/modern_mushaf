import 'package:flutter/material.dart';
import 'package:modern_mushaf/Image_Selector.dart';
import 'package:modern_mushaf/main.dart';
import '../qurantext/constant.dart';
// import 'package:audioplayers/audioplayers.dart';
import '../qurantext/recitation_verse.dart';
import 'package:just_audio/just_audio.dart';


// https://api.alquran.cloud/v1/quran/ar.abdullahbasfar
//https://api.alquran.cloud/v1/quran/{ar.name}

// https://cdn.islamic.network/quran/audio/128/ar.alafasy/1160.mp3

// https:\/\/cdn.islamic.network\/quran\/audio\/192\/ar.abdullahbasfar\/1.mp3


class selected_qary_recite extends StatefulWidget {
  final qaryIndex;
  selected_qary_recite(int this.qaryIndex, {super.key});

  @override
  State<selected_qary_recite> createState() => _selected_qary_reciteState();
}

class _selected_qary_reciteState extends State<selected_qary_recite> {

  final _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    print(widget.qaryIndex);
    double s_width = MediaQuery.of(context).size.width;
    double s_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(qary_arab_name[widget.qaryIndex]),
          SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/qorra_images/${qary_images[widget.qaryIndex]}.jpg',
            width: 40,
            height: 40,
          )
        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: s_width,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: arabicName
                    .asMap()
                    .entries
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: s_width - 100,
                            child: TextButton(
                                onPressed: () async {
                                  //final player = AudioPlayer();

                                  // await player.play(UrlSource('https://cdn.islamic.network/quran/audio/128/ar.alafasy/1160.mp3'));
                                  //await player.play(UrlSource('https://cdn.islamic.network/quran/audio/192/ar.abdullahbasfar/1160.mp3'));
                                  //await player.play(UrlSource(qary_sites[widget.qaryIndex]));
                                  await _player.setAudioSource(AudioSource.uri(Uri.parse(
                                      qary_sites[widget.qaryIndex]
                                  )));
                                  _player.play();

                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.red)))),
                                child: Text(
                                  e.value['name'],
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontFamily: 'quran', fontSize: 30),
                                )),
                          ),
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
