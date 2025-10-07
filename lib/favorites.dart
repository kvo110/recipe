import 'package:flutter/material.dart';
import 'home.dart';
import 'details.dart';

class Favorites extends StatelessWidget {
  final List<Recipe> favorites;

  const Favorites({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes')),
      body: favorites.isEmpty
          ? Center(child: Text('No favorite recipes yet!'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];
                return ListTile(
                  title: Text(recipe.name),
                  trailing: Icon(Icons.favorite, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            ),
      // Bottom bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              tooltip: 'Go Home',
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}