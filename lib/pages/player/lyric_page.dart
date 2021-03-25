
import 'package:flutter/material.dart';
import 'package:musicplayer/consts/theme.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/widget/scroll_text.dart';
import 'package:provider/provider.dart';

class LyricPage extends StatefulWidget {
  @override
  _LyricPageState createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Consumer<SongModel>(
        builder: (BuildContext context, SongModel songModel, Widget child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 11),
              //歌名
              Container(
                height: 30,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return OverflowScrollText(
                      text: songModel.song.songName ,
                      textStyle: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: white50),
                      maxWidth: constraints.maxWidth,
                    );
                  },
                ),
              ),
              SizedBox(height: 11),
              //歌手
              Text(songModel.song.singer,
                  style: TextStyle(color: white50,fontSize: 14)),
              SizedBox(height: 11),
              _lyric(),
              SizedBox(height: 60),
              _bottomIcons(),
            ],
          );
        },
      ),
    );
  }

  Widget _lyric() {
    return Container(
      height: 470,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
    );
  }

  Widget _bottomIcons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildIconButton(() { },
        Icon(Icons.chat_bubble_outline,size: 24,color: white50,),
        ),
        Spacer(),
        _buildIconButton(() { },
          Icon(Icons.translate,size: 24,color: white50,),
        ),
        Spacer(),
        _buildIconButton(() { },
          Icon(Icons.format_align_left,size: 24,color: white50,),
        ),
        Spacer(flex: 2,),
        _buildIconButton(
                () {},
        Icon(Icons.pause_circle_filled,
          color: white70,
        size: 40,))

      ],
    );
  }

  Widget _buildIconButton(VoidCallback onTap, Widget icon) {
    return GestureDetector(onTap: onTap, child: icon);
  }
}
