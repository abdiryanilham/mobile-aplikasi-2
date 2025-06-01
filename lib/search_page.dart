import 'dart:async';
import 'package:flutter/material.dart';
import 'package:central_javreseps/components/food_card.dart';
import 'package:central_javreseps/components/detail_food.dart' as detail;
import 'package:central_javreseps/models/food_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

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
    final filteredFoods = foodData.where((food) {
      final name = food['name']?.toString().toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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

            /// 🔁 Banner Auto Slider
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

            const SizedBox(height: 16),

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
            ),
          ],
        ),
      ),
    );
  }
}
