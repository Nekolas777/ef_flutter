import 'package:ef_mynasa/features/planetary/domain/model/favorite_space.dart';
import 'package:ef_mynasa/shared/service/app_database.dart';

class SpaceRepository {

  final AppDatabase dbHelper = AppDatabase();

  Future<void> addFavoriteSpace(FavoriteSpace favoriteSpace) async {
    final db = await dbHelper.openDb();
    await db.insert(dbHelper.spacesTableName, favoriteSpace.toJson());
  }

  Future<List<FavoriteSpace>> getFavoriteSpaces() async {
    final db = await dbHelper.openDb();
    final spaces = await db.query(dbHelper.spacesTableName);
    return spaces.map((json) => FavoriteSpace.fromJson(json)).toList();
  }

  Future<int> deleteFavoriteSpace(String id) async {
    final db = await dbHelper.openDb();
    int spaceId = await db.delete(
      dbHelper.spacesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return spaceId;
  }

  Future<void> deleteAllFavoriteSpaces() async {
    final db = await dbHelper.openDb();
    await db.delete(dbHelper.spacesTableName);
  }

}