import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/models/album.dart';
import '../api/audiodb_api.dart';
import '../models/track.dart';

enum ChartsStatus { initial, loading, success, failure }

class ChartsState {
  final List<Track> trendingSingles;
  final List<Album> trendingAlbums;
  final ChartsStatus status;
  final String? error;

  const ChartsState({
    this.trendingSingles = const [],
    this.trendingAlbums = const [],
    this.status = ChartsStatus.initial,
    this.error,
  });
}

class ChartsBloc extends Cubit<ChartsState> {
  final AudioDbService _audioDbService;

  ChartsBloc(this._audioDbService) : super(const ChartsState()) {
    loadCharts();
  }

  Future<void> loadCharts() async {
    emit(const ChartsState(status: ChartsStatus.loading));

    try {
      final singlesResponse = await _audioDbService.getTrendingSingles(
        'us',
        'itunes',
        'singles',
      );

      final albumsResponse = await _audioDbService.getTrendingAlbums(
        'us',
        'itunes',
        'albums',
      );

      //print('Singles response: ${singlesResponse.tracks?.length}');
      //print('Albums response: ${albumsResponse.albums?.length}');

      emit(
        ChartsState(
          trendingSingles: singlesResponse.tracks ?? [],
          trendingAlbums: albumsResponse.albums ?? [],
          status: ChartsStatus.success,
        ),
      );
    } catch (e) {
      print('Error loading charts: $e');
      emit(ChartsState(status: ChartsStatus.failure, error: e.toString()));
    }
  }
}
