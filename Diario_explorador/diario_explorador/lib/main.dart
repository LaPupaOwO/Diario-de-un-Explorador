import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/diario_provider.dart';
import 'screens/home_screen.dart';

// En el main se usa ChangeNotifierProvider, para que todas las pantallas puedan acceder al estado global de la aplicación (modo oscuro, nombre del usuario y total de viajes)
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DiarioProvider(),
      child: const MyApp(),
    ),
  );
}

// Widget principal que arranca la aplicación mostrando la Pantalla 1 (HomeScreen)
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
