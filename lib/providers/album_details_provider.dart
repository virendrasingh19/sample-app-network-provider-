import 'package:flutter/cupertino.dart';
import 'package:web_debug/models/album_module.dart';
import 'package:web_debug/models/albums.dart';
import 'package:web_debug/network_module/api_response.dart';
import 'package:web_debug/repositories/album_repo.dart';

class AlbumDetailsProvider with ChangeNotifier {
  AlbumRepository _albumRepository;

  ApiResponse<Album> _album;

  int id;

  ApiResponse<Album> get album => _album;

  AlbumDetailsProvider(int id) {
    _albumRepository = AlbumRepository();
    fetchAlbumDetails(id);
    print("h2");
  }

  fetchAlbumDetails(int id) async {
    _album = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      Albums album = await _albumRepository.fetchAlbumDetails(id);
      _album = ApiResponse.completed(album.albums[0]);
      notifyListeners();
    } catch (e) {
      _album = ApiResponse.error(e.toString());
      notifyListeners();
    }
    print("hello");
  }

  int getCurrentAlbumId() {
    return id;
  }

  setCurrentAlbumId(int id) {
    id = this.id;
  }
}
