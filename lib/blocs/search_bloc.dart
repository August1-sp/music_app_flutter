import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/audiodb_api.dart';
import '../models/artist.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final String query;
  final List<Artist> artists;
  final SearchStatus status;
  final String? error;

  SearchState({
    this.query = '',
    this.artists = const [],
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
      final response = await _audioDbService.searchArtists(query);
      emit(SearchState(
        query: query,
        artists: response.artists ?? [],
        status: SearchStatus.success,
      ));
    } catch (e) {
      emit(SearchState(
        query: query,
        status: SearchStatus.failure,
        error: e.toString(),
      ));
    }
  }
}