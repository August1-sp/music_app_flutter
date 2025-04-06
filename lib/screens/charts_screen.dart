import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/api/audiodb_api.dart';
import 'package:music_app/models/album.dart';
import 'package:music_app/widgets/album_item.dart';
import 'package:music_app/widgets/track_item.dart';
import '../blocs/charts_bloc.dart';
import '../models/track.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartsBloc(context.read<AudioDbService>())..loadCharts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Classements',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Titres'),
              Tab(text: 'Albums'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: BlocBuilder<ChartsBloc, ChartsState>(
          builder: (context, state) {
            if (state.status == ChartsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ChartsStatus.failure) {
              return Center(
                child: Text(state.error ?? 'Une erreur est survenue'),
              );
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildTracksListView(state.trendingSingles),
                _buildAlbumsListView(state.trendingAlbums),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTracksListView(List<Track> tracks) {
    if (tracks.isEmpty) {
      return const Center(child: Text('Aucun titre tendance pour le moment'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: track.thumbnailUrl != null
                    ? Image.network(
                        track.thumbnailUrl!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.music_note),
                          );
                        },
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[300],
                        child: const Icon(Icons.music_note),
                      ),
              ),
            ],
          ),
          title: Text(
            track.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            track.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlbumsListView(List<Album> albums) {
    if (albums.isEmpty) {
      return const Center(child: Text('Aucun album tendance pour le moment'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: album.thumbnailUrl != null
                    ? Image.network(
                        album.thumbnailUrl!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.album),
                          );
                        },
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[300],
                        child: const Icon(Icons.album),
                      ),
              ),
            ],
          ),
          title: Text(
            album.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            album.artist,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        );
      },
    );
  }
}