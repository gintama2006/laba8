class SongModel {
  final String songName;
  final double songDuration;
  final String url;

  SongModel({
    required this.songName,
    required this.songDuration,
    required this.url
  });
}

class AlbumModel {
  final String albumPhoto;
  final String albumName;
  final String albumSinger;
  final List<SongModel> songsList;

  AlbumModel({
    required this.albumPhoto,
    required this.albumName,
    required this.albumSinger,
    required this.songsList,
  });
}
