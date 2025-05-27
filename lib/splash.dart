// import 'package:central_javreseps/home_page.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/main');
    });

    return Scaffold(
      backgroundColor: Color(0xffFF6E41),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/img/Frame 284 (1).png'))
              ),
            ),
            SizedBox(height: 15,),
            
          ],
        ),
      ),
    );
  }
}