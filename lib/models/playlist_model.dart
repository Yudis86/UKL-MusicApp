class Playlist {
  final String uuid;
  final String name;
  final int songCount;

  Playlist({
    required this.uuid,
    required this.name,
    required this.songCount,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      uuid: json['uuid'],
      name: json['playlist_name'],
      songCount: json['song_count'],
    );
  }
}
