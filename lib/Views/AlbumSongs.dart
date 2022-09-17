import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/Constants.dart';
import 'package:music_app/play.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

import 'Mediaplayer.dart';

class AlbumSongs extends StatefulWidget {
  const AlbumSongs({Key? key}) : super(key: key);
  @override
  AlbumSongsState createState() => AlbumSongsState();
}

class AlbumSongsState extends State<AlbumSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  Duration position = const Duration();
  Duration duration = const Duration();
  bool isplaying = false;
  bool isslider = true;
  bool hasdata = true;
  var text = '';

  @override
  void initState() {
    playsong(
        Constants.songsinalbums[0].uri.toString(),
        Constants.songsinalbums[0].id.toString(),
        Constants.songsinalbums[0].title);
    super.initState();
  }

  void playsong(String url, String id, String title) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url),
          tag: MediaItem(id: id, title: title)));
      text = title;
      // _audioPlayer.seek(duration, index: currentIndex+1);
      _audioPlayer.setLoopMode(LoopMode.all);
      // _audioPlayer.play();
    } on Exception {
      print("C'ant play audio");
    }
    _audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    _audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != Constants.songsinalbums.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    playsong(
      Constants.songsinalbums[currentIndex].uri.toString(),
      Constants.songsinalbums[currentIndex].id.toString(),
      Constants.songsinalbums[currentIndex].title.toString(),
    );
  }

  changeStatus() {
    if (isplaying == true) {
      _audioPlayer.pause();
      setState(() {
        isplaying = false;
      });
    } else {
      _audioPlayer.play();
      setState(() {
        isplaying = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView.builder(
            itemCount: Constants.songsinalbums.isEmpty
                ? 1
                : Constants.songsinalbums.length,
            itemBuilder: (context, index) {
              return hasdata
                  ? AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: InkWell(
                                  onTap: () {
                                    playsong(
                                        Constants.songsinalbums[index].uri
                                            .toString(),
                                        Constants.songsinalbums[index].id
                                            .toString(),
                                        Constants.songsinalbums[index].title
                                            .toString());
                                    _audioPlayer.play();
                                    setState(() {
                                      isplaying = true;
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      width: double.infinity,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          CircleAvatar(
                                            radius: 4.h,
                                            backgroundColor: Colors.grey[600],
                                            child: Icon(
                                              Icons.music_note,
                                              size: 5.h,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Flexible(
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              Constants
                                                  .songsinalbums[index].title,
                                              style: GoogleFonts.philosopher(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey[200]),
                                            ),
                                          ),
                                        ],
                                      ))))))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Lottie.asset(
                            'assets/images/67375-no-data.json',
                            repeat: true,
                            animate: true,
                            alignment: Alignment.center,
                          ),
                          Text(
                            "No Songs",
                            style: GoogleFonts.poiretOne(
                                letterSpacing: 2.0, color: Colors.grey[200]),
                          )
                        ]);
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 25.h,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: hasdata
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: Text(
                              text,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.grey[500],
                              radius: 2.h,
                              child: Icon(Icons.arrow_upward))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            position.toString().split(".")[0],
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                          Expanded(
                              child: isslider
                                  ? Slider(
                                      activeColor: Colors.white24,
                                      thumbColor: Colors.grey[700],
                                      inactiveColor: Colors.grey[200],
                                      value: position.inSeconds.toDouble(),
                                      max: duration.inSeconds.toDouble(),
                                      min: const Duration(milliseconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      onChanged: ((value) {
                                        setState(() {
                                          changetoseconds(value.toInt());
                                          value = value;
                                        });
                                      }))
                                  : Container(
                                      height: 6.h,
                                    )),
                          Text(
                            duration.toString().split(".")[0],
                            style: TextStyle(color: Colors.grey[200]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                changeTrack(false);
                              },
                              child: Container(
                                  width: 15.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(12)),
                                  child:
                                      const Icon(Icons.skip_previous_rounded))),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              changeStatus();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12)),
                              width: 30.w,
                              height: 5.h,
                              child: Icon(
                                isplaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 4.5.h,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => changeTrack(true),
                            child: Container(
                              width: 15.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(
                                Icons.skip_next_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Container(
                  child: Lottie.asset("assets/images/106549-music.json",
                      repeat: true, animate: true),
                )),
    );
  }

  void changetoseconds(int seconds) {
    Duration d = Duration(seconds: seconds);
    _audioPlayer.seek(d);
  }
}
