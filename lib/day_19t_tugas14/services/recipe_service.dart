
import 'package:dio/dio.dart';
import '../model/recipe_model.dart';

class RecipeService {
  final Dio dio = Dio();

  Future<List<Recipe>> fetchRecipes() async {
    final response = await dio.get(
      'https://dummyjson.com/recipes?limit=30',
    );

    final List meals = response.data['recipes'];

    return meals.map((json) {
      return Recipe(
        id: json['id'].toString(),
        name: json['name'],
        image: json['image'],
      );
    }).toList();
  }
}