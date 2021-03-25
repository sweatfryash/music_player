import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/pages/song_list/local_music_list.dart';
import 'package:musicplayer/state/song_model.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin{

  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 40,
          height: 35,
          child: TabBar(
              controller: _tabController,
              tabs: <Widget>[Tab(text: '我的')],
              labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            labelPadding: EdgeInsets.zero,
            indicatorWeight: 4,
            indicatorColor: Theme.of(context).accentColor,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 4
              )
            ),
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(-8),
          child: Container(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          Consumer<SongModel>(
            builder: (BuildContext context, SongModel value, Widget child) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => LocalMusicList()));
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.file_download,
                        size: 32,
                        color: Theme.of(context).accentColor),
                    Text('本地')
                  ],
                ),
              );
          },
          ),
        ],
      ),
    );
  }
}
