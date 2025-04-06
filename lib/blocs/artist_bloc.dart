import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/audiodb_api.dart';
import '../models/artist.dart';

enum ArtistStatus { initial, loading, success, failure }

class ArtistState {
  final Artist? artist;
  final ArtistStatus status;
  final String? error;

  ArtistState({this.artist, this.status = ArtistStatus.initial, this.error});
}

class ArtistBloc extends Cubit<ArtistState> {
  final AudioDbService _audioDbService;
  final String artistId;

  ArtistBloc(this._audioDbService, this.artistId) : super(ArtistState()) {
    loadArtist();
  }

  Future<void> loadArtist() async {
    emit(ArtistState(status: ArtistStatus.loading));

    try {
      final response = await _audioDbService.getArtist(artistId);
      if (response.artists == null || response.artists!.isEmpty) {
        emit(
          ArtistState(
            status: ArtistStatus.failure,
            error: 'Artiste non trouvé',
          ),
        );
        return;
      }

      emit(
        ArtistState(
          artist: response.artists!.first,
          status: ArtistStatus.success,
        ),
      );
    } catch (e) {
      print('Error loading artist: $e');
      emit(ArtistState(status: ArtistStatus.failure, error: e.toString()));
    }
  }
}
