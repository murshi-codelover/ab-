import 'package:flutter/material.dart';

import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
        const Duration(seconds: 3), () {}); // Delay to show the splash screen
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
          builder: (context) =>
              const Homescreen()), // Replace with your HomeScreen widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/abmlogo.jpg'),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'A B M',
        //       style: GoogleFonts.abel(fontSize: 40),
        //     ),

        //     Lottie.asset(
        //       'assets/abmlogo.jpg',
        //       width: 200,
        //       height: 200,
        //       fit: BoxFit.fill,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
