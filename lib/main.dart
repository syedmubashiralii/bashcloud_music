import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/play.dart';
import 'package:music_app/Views/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

import 'Views/Splash_Screen.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        themeMode: ThemeMode.dark,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.grey[200],
        ),
        darkTheme: ThemeData.dark(),
        home: const splashscreen(),
      );
    });
  }
}











// // =============
// // Author: Lucas Josino
// // Github: https://github.com/LucJosin
// // Website: https://www.lucasjosino.com/
// // =============
// // Plugin/Id: on_audio_query#0
// // Homepage: https://github.com/LucJosin/on_audio_query
// // Pub: https://pub.dev/packages/on_audio_query
// // License: https://github.com/LucJosin/on_audio_query/blob/main/on_audio_query/LICENSE
// // Copyright: © 2021, Lucas Josino. All rights reserved.
// // =============

// import 'package:flutter/material.dart';
// import 'package:music_app/maincontroller.dart';
// import 'package:music_app/widgets.dart';


// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//         primaryColor: Colors.grey[200],
//       ),
//       darkTheme: ThemeData.dark(),
//       home: const Main(),
//     ),
//   );
// }

// class Main extends StatefulWidget {
//   const Main({Key? key}) : super(key: key);

//   @override
//   _MainState createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   // Default border to all app.
//   final BorderRadius borderRadius = BorderRadius.circular(10);

//   // Controller.
//   final MainController _controller = MainController();

//   // Links
//   Map<String, Uri> links = {
//     'github': Uri.parse('https://github.com/LucJosin/on_audio_query'),
//     'pub': Uri.parse('https://pub.dev/packages/on_audio_query'),
//     'docs': Uri.parse('https://pub.dev/documentation/on_audio_query/latest/'),
//     'issue': Uri.parse('https://github.com/LucJosin/on_audio_query/issues'),
//     'pr': Uri.parse('https://github.com/LucJosin/on_audio_query/pulls'),
//   };

//   @override
//   void initState() {
//     super.initState();
//     _controller.checkPermisison();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Basic configurations
//         elevation: 1.5,
//         shadowColor: Colors.black.withOpacity(0.5),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         // Title
//         title: Text(
//           "OnAudioQuery",
//           style: TextStyle(
//             fontSize: 20,
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         // Buttons
//         actions: [
//           IconButton(
//             onPressed: () => showSettingsDialog(context),
//             icon: const Icon(Icons.more_vert),
//           )messageWidge
//         ],
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Wrap(
//             runSpacing: 15,
//             alignment: WrapAlignment.center,
//             children: [
//               messageWidget(context),
//               titleWidget(context, 'Queries'),
//               queriesWidget(context),
//               titleWidget(context, 'Help'),
//               linksWidget(context),
//                titleWidget(context, 'Queries'),
//               queriesWidget(context),
//               titleWidget(context, 'Help'),
//               linksWidget(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget titleWidget(BuildContext context, String title) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: EdgeInsets.only(
//           left: MediaQuery.of(context).size.width * 0.06,
//         ),
//         child: Text(title),
//       ),
//     );
//   }

//   Widget messageWidget(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 15),
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//       width: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: borderRadius,
//       ),
//       child: Column(
//         children: [
//           const Text(
//             'This plugin require: \nLibrary (IOS) and READ (Android) permissions.',
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: _controller.hasError
//                 ? null
//                 : _controller.requestPermission(context),
//             style: ElevatedButton.styleFrom(
//               elevation: 0,
//               primary: Theme.of(context).scaffoldBackgroundColor,
//             ),
//             child: const Text('Grant permission'),
//           )
//         ],
//       ),
//     );
//   }

//   Widget queriesWidget(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: Wrap(
//         runSpacing: 5,
//         children: [
//           tileWidget(
//             context,
//             'Static Query',
//             // onTap: () => Navigator.of(context).push(
//             //   MaterialPageRoute(
//             //     builder: (_) => const QueryAudios(),
//             //   ),
//             // ),
//           ),
//           tileWidget(
//             context,
//             'Dynamic Query',
//             // onTap: () => Navigator.of(context).push(
//             //   MaterialPageRoute(
//             //     builder: (_) => const ObserveAudios(),
//             //   ),
//            // ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget linksWidget(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.9,
//       child: Wrap(
//         runSpacing: 5,
//         children: [
//           tileWidget(
//             context,
//             'Github',
//             onTap: () => _controller.launchLink(links['github']!, context),
//             icon: Icons.open_in_new_outlined,
//           ),
//           tileWidget(
//             context,
//             'Pub.dev',
//             onTap: () => _controller.launchLink(links['pub']!, context),
//             icon: Icons.open_in_new_outlined,
//           ),
//           tileWidget(
//             context,
//             'Docs',
//             onTap: () => _controller.launchLink(links['docs']!, context),
//             icon: Icons.open_in_new_outlined,
//           ),
//           tileWidget(
//             context,
//             'Any problem?',
//             onTap: () => _controller.launchLink(links['issue']!, context),
//             icon: Icons.open_in_new_outlined,
//           ),
//           tileWidget(
//             context,
//             'Any suggestion?',
//             onTap: () => _controller.launchLink(links['pr']!, context),
//             icon: Icons.open_in_new_outlined,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget tileWidget(
//     BuildContext context,
//     String title, {
//     void Function()? onTap,
//     IconData icon = Icons.navigate_next_rounded,
//   }) {
//     return ListTile(
//       shape: RoundedRectangleBorder(
//         borderRadius: borderRadius,
//       ),
//       tileColor: Theme.of(context).primaryColor,
//       title: Text(title),
//       trailing: Icon(icon),
//       onTap: onTap,
//     );
//   }
// }