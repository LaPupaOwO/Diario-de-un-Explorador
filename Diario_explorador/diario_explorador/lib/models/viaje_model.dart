class ViajeModel {
  final String lugar;
  final String ciudad;
  final String resena;
  final int calificacion;
  final bool recomendado;
  final String? rutaFoto;
  final String? coordenadas;

  ViajeModel({
    required this.lugar,
    required this.ciudad,
    required this.resena,
    required this.calificacion,
    required this.recomendado,
    this.rutaFoto,
    this.coordenadas,
  });
}
