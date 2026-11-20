import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/viaje_model.dart';
import '../providers/diario_provider.dart';

// Pantalla 3: Recibe los datos enviados desde la Pantalla 2 mediante navegación (MaterialPageRoute)
// y muestra el resumen junto con los espacios visuales para el clima, foto y GPS.
class CaptureScreen extends StatelessWidget {
  // Variables que reciben los datos enviados desde el formulario de la Pantalla 2
  final String lugar;
  final String ciudad;
  final String resena;
  final int calificacion;
  final bool recomendado;

  const CaptureScreen({
    super.key,
    this.lugar = 'Restaurante Ichiran',
    this.ciudad = 'Tokio',
    this.resena = 'Excelente experiencia y comida deliciosa.',
    this.calificacion = 9,
    this.recomendado = true,
  });

  @override
  Widget build(BuildContext context) {
    // En esta pantalla se usa context.watch de Provider para escuchar el modo oscuro
    // que fue guardado en SharedPreferences y actualizar los colores automáticamente
    final diarioProvider = context.watch<DiarioProvider>();
    final esOscuro = diarioProvider.esModoOscuro;

    final colorFondo = esOscuro ? Colors.grey[900] : Colors.white;
    final colorTarjeta = esOscuro ? Colors.grey[800] : Colors.teal[50];
    final colorTexto = esOscuro ? Colors.white : Colors.black;

    // Define el texto y color dependiendo de si el usuario marcó el lugar como recomendado o no
    String textoRecomendado = '';
    Color colorRecomendado = Colors.black;

    if (recomendado == true) {
      textoRecomendado = 'Recomendado';
      colorRecomendado = Colors.green;
    } else {
      textoRecomendado = 'No recomendado';
      colorRecomendado = Colors.red;
    }
    // En este widget Scaffold se usan widgets básicos (AppBar, SingleChildScrollView, Column, Card, Padding, Row, Icon, Text y ElevatedButton) para mostrar los datos recibidos desde la Pantalla 2 y los espacios reservados para la fotografía y el GPS
    return Scaffold(
      backgroundColor: colorFondo,
      appBar: AppBar(
        title: const Text('Evidencia y Clima'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        // En este widget se usa Provider y SharedPreferences para cambiar y guardar
        // el modo oscuro desde el icono de sol y luna en la barra superior
        actions: [
          IconButton(
            icon: Icon(esOscuro ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              context.read<DiarioProvider>().cambiarTema();
            },
            tooltip: 'Cambiar Tema',
          ),
        ],
      ),
      // Se usa SingleChildScrollView para permitir deslizar la pantalla y evitar errores de desbordamiento
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En esta tarjeta se muestran los datos del viaje recibido desde la Pantalla 2, como lugar, ciudad, reseña, calificación y si fue recomendado o no
            Card(
              color: colorTarjeta,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.teal),
                        const SizedBox(width: 8),
                        Text(
                          lugar,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colorTexto,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ciudad: $ciudad',
                      style: TextStyle(fontSize: 16, color: colorTexto),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reseña: $resena',
                      style: TextStyle(fontSize: 15, color: colorTexto),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Calificación: $calificacion / 10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorTexto,
                          ),
                        ),
                        // Aquí se muestra el texto y color definidos con el if / else de arriba
                        Text(
                          textoRecomendado,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorRecomendado,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // En esta tarjeta se muestran los datos del clima actual
            Card(
              color: colorTarjeta,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clima Actual en $ciudad',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorTexto,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pendiente de conectar API',
                          style: TextStyle(color: colorTexto),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Widget Container con diseño, bordes y padding que se usará para mostrar la fotografía del lugar y las coordenadas GPS
            Container(
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorTarjeta,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt, size: 50, color: Colors.teal),
                  const SizedBox(height: 10),
                  Text(
                    'Espacio para fotografía del lugar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorTexto,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Coordenadas GPS: Pendiente de captura',
                    style: TextStyle(color: colorTexto),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // En este botón se usa context.read de Provider para guardar el nuevo viaje
            // en el provider y actualizar la Pantalla 1 (HomeScreen) automáticamente, creando un nuevo objeto de la clase ViajeModel con los datos recibidos desde la Pantalla 2
            ElevatedButton.icon(
              onPressed: () {
                final nuevoViaje = ViajeModel(
                  lugar: lugar,
                  ciudad: ciudad,
                  resena: resena,
                  calificacion: calificacion,
                  recomendado: recomendado,
                );

                // Función agregarViaje del Provider para guardar y actualizar la Pantalla 1
                context.read<DiarioProvider>().agregarViaje(nuevoViaje);
                print('Viaje guardado en el diario');

                // Se usa Navigator.pop para cerrar la Pantalla 3 y la Pantalla 2 y regresar a la portada
                Navigator.pop(context);
                //Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Guardar en Diario'),
            ),

            const SizedBox(height: 12),

            // En este botón se usa Navigator.pop para volver únicamente a la Pantalla 2 (Formulario)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al formulario'),
            ),
          ],
        ),
      ),
    );
  }
}
