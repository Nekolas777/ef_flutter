import 'package:ef_mynasa/config/theme/app_theme.dart';
import 'package:ef_mynasa/features/planetary/data/local/space_repository.dart';
import 'package:ef_mynasa/features/planetary/data/remote/space_service.dart';
import 'package:ef_mynasa/features/presentation/providers/space_provider.dart';
import 'package:ef_mynasa/features/presentation/screens/favorites_spaces_screen.dart';
import 'package:ef_mynasa/features/presentation/screens/spaces_screen.dart';
import 'package:ef_mynasa/shared/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => SpaceProvider(
            spaceService: SpaceService(),
            spaceRepository: SpaceRepository(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'My Nasa App',
        theme: MainTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/spaces-screen': (context) => const SpacesScreen(),
          '/favorites': (context) => const FavoriteSpacesScreen(),
        },
      ),
    );
  }
}
