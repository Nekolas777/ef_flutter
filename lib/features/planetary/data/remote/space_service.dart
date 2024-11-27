import 'package:dio/dio.dart';
import 'package:ef_mynasa/config/constant/environment.dart';
import 'package:ef_mynasa/features/planetary/domain/model/space.dart';

class SpaceService {
  final Dio dio = Dio();

  Future<List<Space>> getAllSpaces() async {
    try {
      final response = await dio.get(
        'https://api.nasa.gov/planetary/apod?api_key=${Environment.API_KEY}&start_date=2017-07-08&end_date=2017-12-10',
      );

      final List<Space> spaces = (response.data as List)
          .asMap()
          .entries
          .map((entry) {
        final index = entry.key;
        final json = entry.value;
        return Space.fromJson(json)..id = index.toString();
      })
          .toList();

      print(spaces[0]);

      return spaces;
    } catch (e) {
      throw Exception('Failed to load spaces information');
    }
  }
}