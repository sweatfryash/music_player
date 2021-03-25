import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/pages/player/lyric_page.dart';
import 'package:musicplayer/pages/player/music_page.dart';
import 'package:musicplayer/state/player_home_tabbar_index_model.dart';
import 'package:musicplayer/pages/player/recommend_page.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/utils/pick_img_main_color.dart';
import 'package:provider/provider.dart';

class PlayerHome extends StatefulWidget {
  
  final String albumCover;

  const PlayerHome({Key key, this.albumCover}) : super(key: key);
  
  @override
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {

  PageController _pageController ;
  final List<Widget> _pageList = <Widget>[RecommendPage(), MusicPage(), LyricPage()];
  final List<String> _titleList = <String>['推荐', '歌曲', '歌词'];
  Color _backColor = Colors.black.withOpacity(0.1);
  List<Widget> children =<Widget>[];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _getBackColor(widget.albumCover);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build______________');
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Consumer<SongModel>(
            builder: (BuildContext context, SongModel value, Widget child) {
              return Center(
                child: Transform.scale(
                  scale: 2.2,
                  child: Image.asset(value.song.albumCover),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
            child: Consumer<SongModel>(
              builder: (BuildContext context, SongModel value, Widget child) {
              return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: _backColor.withOpacity(0.7));
            },
            )
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.2),
            body: MultiProvider(
              providers: [
                ChangeNotifierProvider<IndexModel>(create: (_) => IndexModel()),
              ],
              child:
              /*ListView.builder(
                itemCount: _mainColor.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 30,
                    color:  _mainColor[index],
                    child: Text(index.toString()),
                  );
                },
              ),*/
              Column(
                children: <Widget>[
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BackButton(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      _title(),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white.withOpacity(0.5)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: Consumer<IndexModel>(
                      builder: (BuildContext context, IndexModel model, Widget child) => PageView(
                        children: _pageList,
                        controller: _pageController,
                        onPageChanged: (int index) {
                          if (model.onChangedLock) {
                            model.setIndex(index);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    List<Widget> textList = <Widget>[];
    for (int i = 0; i < _titleList.length; i++) {
      textList.add(Consumer<IndexModel>(
        builder: (BuildContext context, IndexModel model, Widget child) => GestureDetector(
          onTap: () {
            model.lock();
            model.setIndex(i);
            _pageController
                .animateToPage(i, duration: const Duration(milliseconds: 200), curve: Curves.ease);
            Future.delayed(const Duration(milliseconds: 200),(){model.unLock();});
          },
          child: Text(
            _titleList[i],
            style: TextStyle(color: i == model.index ? Colors.white70 : Colors.white30, fontSize: 13),
          ),
        ),
      ));
    }
    Container line = Container(
      width: 1,
      height: 5,
      color: Colors.white30,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[textList[0], line, textList[1], line, textList[2]]);
  }

   Future<void> _getBackColor(String albumCover) async {
    _backColor = await PickImgMainColor.pick(AssetImage(albumCover));
    if(mounted){
      setState(() {});
    }
   }

}


