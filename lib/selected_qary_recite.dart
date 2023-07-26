import 'package:flutter/material.dart';
import 'package:modern_mushaf/Image_Selector.dart';
import 'package:modern_mushaf/main.dart';
import '../qurantext/constant.dart';
// import 'package:audioplayers/audioplayers.dart';
import '../qurantext/recitation_verse.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';


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

  final _player1 = AudioPlayer();
  final _player2 = AudioPlayer();
  final List<AudioPlayer> _players=[];

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

        child: Column(
          children: [
            Container(
              width: s_width,
              height: s_height-250,
              color: Colors.greenAccent,
              child: SingleChildScrollView(
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
                                      print(e.key);

                                      //final player = AudioPlayer();

                                      // await player.play(UrlSource('https://cdn.islamic.network/quran/audio/128/ar.alafasy/1160.mp3'));
                                      //await player.play(UrlSource('https://cdn.islamic.network/quran/audio/192/ar.abdullahbasfar/1160.mp3'));
                                      //await player.play(UrlSource(qary_sites[widget.qaryIndex]));


                                      var startAya=arabic.firstWhere((element) => element['sura_no']==e.key+1)['id'];
                                      var lastAya=arabic.lastWhere((element) => element['sura_no']==e.key+1)['id'];
                                      print(startAya);
                                      print(lastAya);
                                      String urlString1='${qary_sites[widget.qaryIndex]}${startAya}.mp3';
                                      String urlString2='${qary_sites[widget.qaryIndex]}${startAya+1}.mp3';

                                      await _player1.setAudioSource(AudioSource.uri(Uri.parse(urlString1)));
                                      await _player2.setAudioSource(AudioSource.uri(Uri.parse(urlString2)));

                                      await _player1.play();
                                      await _player2.play();








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
            Container(
              width: s_width,
              height: 150,
              color: Colors.cyan,
              child:
              LinearPercentIndicator(
                width: s_width-50,
                lineHeight: 30,
                percent: 0.5,
                progressColor: Colors.orange,
                  alignment: MainAxisAlignment.center
              ),

            )
          ],
        ),
      ),
    );
  }
}
