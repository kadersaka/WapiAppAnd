import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const api =
    'https://firebasestorage.googleapis.com/v0/b/playground-a753d.appspot.com/o';

enum AppTheme { candy, cocktail }


class DownloadText extends StatefulWidget {
  final AppTheme theme;

  DownloadText(this.theme);

  @override
  _DownloadTextState createState() => _DownloadTextState();
}

class _DownloadTextState extends State<DownloadText> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}