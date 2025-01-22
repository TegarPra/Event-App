import 'package:event/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event/api/favorite_manager.dart';
import 'package:event/page/detail_page.dart';
import 'package:event/page/favorite_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  SplashPage(),
    );
  }
}
