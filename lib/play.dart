// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

class PlaySong extends StatefulWidget {
  late SongModel songInfo;
  final GlobalKey<PlaySongState> key;
  Function changeTrack;
  PlaySong(
      {required this.changeTrack, required this.key, required this.songInfo})
      : super(key: key);

  @override
  State<PlaySong> createState() => PlaySongState();
}

class PlaySongState extends State<PlaySong> {
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  final AudioPlayer player = AudioPlayer();

  void initState() {
    super.initState();
    setSong(widget.songInfo);
  }

  void dispose() {
    super.dispose();
    player.dispose();
  }

  void setSong(SongModel songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri!);
    currentValue = minimumValue;
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);
    });
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentValue);
      });
    });
    player.durationStream.listen((duration) {
      maximumValue = duration!.inMilliseconds.toDouble();
      setState(() {});
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(0.7.h),
          child: Column(
            children: [
              SizedBox(
                height: 7.h,
              ),
              CircleAvatar(
                radius: 16.h,
                backgroundColor: Colors.black,
                child: const Icon(Icons.music_note),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  widget.songInfo.title.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(widget.songInfo.artist == "<unknown>"
                    ? "Unknown Artist"
                    : widget.songInfo.artist!),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Text(currentTime.toString().split(".")[0]),
                  Expanded(
                    child: Slider(
                        activeColor: Colors.green,
                        thumbColor: Colors.black,
                        inactiveColor: Colors.grey[400],
                        value: currentValue,
                        max: maximumValue,
                        min: minimumValue,
                        onChanged: ((value) {
                          currentValue = value;
                          player.seek(
                              Duration(milliseconds: currentValue.round()));
                        })),
                  ),
                  Text(endTime.toString().split(".")[0]),
                ],
              ),
              SizedBox(
                height: 1.9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.changeTrack(false);
                      },
                      child: Container(
                          width: 15.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(28)),
                          child: const Icon(Icons.skip_previous))),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      changeStatus();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12)),
                      width: 30.w,
                      height: 5.h,
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => widget.changeTrack(true),
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(28)),
                      child: const Icon(
                        Icons.skip_next,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // void changeseconds(int seconds) {
  //   Duration duration = Duration(seconds: seconds);
  //   widget.player.seek(duration);
  // }
}
