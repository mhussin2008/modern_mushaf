import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modern_mushaf/Image_Selector.dart';
import 'package:modern_mushaf/main.dart';
import 'package:modern_mushaf/surah_builder_recite.dart';
import '../qurantext/constant.dart';
import '../qurantext/recitation_verse.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'audio_player_manager.dart';

String urlString = '';

int startAya = 0;
int lastAya = 0;
int Counter = 0;
int suraLength = 0;

class selected_qary_recite2 extends StatefulWidget {
  final qaryIndex;
  const selected_qary_recite2(int this.qaryIndex, {super.key});

  @override
  State<selected_qary_recite2> createState() => _selected_qary_recite2State();
}

class _selected_qary_recite2State extends State<selected_qary_recite2> {
  @override
  void initState() {
    super.initState();

    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
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
        child: Center(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            //color: Colors.deepOrangeAccent,
                            width: s_width - 100,
                            child: TextButton(
                                onPressed: () async {
                                  print(e.key);

                                  startAya = arabic.firstWhere((element) =>
                                      element['sura_no'] == e.key + 1)['id'];
                                  lastAya = arabic.lastWhere((element) =>
                                      element['sura_no'] == e.key + 1)['id'];
                                  suraLength = lastAya - startAya + 1;
                                  print(startAya);
                                  print(lastAya);
                                  print(suraLength);
                                  //Counter=1;
                                  urlString =
                                      '${qary_sites[widget.qaryIndex]}${startAya}.mp3';

                                  print(qary_sites[widget.qaryIndex]);

                                  //await mainPlayer.setAudioSource(AudioSource.uri(Uri.parse(urlString)));
                                  Counter = 1;

                                  //
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SurahBuilderRecite(
                                                  arabic: arabic,
                                                  surah: e.key,
                                                  surahName: arabicName[e.key]
                                                      ['name'],
                                                  ayah: 0,
                                                  reciterIndex:
                                                      widget.qaryIndex)));

                                  // Percent.value=Counter/(suraLength);
                                  //await mainPlayer.play();
                                  // print('current index=$mainPlayer.currentIndex');
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

  void playNext() async {
    //await mainPlayer.setAudioSource(AudioSource.uri(Uri.parse(urlString)));

    //await mainPlayer.play();
  }
}

class FullExample extends StatefulWidget {
  const FullExample({
    Key? key,
    required this.audioPlayerManager,
  }) : super(key: key);

  final AudioPlayerManager audioPlayerManager;

  @override
  State<FullExample> createState() => _FullExampleState();
}

class _FullExampleState extends State<FullExample> {
  var _isShowingWidgetOutline = false;
  var _labelLocation = TimeLabelLocation.below;
  var _labelType = TimeLabelType.totalTime;
  TextStyle? _labelStyle;
  var _thumbRadius = 10.0;
  var _labelPadding = 0.0;
  var _barHeight = 5.0;
  var _barCapShape = BarCapShape.round;
  Color? _baseBarColor;
  Color? _progressBarColor;
  Color? _bufferedBarColor;
  Color? _thumbColor;
  Color? _thumbGlowColor;
  var _thumbCanPaintOutsideBar = true;

  @override
  void initState() {
    super.initState();
    widget.audioPlayerManager.init();
  }

  @override
  void dispose() {
    widget.audioPlayerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: _widgetBorder(),
          child: _progressBar(),
        ),
        const SizedBox(height: 5),
        _playButton(),
      ],
    );
  }

  BoxDecoration _widgetBorder() {
    return BoxDecoration(
      border: _isShowingWidgetOutline
          ? Border.all(color: Colors.red)
          : Border.all(color: Colors.transparent),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: widget.audioPlayerManager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: widget.audioPlayerManager.player.seek,
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: _barHeight,
          baseBarColor: _baseBarColor,
          progressBarColor: _progressBarColor,
          bufferedBarColor: _bufferedBarColor,
          thumbColor: _thumbColor,
          thumbGlowColor: _thumbGlowColor,
          barCapShape: _barCapShape,
          thumbRadius: _thumbRadius,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelTextStyle: _labelStyle,
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: widget.audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: widget.audioPlayerManager.player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: 32.0,
            onPressed: widget.audioPlayerManager.player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay),
            iconSize: 32.0,
            onPressed: () =>
                widget.audioPlayerManager.player.seek(Duration.zero),
          );
        }
      },
    );
  }
}
