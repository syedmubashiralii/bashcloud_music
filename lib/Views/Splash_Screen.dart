// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_cast
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import 'Home_Page.dart';
import 'album.dart';

// ignore: camel_case_types
class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}
 
// ignore: camel_case_types
class _splashscreenState extends State<splashscreen> {
   final OnAudioQuery _audioQuery = OnAudioQuery();
   requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
          requestPermission();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Lottie.asset("assets/images/98431-loading-animation.json",
              animate: true, repeat: true),
          Text(
            "BashCloud",
            style: GoogleFonts.passionOne(
                letterSpacing: 3.0,
                color: Colors.grey[300],
                fontSize: 22.sp,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    ));
  }
}
