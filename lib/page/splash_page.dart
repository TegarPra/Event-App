import 'package:flutter/material.dart';
import 'package:event/page/welcome_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo Image
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'assets/images/splashlogo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
