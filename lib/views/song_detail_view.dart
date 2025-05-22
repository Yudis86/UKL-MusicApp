import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../services/song_service.dart';
import '../models/song_model.dart';

class SongDetailView extends StatefulWidget {
  final String songId;
  const SongDetailView({super.key, required this.songId});

  @override
  State<SongDetailView> createState() => _SongDetailViewState();
}

class _SongDetailViewState extends State<SongDetailView> {
  final SongService _songService = SongService();
  late Song song;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSong();
  }

  void _loadSong() async {
    song = await _songService.fetchSongDetail(widget.songId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Detail Lagu", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId:
                          YoutubePlayer.convertUrlToId(song.source)!,
                      flags: YoutubePlayerFlags(autoPlay: false),
                    ),
                    showVideoProgressIndicator: true,
                  ),
                  const SizedBox(height: 12),
                  Text(song.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text("By ${song.artist}",
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Text(song.description, style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  Text("Komentar:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  ...song.comments.map((c) => ListTile(
                        title: Text(c['creator'],
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(c['comment_text'],
                            style: TextStyle(color: Colors.white70)),
                        trailing: Text(c['createdAt'],
                            style:
                                TextStyle(color: Colors.white38, fontSize: 12)),
                      )),
                ],
              ),
            ),
    );
  }
}
