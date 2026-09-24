
import 'package:flutter/material.dart';
import '../model/recipe_model.dart';
import '../services/recipe_service.dart';
import 'recipe_detail_page.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final RecipeService service = RecipeService();

  late Future<List<Recipe>> recipesFuture;

  String searchText = '';

  @override
  void initState() {
    super.initState();
    recipesFuture = service.fetchRecipes();
  }

  Future<void> refreshRecipes() async {
    setState(() {
      recipesFuture = service.fetchRecipes();
    });

    await recipesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep Makanan Indonesia'),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Recipe>>(
        future: recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Text(
                    'Gagal mengambil data',
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        recipesFuture =
                            service.fetchRecipes();
                      });
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Data makanan tidak tersedia',
              ),
            );
          }

          final recipes = snapshot.data!;

          final filteredRecipes = recipes.where((recipe) {
            return recipe.name
                .toLowerCase()
                .contains(searchText.toLowerCase());
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari makanan Indonesia...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshRecipes,
                  child: filteredRecipes.isEmpty
                      ? ListView(
                          physics:
                              const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(
                              child: Text(
                                'Makanan tidak ditemukan',
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics:
                              const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          itemCount: filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe =
                                filteredRecipes[index];

                            return Card(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              elevation: 3,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return RecipeDetailPage(
                                          recipe: recipe,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: Image.network(
                                          recipe.image,
                                          width: 110,
                                          height: 110,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe.name,
                                              style:
                                                  const TextStyle(
                                                fontSize: 17,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 10),

                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.restaurant,
                                                  size: 18,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Makanan Indonesia',
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),

                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.menu_book,
                                                  size: 18,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Resep Nusantara',
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),

                                            const Text(
                                              'Klik untuk detail',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}