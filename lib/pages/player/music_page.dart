import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/consts/theme.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/widget/scroll_text.dart';
import 'package:musicplayer/widget/white_icon.dart';
import 'package:provider/provider.dart';
import '../../model/song.dart';

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 29),
      child: Consumer<SongModel>(builder: (BuildContext context, SongModel songModel, _) {
        return Column(
          children: <Widget>[
            SizedBox(height: 11),
            _albumCover(songModel.song.albumCover),
            SizedBox(height: 30),
            _info(songModel),
            SizedBox(height: 17),
            _lyric(),
            SizedBox(height: 60),
            _icons(songModel),
            SizedBox(height: 32),
            _progressBar(),
            SizedBox(height: 10),
            _bottomButtons(),
          ],
        );
      }),
    );
  }

  //专辑封面
  Widget _albumCover(String albumCoverUrl) {
    return ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(albumCoverUrl));
  }

  //歌曲名，歌手那一块
  Widget _info(SongModel songModel) {
    Song song = songModel.song;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 260,
              height: 30,
              child: OverflowScrollText(
                text: songModel.song.songName,
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: white90),
                maxWidth: 260,
              )
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Text(song.singer, style: TextStyle(color: white50, fontSize: 14)),
                Container(
                  decoration:
                      BoxDecoration(color: white70, borderRadius: BorderRadius.all(Radius.circular(3))),
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  margin: EdgeInsets.only(left: 15),
                  child: Text('视频 2', style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 9)),
                ),
              ],
            )
          ],
        ),
        _heartIcon(songModel)
      ],
    );
  }

  //ToDo(hch) : ❤按钮，没点过赞时应该是灰色加点赞个数，点过就是红心
  Widget _heartIcon(SongModel songModel) {
    return GestureDetector(
      onTap: () {
        songModel.setIsLiked(!songModel.song.isLiked);
      },
      child: Icon(
        Icons.favorite,
        color: songModel.song.isLiked ? Colors.red : white50,
      ),
    );
  }

  //ToDo(hch) : 单行歌词组件
  Widget _lyric() {
    return Row(
      children: <Widget>[
        Text(
          "That, baby, you're the best",
          style: TextStyle(color: white50, fontSize: 14),
        ),
      ],
    );
  }

  //进度条上方的一行按钮
  Widget _icons(SongModel songModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildIconButton(
          () {},
          WhiteIcon(Icons.mic),
        ),
        _buildIconButton(
          () {},
          WhiteIcon(Icons.surround_sound),
        ),
        _buildIconButton(
          () {},
          WhiteIcon(Icons.file_download),
        ),
        _buildIconButton(
          () {},
          WhiteIcon(Icons.chat_bubble_outline),
        ),
        _buildIconButton(
          () {},
          WhiteIcon(Icons.more_horiz),
        ),
      ],
    );
  }

  Widget _buildIconButton(VoidCallback onTap, Widget icon) {
    return GestureDetector(onTap: onTap, child: icon);
  }
  //ToDo (hch) : 显示播放进度，缓存进度不知道插件提不提供
  Widget _progressBar() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: white30,
                    borderRadius: BorderRadius.circular(3)
                  ),
                  child: Row(
                        children: <Widget>[
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(3)
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 30 - 8.0,
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle
                  ),
                ),
              ],
            ),
            Positioned(
              left: 60,
                top: 1,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white
                  ),
                ))
          ],
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('00:22',style: TextStyle(color: white30,fontSize: 12),),
            Text('04:25',style: TextStyle(color: white30  ,fontSize: 12),),
          ],
        ),
      ],
    );
  }

  Widget _bottomButtons() {
    return Consumer<SongModel>(
      builder: (BuildContext context, SongModel songModel, Widget child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _playModeIcon(),
            _buildIconButton(() { },
              Icon(Icons.skip_previous,
                color: white90,size: 36,),
            ),
            _buildIconButton(() {
              songModel.switchPlayer();
            },
              Icon(songModel.playState == AudioPlaybackState.playing
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled,size: 68,color: white90),
            ),
            _buildIconButton(() { },
              Icon(Icons.skip_next,
                color: white90,size: 36,),
            ),
            _buildIconButton(() { },
              WhiteIcon(Icons.queue_music),
            ),
          ],
        );
      },
    );
  }

  Widget _playModeIcon() {
    return _buildIconButton(() { },
        WhiteIcon(Icons.repeat_one)
    );
  }


}
