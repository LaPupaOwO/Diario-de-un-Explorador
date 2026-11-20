import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/diario_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DiarioProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diario de un Explorador',
      home: const HomeScreen(),
    );
  }
}
