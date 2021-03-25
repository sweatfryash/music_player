
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/model/song.dart';

class Global {

  static AudioPlayer audioPlayer = AudioPlayer();

  static List<Song> songs = <Song>[
    Song(
      singer: 'Lana Del Rey',
      songName: 'Summertime Sadness',
      albumCover: 'assets/images/summertime_sadness.jpg',
      album: 'Born To Die(Deluxe Version)',
      commentNum: '1010',
      likeNum: '2133',
      isLiked: true,
    ),
    Song(
        singer: 'Lady Gaga',
        songName: 'Always Remember Us This Way',
        songUrl: 'assets/audios/Mojito.mp3',
        albumCover: 'assets/images/alwaysrememberusthisway.jpg',
        album: 'A Star is Born Soundtrack (Without Dialogue)',
        commentNum: '1010',
        likeNum: '2133',
        isLiked: true),
  ];

  static int currentIndex = 1;

}