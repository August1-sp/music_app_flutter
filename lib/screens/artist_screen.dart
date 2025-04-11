import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/api/audiodb_api.dart';
import 'package:music_app/blocs/album_favorites_bloc.dart';
import 'package:music_app/models/album_favorites.dart';
import '../blocs/artist_bloc.dart';

class ArtistPage extends StatelessWidget {
  final String artistId;

  const ArtistPage({
    super.key,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistBloc(
        context.read<AudioDbService>(),
        artistId,
      ),
      child: Scaffold(
        body: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            if (state.status == ArtistStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ArtistStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error ?? 'Une erreur est survenue'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ArtistBloc>().loadArtist();
                      },
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            }

            if (state.artist == null) {
              return const Center(child: Text('Artiste non trouvé'));
            }

            final artist = state.artist!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (artist.thumbnailUrl != null)
                          Image.network(
                            artist.thumbnailUrl!,
                            fit: BoxFit.cover,
                          )
                        else
                          Container(color: Colors.grey[400]),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                                    onPressed: () => context.go('/'),
                                  ),
                                  const Spacer(),
                                  BlocBuilder<FavoritesBloc, FavoritesState>(
                                    builder: (context, favState) {
                                      final isFavorite = favState.artists.any(
                                        (a) => a.id == artist.id,
                                      );
                                      return IconButton(
                                        icon: Icon(
                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          final favoritesBloc = context.read<FavoritesBloc>();
                                          if (favoritesBloc.isFavorite(artist.id)) {
                                            favoritesBloc.removeFavorite(artist.id);
                                          } else {
                                            favoritesBloc.addFavorite(FavoriteArtist(
                                              id: artist.id,
                                              name: artist.name,
                                              thumbnailUrl: artist.thumbnailUrl,
                                            ));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  artist.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (artist.genre != null || artist.country != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              [
                                artist.genre,
                                artist.country,
                              ].where((e) => e != null).join(' • '),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        const Text(
                          'Biographie',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          artist.biographyFr ??
                              artist.biographyEn ??
                              'Aucune biographie disponible',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
