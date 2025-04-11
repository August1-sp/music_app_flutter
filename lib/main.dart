import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/api/audiodb_api.dart';
import 'package:music_app/blocs/album_favorites_bloc.dart';
import 'package:music_app/screens/album_screen.dart';
import 'package:music_app/screens/artist_screen.dart';
import 'package:music_app/screens/charts_screen.dart';
import 'package:music_app/screens/favorites_screen.dart';
import 'package:music_app/screens/search_screen.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/models/album_favorites.dart';

final dio = Dio();

final audioDbService = AudioDbService(dio);

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return RootPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/album/:id',
          builder: (context, state) => AlbumPage(
            albumId: state.pathParameters['id']!,
          ),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const ChartsPage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/artist/:id',
          builder: (context, state) => ArtistPage(
            artistId: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);

/*void main() {
  runApp(const MyApp());
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(FavoriteArtistAdapter());
  }
  
  final favoritesBox = await Hive.openBox<FavoriteArtist>('favorites');
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => FavoritesBloc(favoritesBox)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => audioDbService,
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Music App',
        theme: ThemeData(
          fontFamily: 'SF Pro',
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  final Widget child;
  
  const RootPage({
    super.key,
    required this.child,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/search')) {
      return 1;
    }
    if (location.startsWith('/favorites')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_sharp),
            label: 'Classements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_week_sharp),
            label: 'Favoris',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFF3F3F3),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}