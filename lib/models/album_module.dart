import 'package:json_annotation/json_annotation.dart';

part 'album_module.g.dart';

@JsonSerializable(explicitToJson: true)
class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> data) => _$AlbumFromJson(data);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
