import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Mediaplayer extends StatefulWidget {
  const Mediaplayer({Key? key}) : super(key: key);

  @override
  State<Mediaplayer> createState() => _MediaplayerState();
}

class _MediaplayerState extends State<Mediaplayer> {
  bool isPlaying = false;
  bool liked = false;
  String currentTime = '', endTime = '';
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  LikeMusic() {
    if (liked) {
      setState(() {
        liked = false;
      });
    } else {
      setState(() {
        liked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              color: Colors.grey[200],
            ),
          ),
        ),
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              LikeMusic();
            },
            child: Icon(
              liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: liked ? Colors.red : Colors.grey[200],
              size: 4.h,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.7.h),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 7.h,
              ),
              CircleAvatar(
                radius: 16.h,
                backgroundColor: Colors.black,
                child: AvatarGlow(
                  endRadius: 16.h,
                  duration: Duration(seconds: 2),
                  repeatPauseDuration: Duration(milliseconds: 200),
                  glowColor: Colors.white,
                  child: Icon(
                    Icons.music_note,
                    size: 8.h,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                textAlign: TextAlign.center,
                "widget.songInfo.title.toString()",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(color: Colors.grey[200]),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                  child: Text(
                "Unknown Artist",
                style: GoogleFonts.poppins(color: Colors.grey[200]),
              )
                  //  Text(widget.songInfo.artist == "<unknown>"
                  //     ? "Unknown Artist"
                  //     : widget.songInfo.artist!),
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
                        // max: maximumValue,
                        // min: minimumValue,
                        onChanged: ((value) {
                          // currentValue = value;
                          // player.seek(
                          //     Duration(milliseconds: currentValue.round()));
                        })),
                  ),
                  Text(endTime.toString().split(".")[0]),
                ],
              ),
              SizedBox(
                height: 1.9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // widget.changeTrack(false);
                      },
                      child: Container(
                          width: 6.h,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(28)),
                          child: Icon(
                            Icons.skip_previous_rounded,
                            size: 4.h,
                          ))),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      // changeStatus();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(100)),
                      width: 8.h,
                      height: 8.h,
                      child: Icon(
                        size: 5.h,
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    // onTap: () => widget.changeTrack(true),
                    child: Container(
                      width: 6.h,
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        size: 4.h,
                        Icons.skip_next_rounded,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 10.h,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Center(
            child: Text(
              "BashCloud",
              style: GoogleFonts.poly(
                  color: Colors.grey[200],
                  fontSize: 16.sp,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
