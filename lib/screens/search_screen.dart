import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/api/audiodb_api.dart';
import '../blocs/search_bloc.dart';
import '../models/artist.dart';
import '../models/album.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(context.read<AudioDbService>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 44.0),
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: Text(
                    'Rechercher',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 36,
                      height: 40 / 36,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SearchBar(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE5E5E5),
                ),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.status == SearchStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == SearchStatus.success &&
                      (state.artists.isNotEmpty || state.albums.isNotEmpty)) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.artists.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Artistes',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 24,
                                        height: 28 / 24,
                                        letterSpacing: -0.2,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                      ),
                                      child: const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(0xFFE5E5E5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: state.artists.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 4.0,
                                    ),
                                    child: Container(
                                      width: 345,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F3F3),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: ArtistListItem(
                                        artist: state.artists[index],
                                        onTap:
                                            () => context.go(
                                              '/artist/${state.artists[index].id}',
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                            if (state.albums.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  top: 24.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Albums',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 24,
                                        height: 28 / 24,
                                        letterSpacing: -0.2,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                      ),
                                      child: const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(0xFFE5E5E5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: state.albums.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 4.0,
                                    ),
                                    child: Container(
                                      width: 345,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F3F3),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: AlbumListItem(
                                        album: state.albums[index],
                                        onTap:
                                            () => context.go(
                                              '/album/${state.albums[index].id}',
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
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
    final TextEditingController controller = TextEditingController();
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontFamily: 'SF Pro Text',
          fontSize: 16,
          letterSpacing: -0.4,
          height: 1.0,
          color: Color(0xFF000000),
        ),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 16,
            letterSpacing: -0.4,
            height: 1.0,
            color: Color(0xFF000000),
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 4.0),
            child: Icon(Icons.search, color: Color(0xFF000000), size: 20),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.clear();
              context.read<SearchBloc>().search('');
            },
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFB3B3B3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          isDense: true,
        ),
        onChanged: (value) {
          context.read<SearchBloc>().search(value);
        },
      ),
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    artist.thumbnailUrl != null
                        ? DecorationImage(
                          image: NetworkImage(artist.thumbnailUrl!),
                          fit: BoxFit.cover,
                        )
                        : null,
                color: Colors.grey[300],
              ),
              child:
                  artist.thumbnailUrl == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                artist.name,
                style: const TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF000000),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumListItem extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;

  const AlbumListItem({Key? key, required this.album, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image:
                    album.thumbnailUrl != null
                        ? DecorationImage(
                          image: NetworkImage(album.thumbnailUrl!),
                          fit: BoxFit.cover,
                        )
                        : null,
                color: Colors.grey[300],
              ),
              child:
                  album.thumbnailUrl == null
                      ? const Icon(Icons.album, color: Colors.white)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.name,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    album.artist,
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 14,
                      letterSpacing: -0.4,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF000000),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
