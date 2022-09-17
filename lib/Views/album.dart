import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/Constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

import 'AlbumSongs.dart';

class Albums extends StatefulWidget {
  const Albums({Key? key}) : super(key: key);

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  OnAudioQuery audioQuery = OnAudioQuery();
  bool hasdata = false;
  List<AlbumModel> temp = [];
  @override
  void initState() {
    add();
    super.initState();
  }

  add() async {
    temp = await audioQuery.queryAlbums();
    filter();
  }

  filter() {
    if (temp.isNotEmpty) {
      Constants.albums = [];
      for (int j = 0; j < temp.length; j++) {
        if (temp[j].numOfSongs != 0) {
          Constants.albums.add(temp[j]);
        }
      }
      setState(() {
        hasdata = true;
      });
      log(Constants.albums.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: hasdata ? Constants.albums.length : 1,
          itemBuilder: (context, index) {
            return hasdata
                ? InkWell(
                    onTap: () async {
                      Constants.songsinalbums = await audioQuery.querySongs(
                          sortType: null,
                          orderType: OrderType.DESC_OR_GREATER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true,
                          path: Constants.albums[index].album.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlbumSongs()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      width: double.infinity,
                      height: 12.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 4.h,
                            backgroundColor: Colors.grey[600],
                            child: Icon(
                              Icons.music_note,
                              size: 5.h,
                            ),
                          ),
                          title: Text(
                            overflow: TextOverflow.ellipsis,
                            Constants.albums[index].album,
                            style: GoogleFonts.philosopher(
                                fontSize: 12.sp, color: Colors.grey[200]),
                          ),
                          trailing: Text(
                            overflow: TextOverflow.ellipsis,
                            Constants.albums[index].numOfSongs.toString(),
                            style: GoogleFonts.philosopher(
                                fontSize: 12.sp, color: Colors.grey[200]),
                          ),
                        ),
                      ),
                    ))
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
                          "No Album Found",
                          style: GoogleFonts.poiretOne(
                              letterSpacing: 2.0, color: Colors.grey[200]),
                        )
                      ]);
          }),
    ));
  }
}
