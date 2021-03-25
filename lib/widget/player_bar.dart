import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/pages/player/player_home.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/utils/my_marquee.dart';
import 'package:provider/provider.dart';

class PlayerBar extends StatefulWidget {

  @override
  _PlayerBarState createState() {
    return _PlayerBarState();
  }

}

class _PlayerBarState extends State<PlayerBar> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 60,
        child: Consumer<SongModel>(
          builder: (BuildContext context, SongModel songModel, Widget child) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PlayerHome(albumCover: songModel.song.albumCover)));
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 27.5,
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 15,
                    right: 15,
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 44,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: <Color>[Colors.black26,Colors.black],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft
                                )
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 160,
                            height: 16,
                            child: AutoWidgetMarquee(
                              maxWidth: 160,
                              content: Text('${songModel.song.songName} - ${songModel.song.singer}',
                                style: TextStyle(color: Colors.white,fontSize: 14)),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: (){
                              songModel.switchPlayer();
                            },
                            child: Icon(
                              songModel.playState == AudioPlaybackState.playing
                                  ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                                size: 30,color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            child: Icon(Icons.queue_music,size: 30,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black26,offset: Offset(8 , 6),
                              blurRadius: 6
                            ),
                          ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(songModel.song.albumCover,width: 50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


}
