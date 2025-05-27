import 'package:flutter/material.dart';
import 'package:central_javreseps/components/food_card.dart';
import 'package:central_javreseps/components/detail_food.dart' as detail;
import 'package:central_javreseps/data/food_data.dart'; // pastikan file ini ada

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter makanan berdasarkan query pencarian
   final filteredFoods = foodData.where((food) {
  final name = food['name'].toString().toLowerCase();
  return name.contains(searchQuery.toLowerCase());
}).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Title
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search your meal",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              searchController.clear();
                            });
                          },
                        )
                      : null,
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            // Horizontal scrollable cards (Placeholder)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Card(
                      child: SizedBox(
                        width: 400,
                        height: 250,
                        child: Center(child: Text("Resep A")),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: 400,
                        height: 250,
                        child: Center(child: Text("Resep B")),
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        width: 400,
                        height: 250,
                        child: Center(child: Text("Resep C")),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List makanan hasil pencarian
            Expanded(
              child: ListView.builder(
                itemCount: filteredFoods.length,
                itemBuilder: (context, index) {
                  final food = filteredFoods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detail.FoodDetailPage(
                            name: food['name'],
                            city: food['city'],
                            difficulty: food['difficulty'],
                            rating: food['rating'],
                            cookTime: food['cookTime'],
                            ingredients: List<String>.from(food['ingredients']),
                            about: food['about'],
                          ),
                        ),
                      );
                    },
                    child: FoodCard(
                      name: food['name'],
                      city: food['city'],
                      difficulty: food['difficulty'],
                      rating: food['rating'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
