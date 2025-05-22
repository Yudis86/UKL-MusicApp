import 'package:flutter/material.dart';
import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongTile({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Image.network('https://learn.smktelkom-mlg.sch.id/ukl2/thumbnail/${song.thumbnail}', width: 60),
        title: Text(song.title),
        subtitle: Text(song.artist),
        onTap: onTap,
      ),
    );
  }
}
