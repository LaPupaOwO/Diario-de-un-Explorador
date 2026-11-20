import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/diario_provider.dart';
import 'capture_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diarioProvider = context.watch<DiarioProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba Temporal'),
        actions: [
          IconButton(
            icon: Icon(
              diarioProvider.esModoOscuro ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<DiarioProvider>().cambiarTema();
            },
            tooltip: 'Cambiar Tema',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario: ${diarioProvider.nombreUsuario}'),
            Text('Viajes guardados: ${diarioProvider.totalViajes}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CaptureScreen(),
                  ),
                );
              },
              child: const Text('Ir a Pantalla 3 (CaptureScreen)'),
            ),
          ],
        ),
      ),
    );
  }
}
