import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_debug/models/album_module.dart';
import 'package:web_debug/network_module/api_response.dart';
import 'package:web_debug/providers/album_details_provider.dart';
import 'package:web_debug/providers/albums_provider.dart';
import 'package:web_debug/views/home_page.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Network Layer With Provider')),
        body: Container(
            padding: const EdgeInsets.all(20), child: showListOFAlbum(context)),
      ),
    );
  }

  Widget showListOFAlbum(BuildContext context) {
    return Consumer<AlbumProviders>(builder: (context, myModel, child) {
      if (myModel.albums.status == Status.COMPLETED) {
        return showData(context, myModel.albums.data);
      } else if (myModel.albums.status == Status.ERROR) {
        return Text("Error : ${myModel.albums.message}");
      } else {
        return Text("${myModel.albums.message}");
      }
    });
  }

  Widget showData(BuildContext context, List<Album> albums) {
    return ListView.builder(
      itemCount: albums?.length,
      itemBuilder: (context, i) => ListTile(
          title: Text(albums[i].title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(album: albums[i]),
              ),
            );
          }),
    );
  }
}
