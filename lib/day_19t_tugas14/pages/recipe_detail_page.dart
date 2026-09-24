
import 'package:flutter/material.dart';
import '../model/recipe_model.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Makanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                recipe.image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Row(
              children: [
                Icon(Icons.restaurant),
                SizedBox(width: 8),
                Text(
                  'Makanan Indonesia',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Row(
              children: [
                Icon(Icons.menu_book),
                SizedBox(width: 8),
                Text(
                  'Resep Nusantara',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Tentang Makanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              ' ${recipe.name} merupakan salah satu '
              'makanan yang dikenal dalam kuliner '
              'Indonesia.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}