import 'package:json_annotation/json_annotation.dart';
import 'package:web_debug/models/album_module.dart';

part 'albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Albums {
  List<Album> albums;

  Albums({this.albums});

  factory Albums.fromJson(List<dynamic> json) {
    return Albums(
        albums: json
            .map((e) => Album.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
