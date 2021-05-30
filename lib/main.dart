import 'package:flutter/material.dart';
import 'package:flutter_albums/api/services.dart';
import 'package:flutter_albums/bloc/albums_bloc.dart';
import 'package:flutter_albums/screens/albums_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Albums',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AlbumsBloc>(
        create: (context) => AlbumsBloc(albumsRepo: AlbumServices()),
        child: AlbumScreen(),
      ),
    );
  }
}
