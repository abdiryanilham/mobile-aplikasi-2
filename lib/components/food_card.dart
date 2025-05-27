import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String city;
  final String difficulty;
  final String rating;

  const FoodCard({
    super.key,
    required this.name,
    required this.city,
    required this.difficulty,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 90, // sekitar 3cm di layar
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
            child: const Icon(Icons.fastfood, color: Colors.white),
          ),
          const SizedBox(width: 10),
          
          Expanded(
            child: ListTile(
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('$city • $difficulty'),
              trailing: Text('$rating⭐'),
            ),
          ),
        ],
      ),
    );
  }
}
