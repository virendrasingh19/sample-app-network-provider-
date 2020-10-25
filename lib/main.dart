import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_debug/providers/albums_provider.dart';
import 'package:web_debug/views/landing_screen.dart';

import 'providers/album_details_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumProviders>(
            create: (context) => AlbumProviders()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: LandingScreen()),
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingScreen()),
            );
          },
        ),
      ),
    );
  }
}
