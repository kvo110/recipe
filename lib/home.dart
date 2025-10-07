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
      name: 'Double-Fried Chicken Wings',
      ingredients: '''
- 2 lbs (about 1 kg) chicken wings
- 1 teaspoon salt
- ½ teaspoon black pepper
- 1 tablespoon garlic powder
- 1 tablespoon soy sauce
- 1 tablespoon rice wine (or white wine)
- ½ cup cornstarch (or potato starch)
- Oil for deep frying

For the Sauce (optional):
- 2 tablespoons soy sauce
- 2 tablespoons honey
- 1 tablespoon brown sugar
- 1 tablespoon gochujang (Korean chili paste) or sriracha
- 2 cloves garlic (minced)
- 1 teaspoon sesame oil
- 1 teaspoon rice vinegar
''',
      instructions: '''
1. Wash and pat dry the wings.
2. Marinate with salt, pepper, garlic powder, soy sauce, and rice wine for 20–30 min.
3. Coat wings evenly in cornstarch.
4. First fry at 325°F (160°C) for 7–8 minutes until lightly golden.
5. Let rest for 5–10 minutes.
6. Second fry at 375°F (190°C) for 2–3 minutes until crispy.
7. Make sauce by simmering soy sauce, honey, brown sugar, gochujang, garlic, sesame oil, and vinegar for 3–5 minutes.
8. Toss wings in sauce or serve with it on the side.
9. Garnish with sesame seeds or green onions.
'''
    ),
    Recipe(
      name: 'Garlic Butter Salmon',
      ingredients: '''
- 2 salmon fillets (about 6 oz each)
- Salt and pepper to taste
- 2 tablespoons olive oil
- 3 tablespoons unsalted butter
- 3 cloves garlic (minced)
- 1 tablespoon lemon juice
- 1 tablespoon chopped parsley
- Lemon slices (for garnish)
''',
      instructions: '''
1. Pat salmon dry with paper towels and season both sides with salt and pepper.
2. Heat olive oil in a skillet over medium-high heat.
3. Place salmon fillets skin-side down and sear for 4–5 minutes.
4. Flip salmon and add butter, garlic, and lemon juice to the pan.
5. Spoon the melted garlic butter over the salmon as it finishes cooking for another 2–3 minutes.
6. Garnish with fresh parsley and lemon slices before serving.
'''
    ),
    Recipe(
      name: 'Garlic Butter Steak',
      ingredients: '''
- 2 ribeye or sirloin steaks
- Salt and black pepper to taste
- 2 tablespoons olive oil
- 3 tablespoons unsalted butter
- 4 cloves garlic (crushed)
- 2 sprigs fresh rosemary or thyme
''',
      instructions: '''
1. Bring steaks to room temperature and pat dry.
2. Season generously with salt and pepper on both sides.
3. Heat olive oil in a skillet over high heat until shimmering.
4. Sear steaks for 3–4 minutes on each side for medium-rare (adjust for doneness).
5. Add butter, garlic, and herbs to the pan during the last minute of cooking.
6. Spoon the melted garlic butter over the steaks as they finish.
7. Let rest for 5 minutes before slicing and serving.
'''
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