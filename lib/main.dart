
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer/consts/theme.dart';
import 'package:musicplayer/pages/navigation_pages/navigation_page.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<SongModel>(create: (_) => SongModel()),
      ],
      child: MyApp()
  ));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '音乐',
      theme: myTheme,
      home: NavigationPage()
      
    );
  }
}
