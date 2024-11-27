import 'package:ef_mynasa/features/planetary/data/local/space_repository.dart';
import 'package:ef_mynasa/features/planetary/data/remote/space_service.dart';
import 'package:ef_mynasa/features/planetary/domain/model/favorite_space.dart';
import 'package:ef_mynasa/features/planetary/domain/model/space.dart';
import 'package:flutter/cupertino.dart';

class SpaceProvider extends ChangeNotifier {
  final SpaceService spaceService;
  final SpaceRepository spaceRepository;

  SpaceProvider({
    required this.spaceService,
    required this.spaceRepository,
  });

  List<Space> spaces = [];
  List<FavoriteSpace> favoriteSpaces = [];

  bool isLoading = false;

  Future<void> loadSpacesInformation() async {
    isLoading = true;

    try {
      final List<Space> spacesList = await spaceService.getAllSpaces();
      final favoriteSpaces = await spaceRepository.getFavoriteSpaces();

      final favoriteSpacesIds = favoriteSpaces.map((space) => space.id).toList();

      for (var space in spacesList) {
        space.isFavorite = favoriteSpacesIds.contains(space.id);
      }

      spaces = spacesList;
    } catch (e) {
      throw Exception('Failed to load spaces information');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavoriteSpaces() async {
    isLoading = true;

    try {
      favoriteSpaces = await spaceRepository.getFavoriteSpaces();
    } catch (e) {
      throw Exception('Failed to load favorite spaces');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavoriteSpace(FavoriteSpace favoriteSpace) async {
    isLoading = true;

    try {
      await spaceRepository.addFavoriteSpace(favoriteSpace);
    } catch (e) {
      throw Exception('Failed to add favorite space');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> deleteFavoriteSpace(String id) async {
    isLoading = true;

    try {
      final deleteCatId = await spaceRepository.deleteFavoriteSpace(id);
      favoriteSpaces.removeWhere((space) => space.id == id);

      return deleteCatId;
    } catch (e) {
      throw Exception('Failed to delete favorite space');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}