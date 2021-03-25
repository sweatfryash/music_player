
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/pages/navigation_pages/community_page.dart';
import 'package:musicplayer/pages/navigation_pages/home_page.dart';
import 'package:musicplayer/pages/navigation_pages/video_page.dart';
import 'package:musicplayer/state/global.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/widget/player_bar.dart';
import 'package:provider/provider.dart';

import 'mine_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> _pageList = List(); //列表存放页面
  int _selectedIndex = 0; //bar下标
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageList
      ..add(HomePage())
      ..add(VideoPage())
      ..add(CommunityPage())
      ..add(MinePage());
    Global.audioPlayer.setAsset(Global.songs[Global.currentIndex].songUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _intentToDesktop ,
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: PageView(
                  controller: _pageController,
                  children: _pageList,
                  physics: NeverScrollableScrollPhysics(),
                ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              elevation: 0,
              currentIndex: _selectedIndex,
              onTap: _onTap,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Color(0xffbbbbbb),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              iconSize: 26,
              selectedItemColor: Theme.of(context).accentColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.music_note),
                  title: Text('首页'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.music_video),
                  title: Text('视频'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timeline),
                  title: Text('扑通'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('我的'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 56,
            left: 0,
            right: 0,
            child: Consumer<SongModel>(
                  builder: (BuildContext context, SongModel songModel, Widget child) {
                    return Hero(
                        tag: 'playerbar',
                        child: PlayerBar());
                }),
          )
        ],
      ),
    );
  }

  Future<bool> _intentToDesktop() async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  Future _onTap(int index) async {
    _pageController.jumpToPage(index);
    _selectedIndex = index;
    setState(() { });
  }

}
