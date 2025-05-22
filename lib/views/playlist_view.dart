import 'package:flutter/material.dart';
import '../services/playlist_service.dart';
import '../models/playlist_model.dart';
import 'song_list_view.dart';

class PlaylistView extends StatefulWidget {
  final String username;
  const PlaylistView({super.key, required this.username});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final PlaylistService _playlistService = PlaylistService();
  List<Playlist> playlists = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      playlists = await _playlistService.fetchPlaylists();
      errorMessage = '';
    } catch (e) {
      errorMessage = 'Gagal mengambil playlist: $e';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Music App - Playlist', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.redAccent)))
              : ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final p = playlists[index];
                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(p.name, style: TextStyle(color: Colors.white)),
                        subtitle: Text('${p.songCount} lagu', style: TextStyle(color: Colors.white70)),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SongListView(playlistId: p.uuid),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
