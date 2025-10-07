import 'package:flutter/material.dart';
import 'home.dart';

class Details extends StatefulWidget {
  final Recipe recipe;

  const Details({required this.recipe});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipe.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.recipe.ingredients, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.recipe.instructions, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  toggleFavorite();
                  Navigator.pop(
                    context,
                    Recipe(
                      name: widget.recipe.name,
                      ingredients: widget.recipe.ingredients,
                      instructions: widget.recipe.instructions,
                      isFavorite: isFavorite,
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                label:
                    Text(isFavorite ? 'Unmark as Favorite' : 'Mark as Favorite'),
              ),
            ),
            SizedBox(height: 20), // extra spacing at the bottom
          ],
        ),
      ),
      // Bottom navigation bar
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