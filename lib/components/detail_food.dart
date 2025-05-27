import 'package:flutter/material.dart';
// import 'package:central_javreseps/models/food.dart';

class FoodDetailPage extends StatefulWidget {
  final String name;
  final String city;
  final String difficulty;
  final String rating;
  final String cookTime;
  final List<String> ingredients;
  final String about;

  const FoodDetailPage({
    super.key,
    required this.name,
    required this.city,
    required this.difficulty,
    required this.rating,
    required this.cookTime,
    required this.ingredients,
    required this.about,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool isFavorite = false;
  bool showIngredients = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar & tombol favorit
              Stack(
                children: [
                  const Placeholder(fallbackHeight: 200), // Ganti dengan gambar
                  Positioned(
                    top: 8,
                    left: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: BackButton(color: Colors.deepOrange),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isFavorite
                                ? 'Ditambahkan ke watchlist'
                                : 'Dihapus dari watchlist'),
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.difficulty, style: const TextStyle(color: Colors.deepOrange)),
              const SizedBox(height: 5),
              Text(widget.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Cook Time", style: TextStyle(color: Colors.grey)),
              Text(widget.cookTime,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Tab tombol Ingredients / About
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showIngredients = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: showIngredients ? Colors.deepOrange[100] : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepOrange),
                        ),
                        child: Center(
                          child: Text(
                            "Ingredients",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: showIngredients ? Colors.deepOrange : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showIngredients = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !showIngredients ? Colors.deepOrange[100] : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepOrange),
                        ),
                        child: Center(
                          child: Text(
                            "About",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !showIngredients ? Colors.deepOrange : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Konten Ingredients atau About
              Expanded(
                child: SingleChildScrollView(
                  child: showIngredients
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.ingredients
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text("• $item"),
                                  ))
                              .toList(),
                        )
                      : Text(widget.about),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}