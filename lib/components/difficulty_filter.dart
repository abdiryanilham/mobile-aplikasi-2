import 'package:flutter/material.dart';

class DifficultyFilter extends StatelessWidget {
  final String selected;
  final Function(String) onSelected;

  const DifficultyFilter({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['Easy', 'Medium', 'Hard'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((option) {
        final isSelected = selected == option;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepOrange[100] : Colors.white,
              borderRadius: BorderRadius.circular(20),
             
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.deepOrange[400] : Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
