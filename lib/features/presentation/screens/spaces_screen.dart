import 'package:ef_mynasa/config/theme/app_theme.dart';
import 'package:ef_mynasa/features/planetary/domain/model/favorite_space.dart';
import 'package:ef_mynasa/features/presentation/providers/space_provider.dart';
import 'package:ef_mynasa/features/presentation/widgets/space_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  bool showLabel = true;

  @override
  void initState() {
    super.initState();
    _loadSpacesInformation();
    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;
      setState(() {
        showLabel = false;
      });
    });
  }

  Future<void> _loadSpacesInformation() async {
    final spacesProvider = context.read<SpaceProvider>();
    await spacesProvider.loadSpacesInformation();
  }

  void _addFavoriteSpace(
      String id, String title, String url, String explanation) {
    final favoriteSpace = FavoriteSpace(
      id: id,
      title: title,
      url: url,
      explanation: explanation,
    );

    final spacesProvider = context.read<SpaceProvider>();
    spacesProvider.addFavoriteSpace(favoriteSpace);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Space saved successfully with ID: $id'),
      ),
    );
  }

  void _removeFavoriteSpace(String id) {
    final spacesProvider = context.read<SpaceProvider>();
    spacesProvider.deleteFavoriteSpace(id);
  }

  @override
  Widget build(BuildContext context) {
    final spacesProvider = Provider.of<SpaceProvider>(context, listen: true);
    final spaces = spacesProvider.spaces;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      appBar: AppBar(
        title: const Text(
          'Spaces Detail',
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
      body: Stack(
        children: [
          spacesProvider.isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                        color: CustomColors.darkBlue,
                      ),
                    ),
                  ),
                )
              : PageView.builder(
                  itemCount: spaces.length,
                  itemBuilder: (context, index) {
                    final space = spaces[index];
                    final isFavoriteNotifier = ValueNotifier<bool>(space.isFavorite);
                    return SpaceDetailPage(
                      name: space.title,
                      imageUrl: space.url,
                      description: space.explanation,
                      date: space.date,
                      isFavorite: space.isFavorite,
                      onFavoritePressed: () => _addFavoriteSpace(
                        index.toString(),
                        space.title,
                        space.url,
                        space.explanation,
                      ),
                      onDeleteFavorite: () => _removeFavoriteSpace(
                        index.toString(),
                      ),
                    );
                  },
                ),
          if (showLabel)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: showLabel ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.swipe, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text(
                          'Swipe to see more spaces',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
