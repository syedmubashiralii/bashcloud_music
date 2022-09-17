import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Views/album.dart';

import '../widget.dart';
import 'songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return openDialog(context);
        },child: Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: Text(
          'Music Player',
          style: GoogleFonts.aBeeZee(color: Colors.white, letterSpacing: 3),
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Songs(),
            Albums(),
            Container(
              child: Center(
                child: Text("Setting"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Songs'),
              textAlign: TextAlign.end,
              icon: Icon(Icons.music_note),
              activeColor: Colors.black,
              inactiveColor: Colors.grey[200]),
          BottomNavyBarItem(
              textAlign: TextAlign.end,
              title: Text('Albums'),
              activeColor: Colors.black,
              icon: Icon(Icons.album_sharp),
              inactiveColor: Colors.grey[200]),
          BottomNavyBarItem(
              textAlign: TextAlign.end,
              title: Text('Settings'),
              activeColor: Colors.black,
              icon: Icon(Icons.settings),
              inactiveColor: Colors.grey[200]),
        ],
      ),
    ));
  }
}
