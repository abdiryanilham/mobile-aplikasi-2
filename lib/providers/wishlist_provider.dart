import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _wishlist = [];

  List<Map<String, dynamic>> get wishlist => _wishlist;

  void addToWishlist(Map<String, dynamic> food) {
    if (!_wishlist.contains(food)) {
      _wishlist.add(food);
      notifyListeners(); // Memberitahu widget yang berlangganan
    }
  }

  void removeFromWishlist(Map<String, dynamic> food) {
  _wishlist.removeWhere((item) => item['name'] == food['name']);
  notifyListeners();
}


  bool isInWishlist(Map<String, dynamic> food) {
  return _wishlist.any((item) => item['name'] == food['name']);
}

}
