import 'package:flutter/material.dart';
import 'package:flutter_albums/bloc/albums_bloc.dart';
import 'package:flutter_albums/bloc/albums_events.dart';
import 'package:flutter_albums/bloc/albums_states.dart';
import 'package:flutter_albums/model/albums_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  AlbumsBloc albumsBloc;

  @override
  void initState() {
    super.initState();
    albumsBloc = BlocProvider.of<AlbumsBloc>(context);
    albumsBloc.add(AlbumsEvents.fetchAlbums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        BlocBuilder<AlbumsBloc, AlbumState>(
            builder: (BuildContext context, AlbumState state) {
          if (state is AlbumListError) {
            final error = state.error;
            return Expanded(
              child: Center(
                child: Container(
                  child: Text(
                    error.message,
                    style: TextStyle(color: Colors.red, fontSize: 20,),
                  ),
                ),
              ),
            );
          }
          if (state is AlbumLoaded) {
            List<Album> albums = state.albums;
            return _list(albums);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        })
      ],
    );
  }

  Widget _list(List<Album> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          Album album = albums[index];
          return Text(album.title);
        },
      ),
    );
  }
}
