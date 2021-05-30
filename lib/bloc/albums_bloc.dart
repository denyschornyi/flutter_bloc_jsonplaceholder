import 'dart:io';
import 'package:flutter_albums/api/exceptions.dart';
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
        try {
          albums = await albumsRepo.getAlbumsList();
          yield AlbumLoaded(albums: albums);
        } on SocketException {
          yield AlbumListError(error: NoInternetException('No internet'));
        } on HttpException {
          yield AlbumListError(
              error: NoServiceFoundException('No service found'));
        } on FormatException {
          yield AlbumListError(
              error: InvalidFormatException('Invalid response format'));
        } catch (e) {
          yield AlbumListError(error: UnknownException('Unknown error' ));
        }
        break;
    }
  }
}
