import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String city;
  final String difficulty;
  final String rating;
  final String image;

  const FoodCard({
    super.key,
    required this.name,
    required this.city,
    required this.difficulty,
    required this.rating,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Color(0xffF5F5F5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            child : Image.asset(
                    image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white,
                      width: 90,
                      height: 90, 
                    ),
                  ),
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
