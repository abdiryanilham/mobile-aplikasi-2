import 'dart:async';
import 'package:flutter/material.dart';
import 'package:central_javreseps/components/detail_food.dart' as detail;
import 'package:central_javreseps/components/food_card.dart';
import 'package:central_javreseps/components/difficulty_filter.dart';
import 'package:central_javreseps/models/food_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedDifficulty = 'Easy';
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Widget> banners = [
  Card(
    child: SizedBox(
      width: double.infinity,
      height: 400,
      child: Image.asset(
        'assets/icon/Frame 280.png',
        fit: BoxFit.cover,
      ),
    ),
  ),
  Card(
    child: SizedBox(
      width: double.infinity,
      height: 400,
      child: Image.asset(
        'assets/icon/Frame 281.png',
        fit: BoxFit.cover,
      ),
    ),
  ),
  Card(
    child: SizedBox(
      width: double.infinity,
      height: 400,
      child: Image.asset(
        'assets/icon/Rectangle 1 (1).png',
        fit: BoxFit.cover,
      ),
    ),
  ),
];



  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

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

            /// Auto Slider
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: banners[index],
                  );
                },
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
                          about: food['about'],
                          videoId: food['videoId'],
                          image: food['image'],
                        ),
                      ),
                    );
                  },
                  child: FoodCard(
                    name: food['name'],
                    city: food['city'],
                    difficulty: food['difficulty'],
                    rating: food['rating'],
                    image: food['image'],
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
