import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> openDialog(BuildContext context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.grey[600],
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.exit_to_app_rounded,
                      size: 30,
                      color: Colors.grey[200],
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  Text(
                    'Exit app',
                    style: GoogleFonts.poly(
                        color: Colors.grey[200],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Are you sure to exit app?',
                    style:
                        GoogleFonts.poly(color: Colors.grey[200], fontSize: 14),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.grey[200],
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    'Cancel',
                    style: GoogleFonts.poly(
                        color: Colors.grey[200], fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.grey[200],
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    'Yes',
                    style: GoogleFonts.poly(
                        color: Colors.grey[200], fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        );
      })) {
    case 0:
      break;
    case 1:
      exit(0);
  }
  return false;
}
