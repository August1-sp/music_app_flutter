import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import '../api/audiodb_api.dart';
import '../models/artist.dart';
import '../models/album.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final String query;
  final List<Artist> artists;
  final List<Album> albums;
  final SearchStatus status;
  final String? error;

  SearchState({
    this.query = '',
    this.artists = const [],
    this.albums = const [],
    this.status = SearchStatus.initial,
    this.error,
  });
}

class SearchBloc extends Cubit<SearchState> {
  final AudioDbService _audioDbService;

  SearchBloc(this._audioDbService) : super(SearchState());

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchState());
      return;
    }

    emit(SearchState(query: query, status: SearchStatus.loading));

    try {
      developer.log('Démarrage de la recherche pour: $query');

      // Rechercher les artistes et les albums en parallèle
      final artistsResponse = await _audioDbService.searchArtists(query);
      final albumsResponse = await _audioDbService.searchAlbums(query);

      developer.log(
        'Réponse artistes: ${jsonEncode(artistsResponse.artists?.map((a) => a.name).toList())}',
      );
      developer.log(
        'Réponse albums raw: ${jsonEncode(albumsResponse.toJson())}',
      );

      final artists = artistsResponse.artists ?? [];
      final albums = albumsResponse.album ?? [];

      developer.log('Nombre d\'artistes trouvés: ${artists.length}');
      developer.log('Nombre d\'albums trouvés: ${albums.length}');

      emit(
        SearchState(
          query: query,
          artists: artists,
          albums: albums,
          status: SearchStatus.success,
        ),
      );
    } catch (e, stackTrace) {
      developer.log('Erreur de recherche: ${e.toString()}');
      developer.log('Stack trace: $stackTrace');
      emit(
        SearchState(
          query: query,
          status: SearchStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
