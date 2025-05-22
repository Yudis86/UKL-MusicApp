import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/song_model.dart';

class SongService {
  Future<List<Song>> fetchSongs(String playlistId, {String? search}) async {
    final uri = Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl2/playlists/song-list/$playlistId')
        .replace(queryParameters: search != null ? {'search': search} : null);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List;
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }

  Future<Song> fetchSongDetail(String songId) async {
    final response = await http.get(Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl2/playlists/song/$songId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Song.fromJson(data);
    } else {
      throw Exception('Failed to load song detail');
    }
  }
}
