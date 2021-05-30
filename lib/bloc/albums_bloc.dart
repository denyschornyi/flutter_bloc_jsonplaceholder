//event , state => new state => update ui

import 'package:flutter_albums/api/services.dart';
import 'package:flutter_albums/bloc/albums_events.dart';
import 'package:flutter_albums/bloc/albums_states.dart';
import 'package:flutter_albums/model/albums_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsBloc extends Bloc<AlbumsEvents, AlbumState> {
  final AlbumsRepo albumsRepo;
  List<Album> albums;

  AlbumsBloc({this.albumsRepo}) : super(AlbumInitState());

  @override
  Stream<AlbumState> mapEventToState(AlbumsEvents event) async* {
    switch (event) {
      case AlbumsEvents.fetchAlbums:
        yield AlbumLoading();
        albums = await albumsRepo.getAlbumsList();
        yield AlbumLoaded(albums: albums);
        break;
    }
  }
}
