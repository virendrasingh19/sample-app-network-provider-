import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_debug/models/album_module.dart';

import '../network_module/api_response.dart';
import '../providers/album_details_provider.dart';

class HomePage extends StatelessWidget {
  // Declare a field that holds the Album.
  final Album album;

  const HomePage({Key key, @required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Network Layer With Provider')),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<AlbumDetailsProvider>(
                create: (context) => AlbumDetailsProvider(album.id)),
          ], child: albumTitle(context)),
      ),
    );
  }

  Widget albumTitle(BuildContext context) {
    return Consumer<AlbumDetailsProvider>(builder: (context, myModel, child) {
      if (myModel.album.status == Status.COMPLETED) {
        return Text("${myModel.album.data.title}");
      } else if (myModel.album.status == Status.ERROR) {
        return Text("Error : ${myModel.album.message}");
      } else {
        return Text("${myModel.album.message}");
      }
    });
  }
}
