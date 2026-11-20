import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/viaje_model.dart';

// En esta clase se usa Provider (ChangeNotifier) para manejar el estado global
// y compartir los datos entre las 3 pantallas de la aplicación, además de guardar y leer datos en SharedPreferences
class DiarioProvider extends ChangeNotifier {
  static const String _claveModoOscuro = 'modo_oscuro';
  static const String _claveNombre = 'nombre_usuario';
  static const String _claveTotalViajes = 'total_viajes';

  bool _esModoOscuro = false;
  String _nombreUsuario = 'Explorador';
  int _totalViajes = 0;

  // Colección (List) que guarda en memoria todos los viajes que se van registrando
  // para poder mostrarlos después en el ListView de la Pantalla 1
  List<ViajeModel> _viajes = [];

  bool get esModoOscuro => _esModoOscuro;
  String get nombreUsuario => _nombreUsuario;
  int get totalViajes => _totalViajes;
  List<ViajeModel> get viajes => _viajes;

  // Constructor: al abrir la app manda a leer lo que está guardado en SharedPreferences
  DiarioProvider() {
    _cargarPreferencias();
  }

  // En esta función se usa SharedPreferences para leer los datos guardados al iniciar la app
  Future<void> _cargarPreferencias() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Leer modo oscuro guardado
      bool? temaGuardado = prefs.getBool(_claveModoOscuro);
      if (temaGuardado != null) {
        _esModoOscuro = temaGuardado;
      } else {
        _esModoOscuro = false;
      }

      // Leer nombre de usuario guardado
      String? nombreGuardado = prefs.getString(_claveNombre);
      if (nombreGuardado != null) {
        _nombreUsuario = nombreGuardado;
      } else {
        _nombreUsuario = 'Explorador';
      }

      // Leer total de viajes guardados
      int? totalGuardado = prefs.getInt(_claveTotalViajes);
      if (totalGuardado != null) {
        _totalViajes = totalGuardado;
      } else {
        _totalViajes = 0;
      }

      // Se usa notifyListeners() de Provider para avisar a las pantallas que ya cargaron los datos
      notifyListeners();
    } catch (e) {
      debugPrint('Error al cargar preferencias: $e');
    }
  }

  // En esta función se usa SharedPreferences para guardar el modo oscuro en el dispositivo
  Future<void> _guardarTema() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_claveModoOscuro, _esModoOscuro);
    } catch (e) {
      debugPrint('Error al guardar tema: $e');
    }
  }

  // En esta función se usa SharedPreferences para guardar el nombre del usuario en el dispositivo
  Future<void> _guardarNombre() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_claveNombre, _nombreUsuario);
    } catch (e) {
      debugPrint('Error al guardar nombre: $e');
    }
  }

  // En esta función se usa SharedPreferences para guardar el contador de viajes en el dispositivo
  Future<void> _guardarTotalViajes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_claveTotalViajes, _totalViajes);
    } catch (e) {
      debugPrint('Error al guardar total de viajes: $e');
    }
  }

  // Función de Provider para cambiar entre tema claro y oscuro y guardarlo en SharedPreferences
  void cambiarTema() {
    _esModoOscuro = !_esModoOscuro;
    notifyListeners();
    _guardarTema();
  }

  // Función de Provider para actualizar el nombre de usuario y guardarlo en SharedPreferences
  void guardarNombre(String nuevoNombre) {
    _nombreUsuario = nuevoNombre;
    notifyListeners();
    _guardarNombre();
  }

  // Función de Provider para agregar un viaje nuevo a la lista, sumar el contador
  // y avisar a todas las pantallas con notifyListeners()
  void agregarViaje(ViajeModel viaje) {
    _viajes.add(viaje);
    _totalViajes++;
    notifyListeners();
    _guardarTotalViajes();
  }
}
