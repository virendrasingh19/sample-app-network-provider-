import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_debug/models/albums.dart';

import '../models/album_module.dart';
import '../network_module/api_path.dart';
import '../network_module/http_client.dart';

class AlbumRepository {
  Future<Albums> fetchAlbumDetails(int getCurrentAlbumId) async {
    print(getCurrentAlbumId);
    Map<String, String> params = new HashMap();
    params.putIfAbsent("id", () => getCurrentAlbumId.toString());
    final response = await HttpClient.instance.fetchDataAndCache(
        APIPathHelper.getValue(APIPath.fetch_albums),
        params: params);

    print("ResponseFromRepository - $response");
    return Albums.fromJson(response);
  }

  Future<Albums> fetchListOfAlbum() async {
    final response = await HttpClient.instance
        .fetchDataAndCache(APIPathHelper.getValue(APIPath.fetch_albums));
    print("Response - $response");
    return Albums.fromJson(response);
  }
}
