import 'package:flutter/cupertino.dart';
import 'package:web_debug/models/album_module.dart';
import 'package:web_debug/models/albums.dart';
import 'package:web_debug/network_module/api_response.dart';
import 'package:web_debug/repositories/album_repo.dart';

class AlbumProviders extends ChangeNotifier {
  AlbumRepository _albumRepository;

  ApiResponse<List<Album>> _album;

  ApiResponse<List<Album>> get albums => _album;

  AlbumProviders() {
    _albumRepository = AlbumRepository();
    fetchAlbums();
  }

  fetchAlbums() async {
    _album = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      Albums album = await _albumRepository.fetchListOfAlbum();
      _album = ApiResponse.completed(album.albums);
      notifyListeners();
    } catch (e) {
      _album = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
