import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home_page.dart';
import '../search_page.dart';
import '../watchlist_page.dart';


class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});
  void _onTap(int index, BuildContext context) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {  
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WatchlistPage()),
      );
    // Bisa tambahkan navigasi ke halaman favorite kalau diperlukan
  }

}
  
 @override
  Widget build(BuildContext context) {
    
    return Container(
      //  color: Colors.white,// Warna latar belakang
        child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),// Padding top
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          iconSize: 30,
          
          
          onTap: (index) => _onTap(index, context),
          items: [
            
            BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/Search.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? Colors.deepOrange : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: ' ',
          ),

            BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/Home.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? Colors.deepOrange : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: ' ',
          ),

            BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icon/Heart.svg',
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? Colors.deepOrange : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: ' ',
          ),
          ],
        ),
      ),
    );
  }
}