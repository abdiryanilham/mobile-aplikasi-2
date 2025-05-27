import 'package:flutter/material.dart';
import 'package:central_javreseps/components/detail_food.dart' as detail;
import 'package:central_javreseps/components/food_card.dart';
import 'package:central_javreseps/components/difficulty_filter.dart';
import 'package:central_javreseps/data/food_data.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedDifficulty = 'Easy';

  // final filteredFoods = foodData.where((food) => food['name'].toString().contains(query)).toList();


  @override
  Widget build(BuildContext context) {
    final filteredFoods = foodData
        .where((food) => food['difficulty'] == selectedDifficulty)
        .toList();

    return Scaffold(
        backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [ 
            const SizedBox(height: 30),
            const Padding(
              
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Daftar Resep",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
           

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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


            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DifficultyFilter(
                selected: selectedDifficulty,
                onSelected: (value) {
                  setState(() {
                    selectedDifficulty = value;
                  });
                },
              ),
            ),

            ListView.builder(
              itemCount: filteredFoods.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                          about: food['about'], // Menambahkan argumen about
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
          ],
        ),
      ),
    );
  }
}
