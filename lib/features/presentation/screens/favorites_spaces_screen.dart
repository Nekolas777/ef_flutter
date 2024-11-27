import 'package:ef_mynasa/config/theme/app_theme.dart';
import 'package:ef_mynasa/features/presentation/providers/space_provider.dart';
import 'package:ef_mynasa/features/presentation/widgets/favorite_space_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteSpacesScreen extends StatefulWidget {
  const FavoriteSpacesScreen({super.key});

  @override
  State<FavoriteSpacesScreen> createState() => _FavoriteSpacesScreenState();
}

class _FavoriteSpacesScreenState extends State<FavoriteSpacesScreen> {

  @override
  void initState() {
    super.initState();
    _loadFavoriteSpaces();
  }

  Future<void> _loadFavoriteSpaces() async {
    final spacesProvider = context.read<SpaceProvider>();
    await spacesProvider.loadFavoriteSpaces();
  }

  Future<void> _deleteFavoriteSpace(String id) async {
    final spacesProvider = context.read<SpaceProvider>();
    await spacesProvider.deleteFavoriteSpace(id);
  }

  @override
  Widget build(BuildContext context) {
    final spacesProvider = Provider.of<SpaceProvider>(context, listen: true);
    final spaces = spacesProvider.favoriteSpaces;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Spaces',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 70.0,
        backgroundColor: CustomColors.darkBlue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: spaces.length,
        itemBuilder: (context, index) {
          final space = spaces[index];
          return FavoriteSpaceCard(
            id: space.id,
            title: space.title,
            explanation: space.explanation,
            url: space.url,
            onDeleteFavoritePressed: () => _deleteFavoriteSpace(space.id),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }
}
