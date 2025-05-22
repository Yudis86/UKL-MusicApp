class Song {
  final String uuid;
  final String title;
  final String artist;
  final String description;
  final String source;
  final String thumbnail;
  final int likes;
  final List<dynamic> comments;

  Song({
    required this.uuid,
    required this.title,
    required this.artist,
    required this.description,
    required this.source,
    required this.thumbnail,
    required this.likes,
    required this.comments,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      uuid: json['uuid'],
      title: json['title'],
      artist: json['artist'],
      description: json['description'],
      source: json['source'],
      thumbnail: json['thumbnail'],
      likes: json['likes'],
      comments: json['comments'],
    );
  }
}
