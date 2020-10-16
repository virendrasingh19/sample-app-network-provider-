import 'package:flutter/cupertino.dart';
import 'package:web_debug/models/album_module.dart';
import 'package:web_debug/network_module/api_response.dart';
import 'package:web_debug/repositories/album_repo.dart';

class AlbumDetailsProvider with ChangeNotifier {
  AlbumRepository _albumRepository;

  ApiResponse<Album> _album;

  ApiResponse<Album> get album => _album;

  AlbumDetailsProvider() {
    _albumRepository = AlbumRepository();
    fetchAlbumDetails();
  }

  fetchAlbumDetails() async {
    _album = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      Album album = await _albumRepository.fetchAlbumDetails();
      _album = ApiResponse.completed(album);
      notifyListeners();
    } catch (e) {
      _album = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}