import 'package:flutter/material.dart';
import 'package:musicplayer/consts/theme.dart';
import 'package:musicplayer/model/song.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/utils/over_scroll_behavior.dart';
import 'package:musicplayer/widget/my_listTile.dart';
import 'package:provider/provider.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {

  bool _expandedOtherVersion = false;
  double _bigPadding = 23;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.only(top: 11),
      child: Consumer<SongModel>(
        builder: (BuildContext context, SongModel songModel, Widget child) {
          return ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView(
              padding: EdgeInsets.only(bottom: _bigPadding),
              children: <Widget>[
                _songInfo(songModel.song),
                _relatedSong(),
                _otherVersion(),
                _relatedPlaylist(),
                _relatedVideo(),
                _relatedArticle()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _songInfo(Song song) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(song.songName,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: white70),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        SizedBox(height: 3),
        Row(
          children: <Widget>[
            Text('2012年01月27日发行', style: TextStyle(color: white50, fontSize: 12)),
            SizedBox(width: 12),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Text(
                    '歌曲详情',
                    style: TextStyle(color: white50, fontSize: 12),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: white50,
                    size: 18,
                  )
                ],
              ),
            )
          ],
        ),
        Divider(color: white30, height: 28),
        Wrap(
          spacing: 30,
          runSpacing: 14,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/images/LanaDelRey.jpg',width: 25,),
                ),
                SizedBox(width: 8),
                Text(
                  '歌手：${song.singer}',
                  style: TextStyle(color: white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(borderRadius: BorderRadius.circular(4),
                    child: Image.asset(song.albumCover,width: 25)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '专辑：${song.album}',
                    style: TextStyle(color: white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
    return _baseCard(child);
  }

  Widget _relatedSong() {
    return _baseCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               _titleText('相关歌曲'),
               GestureDetector(
                 child: Icon(
                   Icons.play_circle_filled,color: white70,size: 38,
                 ),
               ),
             ],
           ),
          _relatedSongText('Summertime Sadness (Rayan Hemsworth Remix)'),
          const SizedBox(height: 11),
          _relatedSongText('Blame - John Newman/Calvin Harris'),
          const SizedBox(height: 11),
          _relatedSongText('Sugar - Maroon 5')
        ],
      )
    );
  }

  Widget _titleText( String text) {
    return Text(text,
               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: white70));
  }

  Widget _relatedSongText(String text) {
    return Text(text,
        style: TextStyle(fontSize: 15,color: white50),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,);
  }

  Widget _otherVersion() {
    List<Widget> children = <Widget>[];
    children..add(
      GestureDetector(
        onTap: (){
          _expandedOtherVersion = !_expandedOtherVersion;
          setState(() {});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _titleText('其他版本'),
            Container(width: 5,color: Colors.transparent),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('10',style: TextStyle(color: white50,fontSize: 17)),
                  SizedBox(width: 3),
                  Icon(_expandedOtherVersion
                      ?Icons.keyboard_arrow_up
                  :Icons.keyboard_arrow_down,
                  color: white50,size: 20,),
                ],
              ),
            Expanded(child:
            Container(
              color: Colors.transparent,
            child: Text('其',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.transparent),))
            ),
          ],
        ),
      )
    )..add(_otherVersionItem());
    if(_expandedOtherVersion){
      for(int i = 0;i<8;i++ ){
        children.add(_otherVersionItem());
      }
    }
    return _baseCard(
      Column(children: children),0
    );
  }


  Widget _baseCard(Widget child,[double bottomMargin]) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      margin: EdgeInsets.only(bottom: bottomMargin ?? 17),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: child,
    );
  }
 Widget _baseNoBackColorCard(Widget child) {
    return Container(
      margin: EdgeInsets.only(top: _bigPadding),
      child: child,
    );
 }
  Widget _otherVersionItem() {
    return Container(
        margin: EdgeInsets.only(top: 13),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('assets/images/summertime_sadness.jpg',width: 50),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Summertime Sadness (Remix)',
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: white70,fontSize: 17),),
                  SizedBox(height: 5,),
                  Text('Lana Del Rey·SELFIE COMPLILATION',
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: white30),),
                ],
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              child: Icon(
                Icons.more_horiz,color: white50,
              ),
            ),
          ],
        ),
      );
  }

  Widget _relatedPlaylist() {
    return _baseNoBackColorCard(
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _titleText('相关歌单'),
              Spacer(),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.refresh,color: white50,size: 20),
                    SizedBox(width: 3),
                    Text('换一批',
                    style: TextStyle(color: white50),)
                  ],
                ),
              ),
            ],
          ),
          _relatedPlaylistItem(),
          _relatedPlaylistItem(),
          _relatedPlaylistItem(),
        ],
      )
    );
  }

  Widget _relatedPlaylistItem() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: MyListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset('assets/images/wake_up.jpg',width: 58),
        ),
        center: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('抖音最热门的50首英语歌',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white70,fontSize: 17),),
            SizedBox(height: 5,),
            Text('50首',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white30),),
          ],
        ),
        trailing: Icon(Icons.chevron_right,color: white30),
      ),
    );
  }

  Widget _relatedVideo() {
    return _baseNoBackColorCard(
       Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _titleText('相关视频'),
              Spacer(),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.refresh,color: white50,size: 20),
                    SizedBox(width: 3),
                    Text('换一批',
                      style: TextStyle(color: white50),)
                  ],
                ),
              ),
            ],
          ),
          _relatedVideoItem(),
          _relatedVideoItem(),
          _relatedVideoItem(),
        ],
      ),
    );
  }

  Widget _relatedVideoItem() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: MyListTile(
        betweenCenterAndTrailing: 0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            'assets/images/Mojito.jpg',
            width: 110,
            height: 60,
            fit: BoxFit.cover
          ),
        ),
        center: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('涅槃（Phoenix） - 英雄联盟2019全球总决赛主题曲',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white70,fontSize: 17),),
            SizedBox(height: 5,),
            Text('英雄联盟',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white30),),
          ],
        ),
      ),
    );
  }

  Widget _relatedArticle() {
    return _baseNoBackColorCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _titleText('相关文章'),
          _relatedArticleItem(),
          _relatedArticleItem(),
          _relatedArticleItem()
        ],
      )
    );
  }

  Widget _relatedArticleItem() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: MyListTile(
        betweenCenterAndTrailing: 0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset('assets/images/LanaDelRey.jpg',width: 58),
        ),
        center: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('坚持就是胜利，加油，奥利给！',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white70,fontSize: 17),),
            SizedBox(height: 5,),
            Text('xxx 阅读6.5万',
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white30),),
          ],
        ),
      ),
    );
  }

}
