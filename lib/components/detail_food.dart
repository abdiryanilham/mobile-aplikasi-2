import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../providers/wishlist_provider.dart';

class FoodDetailPage extends StatefulWidget {
  final String name;
  final String city;
  final String difficulty;
  final String rating;
  final String cookTime;
  final List<String> ingredients;
  final String about;
  final String videoId;
  final String image;

  const FoodDetailPage({
    super.key,
    required this.name,
    required this.city,
    required this.difficulty,
    required this.rating,
    required this.cookTime,
    required this.ingredients,
    required this.about,
    required this.videoId,
    required this.image,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool showIngredients = true;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

   _controller = YoutubePlayerController.fromVideoId(
  videoId: widget.videoId,
  params: const YoutubePlayerParams(
    // showControls: true,            // Tampilkan kontrol
    // showFullscreenButton: true,    // Tampilkan tombol layar penuh
    // loop: false,                   // Tidak mengulang video secara otomatis
    mute: false,                   // Video tidak dimatikan suaranya
  ),
);


  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Map<String, dynamic> food = {
      'name': widget.name,
      'city': widget.city,
      'difficulty': widget.difficulty,
      'rating': widget.rating,
      'cookTime': widget.cookTime,
      'ingredients': widget.ingredients,
      'about': widget.about,
      'image': widget.image,
      'videoId': widget.videoId,
    };

    final isFavorite = wishlistProvider.isInWishlist(food);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                   Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100,)),
                      width: MediaQuery.of(context).size.width,
                      height: 400, // full width
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80.0), // Padding top 16
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: YoutubePlayer(
                            controller: _controller,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    top: 8,
                    left: 8,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffFFCCBA),
                      child: BackButton(color: Colors.deepOrange),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          wishlistProvider.removeFromWishlist(food);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Dihapus dari watchlist'),
                            ),
                          );
                        } else {
                          wishlistProvider.addToWishlist(food);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ditambahkan ke watchlist'),
                            ),
                          );
                        }
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
              Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("Cook Time", style: TextStyle(color: Colors.grey)),
              Text(widget.cookTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),


              

              /// TAB INGREDIENTS / ABOUT
              /// TAB INGREDIENTS / ABOUT
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => showIngredients = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                          color: showIngredients ? Colors.deepOrange[100] : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Ingredients",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
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
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                          color: !showIngredients ? Colors.deepOrange[100] : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "About",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // jangan terlalu tinggi

              /// CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: showIngredients
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.ingredients
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "• $item",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ))
                              .toList(),
                        )
                      : Text(
                          widget.about,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
