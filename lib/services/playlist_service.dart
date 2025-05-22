import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/playlist_model.dart';

class PlaylistService {
  Future<List<Playlist>> fetchPlaylists() async {
    final url = Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl2/playlists');
    final response = await http.get(url);

    print(">> Status Code: ${response.statusCode}");
    print(">> Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List<dynamic> playlistList = decoded['data'];

      return playlistList.map((json) => Playlist.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data playlist');
    }
  }
}
