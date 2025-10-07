import 'package:flutter/material.dart';
import 'details.dart';
import 'favorites.dart';

class Recipe {
  final String name;
  final String ingredients;
  final String instructions;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}

class Home extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const Home({required this.onToggleTheme, required this.isDarkMode});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recipe> recipes = [
    Recipe(
      name: '',
      ingredients: '',
      instructions:
          '',
    ),
    Recipe(
      name: '',
      ingredients: '',
      instructions:
          '',
    ),
    Recipe(
      name: '',
      ingredients: '',
      instructions:
          '',
    ),
  ];

  void toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Home - stay here
    } else if (index == 1) {
      final favoriteRecipes =
          recipes.where((recipe) => recipe.isFavorite).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Favorites(favorites: favoriteRecipes),
        ),
      );
    } else if (index == 2) {
      widget.onToggleTheme();
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.name),
            trailing: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? Colors.red : null,
            ),
            onTap: () async {
              final updatedRecipe = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(recipe: recipe),
                ),
              );

              if (updatedRecipe != null) {
                setState(() {
                  recipes[index] = updatedRecipe;
                });
              }
            },
          );
        },
      ),
      // Navigation bar at the bottom 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            label: widget.isDarkMode ? 'Light' : 'Dark',
          ),
        ],
      ),
    );
  }
}