import 'package:equatable/equatable.dart';
import 'package:flutter_albums/model/albums_list.dart';

abstract class AlbumState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumInitState extends AlbumState{}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;

  AlbumLoaded({this.albums});
}

class AlbumListError extends AlbumState {
  final error;

  AlbumListError({this.error});
}
