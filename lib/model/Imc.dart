class Imc {
  final double _peso;
  final double _altura;
  
  Imc({required this._altura, required this._peso});

  double get peso => _peso;
  double get altura => _altura;

  double calcularImc() {
    return _peso / (_altura * _altura);
  }
}