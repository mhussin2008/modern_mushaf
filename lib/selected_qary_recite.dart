import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modern_mushaf/Image_Selector.dart';
import 'package:modern_mushaf/main.dart';
import '../qurantext/constant.dart';
import '../qurantext/recitation_verse.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';

// https://api.alquran.cloud/v1/quran/ar.abdullahbasfar
//https://api.alquran.cloud/v1/quran/{ar.name}

// https://cdn.islamic.network/quran/audio/128/ar.alafasy/1160.mp3

// https:\/\/cdn.islamic.network\/quran\/audio\/192\/ar.abdullahbasfar\/1.mp3
String urlString='';

final mainPlayer = AudioPlayer();


int startAya=0;
int lastAya=0;
int Counter=0;
int suraLength=0;


class selected_qary_recite extends StatefulWidget {
  final qaryIndex;
  selected_qary_recite(int this.qaryIndex, {super.key});

  @override
  State<selected_qary_recite> createState() => _selected_qary_reciteState();
}

class _selected_qary_reciteState extends State<selected_qary_recite> {
  ValueNotifier<double> Percent=ValueNotifier(0.0);



  @override
  void initState() {

      mainPlayer.playerStateStream.listen((state) {

        if (state.playing) {
        print('playing');
      } else print('not playing');
      switch (state.processingState) {
      case ProcessingState.idle: print('idle');
      case ProcessingState.loading: print('loading');
      case ProcessingState.buffering: print('buffering');
      case ProcessingState.ready: print('ready');
      case ProcessingState.completed: {
        print('completed');


        if(Counter==suraLength){
          //Percent.value=(Counter)/(lastAya-startAya+1);
          Counter=0;
          startAya=0;
          lastAya=0;
          suraLength=0;
          Percent.value=0.0;
          mainPlayer.stop();
        } else {
        urlString='${qary_sites[widget.qaryIndex]}${startAya+Counter}.mp3';
        Counter++;
        Percent.value=(Counter)/(suraLength);
        playNext();
      }}}
    });
    // TODO: implement initState
  }

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
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            border: Border.all(
                              color: Colors.deepOrange,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        //color: Colors.deepOrangeAccent,
                        width: s_width - 100,
                        child: TextButton(
                            onPressed: () async {
                              print(e.key);

                              startAya=arabic.firstWhere((element) => element['sura_no']==e.key+1)['id'];
                              lastAya=arabic.lastWhere((element) => element['sura_no']==e.key+1)['id'];
                              suraLength=lastAya-startAya+1;
                              print(startAya);
                              print(lastAya);
                              print(suraLength);
                              //Counter=1;
                              urlString='${qary_sites[widget.qaryIndex]}${startAya}.mp3';

                              print(qary_sites[widget.qaryIndex]);

                              await mainPlayer.setAudioSource(AudioSource.uri(Uri.parse(urlString)));
                              Counter=1;
                              Percent.value=Counter/(suraLength);
                              await mainPlayer.play();
                              print('current index=$mainPlayer.currentIndex');
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
              ValueListenableBuilder(
                valueListenable: Percent,
                builder: (BuildContext context, value, Widget? child) {

                  return  LinearPercentIndicator(
                      width: s_width-50,
                      lineHeight: 30,
                      percent: (value >1 || value<0 || value.isNaN )?0.0:value ,
                      progressColor: Colors.orange,
                      alignment: MainAxisAlignment.center
                  );

                },

              ),

            )
          ],
        ),
      ),
    );
  }
  void playNext() async {

    await mainPlayer.setAudioSource(AudioSource.uri(Uri.parse(urlString)));

    await mainPlayer.play();

  }


}