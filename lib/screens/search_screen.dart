import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/api/audiodb_api.dart';
import '../blocs/search_bloc.dart';
import '../models/artist.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(context.read<AudioDbService>()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Rechercher',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SearchBar(),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == SearchStatus.success) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          return ArtistListItem(
                            artist: state.artists[index],
                            onTap: () => context.go('/artist/${state.artists[index].id}'),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('Commencez votre recherche'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher un artiste...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        context.read<SearchBloc>().search(value);
      },
    );
  }
}

class ArtistListItem extends StatelessWidget {
  final Artist artist;
  final VoidCallback onTap;

  const ArtistListItem({
    super.key,
    required this.artist,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: artist.thumbnailUrl != null
            ? NetworkImage(artist.thumbnailUrl!)
            : null,
        child: artist.thumbnailUrl == null
            ? const Icon(Icons.person)
            : null,
      ),
      title: Text(artist.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}