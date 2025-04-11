import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/blocs/favorites_bloc.dart';
import '../api/audiodb_api.dart';
import '../blocs/album_bloc.dart';
import '../models/favorites.dart';

class AlbumPage extends StatelessWidget {
  final String albumId;

  const AlbumPage({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(
        context.read<AudioDbService>(),
        albumId,
      ),
      child: Scaffold(
        body: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state.status == AlbumStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == AlbumStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error ?? 'Une erreur est survenue'),
                    ElevatedButton(
                      onPressed: () => context.read<AlbumBloc>().loadAlbum(),
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            }

            final album = state.album!;
            final tracks = album.tracks ?? [];

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (album.thumbnailUrl != null)
                          Image.network(
                            album.thumbnailUrl!,
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
                                  IconButton(
                                     icon: BlocBuilder<FavoritesBloc, FavoritesState>(
                                       builder: (context, state) {
                                         final isFavorite = state.artists.any((artist) => artist.id == album.artist);
                                         return Icon(
                                           isFavorite ? Icons.favorite : Icons.favorite_border,
                                           color: Colors.white,
                                         );
                                       },
                                     ),
                                     onPressed: () {
                                       final favoritesBloc = context.read<FavoritesBloc>();
                                       if (favoritesBloc.isFavorite(album.artist)) {
                                         favoritesBloc.removeFavorite(album.artist);
                                       } else {
                                         favoritesBloc.addFavorite(FavoriteArtist(
                                           id: album.artist,
                                           name: album.artist,
                                           thumbnailUrl: album.thumbnailUrl,
                                         ));
                                       }
                                     },
                                   ),
                                ],
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  album.artist,
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  album.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Center(
                                child: Text(
                                  "${tracks.length} chansons",
                                  style: const TextStyle(color: Colors.white70),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (album.score != null)
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 8),
                              Text(
                                "${album.score!.toStringAsFixed(1)} / 10"
                                " (${album.scoreVotes ?? 0} votes)",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        const Text(
                          'Description',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          album.description ?? 'Aucune description disponible',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Titres',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...tracks.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final track = entry.value;
                          return ListTile(
                            leading: Text('$index.'),
                            title: Text(track.title),
                            subtitle: track.artist != album.artist
                                ? Text(track.artist)
                                : null,
                          );
                        }).toList(),
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
