import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../services/song_service.dart';
import 'song_detail_view.dart';

class SongListView extends StatefulWidget {
  final String playlistId;
  const SongListView({super.key, required this.playlistId});

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
  final SongService _songService = SongService();
  List<Song> songs = [];
  bool isLoading = true;
  String search = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  void _loadSongs() async {
    songs = await _songService.fetchSongs(widget.playlistId, search: search);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Daftar Lagu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (val) {
                search = val;
                _loadSongs();
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari lagu...',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          isLoading
              ? Expanded(child: Center(child: CircularProgressIndicator(color: Colors.pinkAccent)))
              : Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (_, i) => Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: Image.network(
                          'https://learn.smktelkom-mlg.sch.id/ukl2/thumbnail/${songs[i].thumbnail}',
                          width: 60,
                          errorBuilder: (_, __, ___) => Icon(Icons.music_note, color: Colors.white),
                        ),
                        title: Text(songs[i].title, style: TextStyle(color: Colors.white)),
                        subtitle: Text(songs[i].artist, style: TextStyle(color: Colors.white70)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SongDetailView(songId: songs[i].uuid)),
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
