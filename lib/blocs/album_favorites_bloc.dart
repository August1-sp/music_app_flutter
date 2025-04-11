import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/album_favorites.dart';
import 'package:hive/hive.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState {
  final List<FavoriteArtist> artists;
  final FavoritesStatus status;
  final String? error;
  const FavoritesState({
    this.artists = const [],
    this.status = FavoritesStatus.initial,
    this.error,
  });
  FavoritesState copyWith({
    List<FavoriteArtist>? artists,
    FavoritesStatus? status,
    String? error,
  }) {
    return FavoritesState(
      artists: artists ?? this.artists,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

class FavoritesBloc extends Cubit<FavoritesState> {
  final Box<FavoriteArtist> _favoritesBox;
  FavoritesBloc(this._favoritesBox) : super(const FavoritesState()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    try {
      final favorites = _favoritesBox.values.toList();
      emit(state.copyWith(
        status: FavoritesStatus.success,
        artists: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        error: 'Erreur lors du chargement des favoris: $e',
      ));
    }
  }

  Future<void> addFavorite(FavoriteArtist artist) async {
    try {
      await _favoritesBox.put(artist.id, artist);
      final favorites = _favoritesBox.values.toList();
      emit(state.copyWith(
        status: FavoritesStatus.success,
        artists: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        error: 'Erreur lors de l\'ajout aux favoris: $e',
      ));
    }
  }

  Future<void> removeFavorite(String artistId) async {
    try {
      await _favoritesBox.delete(artistId);
      final favorites = _favoritesBox.values.toList();
      emit(state.copyWith(
        status: FavoritesStatus.success,
        artists: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        error: 'Erreur lors de la suppression des favoris: $e',
      ));
    }
  }

  bool isFavorite(String artistId) {
    return _favoritesBox.containsKey(artistId);
  }
}