import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../components/food_card.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context).wishlist;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: const Text('Watchlist',
         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
      ),
      
      body: wishlist.isEmpty
          ? const Center(
            
              child: Text(
                'Your watchlist is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final food = wishlist[index];
                return FoodCard(
                  name: food['name'],
                  city: food['city'],
                  difficulty: food['difficulty'],
                  rating: food['rating'],
                  image: food['image'],
                );
              },
            ),
    );
  }
}
