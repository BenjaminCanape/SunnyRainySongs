import 'dart:convert';

import 'package:http/http.dart';

class Music {
  static const String deezerBaseUrl = "https://api.deezer.com/";
  late Map playlists;
  late List<String> playlistFrames = [];

  searchPlaylist(String weatherName) async {
    Response response = await get(
        Uri.parse("${deezerBaseUrl}search/playlist?limit=10&q=$weatherName"));
    playlists = jsonDecode(response.body);
    List<dynamic> playlistsData = playlists['data'];

    playlistFrames = [];
    for (int i = 0; i < playlistsData.length; i++) {
      await getPlaylist(playlistsData[i]['id']);
    }
  }

  getPlaylist(int id) async {
    Response response = await get(Uri.parse(
        "${deezerBaseUrl}oembed?url=https://www.deezer.com/playlist/$id&maxwidth=500&maxheight=200&tracklist=true&format=json"));
    Map playlist = jsonDecode(response.body);
    playlistFrames.add(playlist['html'].toString());
  }
}
