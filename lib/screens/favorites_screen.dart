import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/album_favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          switch (state.status) {
            case FavoritesStatus.loading:
              return const Center(child: CircularProgressIndicator());
              
            case FavoritesStatus.failure:
              return Center(
                child: Text(state.error ?? 'Une erreur est survenue'),
              );
              
            case FavoritesStatus.success:
              if (state.artists.isEmpty) {
                return const Center(
                  child: Text('Aucun artiste favori'),
                );
              }
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                    child: Text(
                      'Artistes favoris',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.artists.length,
                    itemBuilder: (context, index) {
                      final artist = state.artists[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: artist.thumbnailUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(artist.thumbnailUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.grey[300],
                          ),
                          child: artist.thumbnailUrl == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                        title: Text(artist.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            context.read<FavoritesBloc>().removeFavorite(artist.id);
                          },
                        ),
                        onTap: () => context.go('/artist/${artist.id}'),
                      );
                    },
                  ),
                ],
              );
              
            case FavoritesStatus.initial:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}