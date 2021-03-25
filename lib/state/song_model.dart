import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/model/song.dart';
import 'package:musicplayer/utils/pick_img_main_color.dart';
import 'global.dart';

class SongModel with ChangeNotifier {


  List<Song> get songs => Global.songs;
  int get currentIndex => Global.currentIndex;
  set currentIndex (int index){
    currentIndex = index;
  }

  Song get song => songs[currentIndex];
  AudioPlayer get audioPlayer => Global.audioPlayer;
  AudioPlaybackState get playState => Global.audioPlayer.playbackState;

  void changeSong (int index) {
    currentIndex = index;
    audioPlayer.setAsset(song.songUrl);
  }

  void switchPlayer (){
    if(playState == AudioPlaybackState.playing){
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    notifyListeners();
  }

  void setIsLiked (bool isLiked){
    song.isLiked = isLiked;
    notifyListeners();
  }

  Future<Color> getBackColor() async {
    Color backColor = await PickImgMainColor.pick(AssetImage(song.albumCover));
    notifyListeners();
    return backColor;
  }

}