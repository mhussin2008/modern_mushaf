import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modern_mushaf/qurantext/recitation_verse.dart';
//import 'package:modern_mushaf/selected_qary_recite.dart';
import 'Image_Selector.dart';
import 'audio_player_manager.dart';
import 'qurantext/constant.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();
final mkey=GlobalKey();


class SurahBuilderRecite extends StatefulWidget {
  final surah;
  final arabic;
  final surahName;
  final ayah;
  final reciterIndex;
  late AudioPlayerManager manager;


  SurahBuilderRecite({
    Key? mkey,
    this.surah,
    this.arabic,
    this.surahName,
    this.ayah,
    this.reciterIndex,
  }) : super(key: mkey);

  @override
  State<SurahBuilderRecite> createState() => _SurahBuilderReciteState();
}

class _SurahBuilderReciteState extends State<SurahBuilderRecite> {
  bool view = true;






  @override
  void dispose() {
    widget.manager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
    widget.manager = AudioPlayerManager();
    widget.manager.init();

  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
        index: widget.ayah,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
      );
    }
    fabIsClicked = false;
  }

  saveBookMark(surah, ayah) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("surah", surah);
    await prefs.setInt("ayah", ayah);
  }

//
  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: arabicFontSize,
                  fontFamily: arabicFont,
                  color: const Color.fromARGB(196, 0, 0, 0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SafeArea singleSuraBuilder(LenghtOfSurah) {
    String fullSura = "";
    int previousVerses = 0;
    if (widget.surah + 1 != 1) {
      for (int i = widget.surah - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }
    if (!view) {
      for (int i = 0; i < LenghtOfSurah; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }
    }

    return SafeArea(
      child: Container(
          color: Color.fromARGB(255, 253, 251, 240),
          child: view
              ? ScrollablePositionedList.builder(
                  itemCount: LenghtOfSurah,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        (index != 0) ||
                                (widget.surah == 0) ||
                                (widget.surah == 8)
                            ? const Text("")
                            : const ReturnBasmalah(),
                        Container(
                          color: index % 2 != 0
                              ? const Color.fromARGB(255, 253, 251, 240)
                              : const Color.fromARGB(255, 253, 247, 230),
                          child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  saveBookMark(widget.surah + 1, index);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.bookmark_add,
                                      color: Color.fromARGB(255, 56, 115, 59),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "حفظ الأية",
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Color.fromARGB(255, 56, 115, 59),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "مشاركه",
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  // listen to ayah
                                  var selectedAya= index   ;
                                  var correctIndex=getCorrectIndex(widget.surah,index);
                                  var urlString='${qary_sites[widget.reciterIndex]}${correctIndex}.mp3';

                                    await widget.manager.player.setAudioSource(AudioSource.uri(Uri.parse(urlString)));

                                    await widget.manager.player.play();


                                  //widget.manager.player.audioSource=
                                  //mkey.currentWidget.manager.
                                  //print(mkey);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Color.fromARGB(255, 56, 115, 59),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "استماع للآية",
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                )
              : ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.surah + 1 != 1 && widget.surah + 1 != 9
                                  ? const ReturnBasmalah()
                                  : const Text(''),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  fullSura,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: musahfFontSize,
                                    fontFamily: arabicFont,
                                    color: Color.fromARGB(196, 44, 44, 55),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSurah = noOfVerses[widget.surah];
    double s_width = MediaQuery.of(context).size.width;
    double s_height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Image.asset(
              'assets/images/qorra_images/${qary_images[widget.reciterIndex]}.jpg',
              width: 40,
              height: 40,
            )
          ],
          leading: Tooltip(
            message: 'Mushaf Mode',
            child: TextButton(
              child: const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  view = !view;
                });
              },
            ),
          ),
          centerTitle: true,
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }
                , icon: Icon(Icons.arrow_back),),
              Text(
                widget.surahName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'quran',
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: Column(
          children: [
            Expanded(flex:4,
                child: singleSuraBuilder(LengthOfSurah)),
            Expanded(
              flex:1,
              child: Container(
                  width: s_width,
                  height: 150,
                  color: Colors.cyan,
                  child:
                  FullExample(audioPlayerManager: widget.manager)

              ),
            )

          ],
        ),
      ),
    );
  }

  getCorrectIndex(int surah, int index) {
    int acc=0;
    if (surah==0){return index+1;}
    for(int i=0;i<surah;i++){
      acc+=sura_ayas[i];
    }
    acc+=index+1;
    return acc;
  }
}

class ReturnBasmalah extends StatelessWidget {
  const ReturnBasmalah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Text(
            'بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ ',
            style: TextStyle(
              fontFamily: "me_quran",
              fontSize: 30,
            ),
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
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
