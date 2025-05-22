import 'package:flutter/material.dart';
import '../models/playlist_model.dart';

class PlaylistTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistTile({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(playlist.name),
        subtitle: Text("Jumlah Lagu: ${playlist.songCount}"),
        onTap: onTap,
      ),
    );
  }
}
