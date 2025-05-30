import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'watchlist_page.dart';
import 'splash.dart';
import 'providers/wishlist_provider.dart'; // Impor WishlistProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Central Javreseps',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1; // Home page default aktif

  final List<Widget> _pages = [
    const SearchPage(),
    const HomePage(),
    const WatchlistPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Helper method untuk menampilkan icon SVG dengan warna sesuai status aktif/tidak
  Widget _buildSvgIcon(String assetName, int index) {
    return SvgPicture.asset(
      assetName,
      width: 40,
      height: 40,
      color: _currentIndex == index ? Colors.deepOrange : Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/icon/Search.svg', 0),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/icon/Home.svg', 1),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon('assets/icon/Heart.svg', 2),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }
}
