 import 'package:flutter/material.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:musicplayer/widget/player_bar.dart';
import 'package:musicplayer/widget/scroll_text.dart';
import 'package:provider/provider.dart';

class LocalMusicList extends StatefulWidget {
  @override
  _LocalMusicListState createState() => _LocalMusicListState();
}

class _LocalMusicListState extends State<LocalMusicList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本地歌曲'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(-8),
          child: Container(),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){

            },
          )
        ],
      ),
      body: Stack(
          children: <Widget>[
           Container(
             child: ListView.builder(
               padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 30,
                      child: Text('$index' * 5),
                    );
                  },
        ),
           ),
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Consumer<SongModel>(
                  builder: (BuildContext context, SongModel songModel, Widget child) {
                    return Hero(
                        tag: 'playerbar',
                        child: PlayerBar());
                  },))
            ,
          ],
        ),
    );
  }
}
