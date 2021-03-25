import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Song {
  Song({
    this.songName,
    this.songUrl,
    this.lyricUrl,
    this.likeNum,
    this.isLiked,
    this.commentNum,
    this.singer,
    this.album,
    this.albumCover,
  });

  factory Song.fromJson(Map<String, dynamic> jsonRes) => jsonRes == null
      ? null
      : Song(
    songName: asT<String>(jsonRes['songName']),
    songUrl: asT<String>(jsonRes['songUrl']),
    lyricUrl: asT<String>(jsonRes['lyricUrl']),
    likeNum: asT<String>(jsonRes['likeNum']),
    isLiked: asT<bool>(jsonRes['isLiked']),
    commentNum: asT<String>(jsonRes['commentNum']),
    singer: asT<String>(jsonRes['singer']),
    album: asT<String>(jsonRes['album']),
    albumCover: asT<String>(jsonRes['albumCover']),
  );

  String songName;
  String songUrl;
  String lyricUrl;
  String likeNum;
  bool isLiked;
  String commentNum;
  String singer;
  String album;
  String albumCover;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'songName': songName,
    'songUrl': songUrl,
    'lyricUrl': lyricUrl,
    'likeNum': likeNum,
    'isLiked': isLiked,
    'commentNum': commentNum,
    'singer': singer,
    'album': album,
    'albumCover': albumCover,
  };
  @override
  String toString() {
    return json.encode(this);
  }
}
