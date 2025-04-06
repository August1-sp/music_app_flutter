import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/api/audiodb_api.dart';
import '../blocs/artist_bloc.dart';

class ArtistPage extends StatelessWidget {
  final String artistId;

  const ArtistPage({
    Key? key,
    required this.artistId,
  }) : super(key: key);

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

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(state.artist!.name),
                    background: state.artist!.thumbnailUrl != null
                        ? Image.network(
                            state.artist!.thumbnailUrl!,
                            fit: BoxFit.cover,
                          )
                        : Container(color: Colors.grey),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        // TODO: Implement favorites
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.artist!.genre != null ||
                            state.artist!.country != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              [
                                state.artist!.genre,
                                state.artist!.country,
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
                          state.artist!.biographyFr ??
                              state.artist!.biographyEn ??
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