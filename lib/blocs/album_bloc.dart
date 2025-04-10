import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/audiodb_api.dart';
import '../models/album.dart';

enum AlbumStatus { initial, loading, success, failure }

class AlbumState {
  final Album? album;
  final AlbumStatus status;
  final String? error;

  AlbumState({
    this.album,
    this.status = AlbumStatus.initial,
    this.error,
  });

  AlbumState copyWith({
    Album? album,
    AlbumStatus? status,
    String? error,
  }) {
    return AlbumState(
      album: album ?? this.album,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

class AlbumBloc extends Cubit<AlbumState> {
  final AudioDbService _audioDbService;
  final String albumId;

  AlbumBloc(this._audioDbService, this.albumId) : super(AlbumState()) {
    loadAlbum();
  }

  Future<void> loadAlbum() async {
    emit(state.copyWith(status: AlbumStatus.loading));

    try {
      final albumResponse = await _audioDbService.getAlbum(albumId);
      final albumData = albumResponse.albums?.first;

      if (albumData == null) {
        emit(AlbumState(status: AlbumStatus.failure, error: 'Album non trouvé'));
        return;
      }

      final trackResponse = await _audioDbService.getAlbumTracks(albumId);
      final tracks = trackResponse.tracks ?? [];

      final albumWithTracks = Album(
        id: albumData.id,
        name: albumData.name,
        artist: albumData.artist,
        thumbnailUrl: albumData.thumbnailUrl,
        score: albumData.score,
        scoreVotes: albumData.scoreVotes,
        descriptionEn: albumData.descriptionEn,
        descriptionFr: albumData.descriptionFr,
        tracks: tracks,
      );

      emit(
        AlbumState(
          album: albumWithTracks,
          status: AlbumStatus.success,
        ),
      );
    } catch (e) {
      print('Error loading album: $e');
      emit(AlbumState(status: AlbumStatus.failure, error: e.toString()));
    }
  }
}
