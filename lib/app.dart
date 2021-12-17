import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'XO-Game',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
