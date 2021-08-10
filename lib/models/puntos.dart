class Punto {
  final double x;
  final double y;
  int _indice = 0;
  double _elevation = 0.0;

  Punto(this.x, this.y, {int indice = 0, double elevation = 0}) {
    this._indice = indice;
    this._elevation = elevation;
  }

  int get indice => _indice;

  set indice(int pindice) {
    if (pindice >= 0) {
      _indice = pindice;
    }
  }

  double get elevation => _elevation;

  set elevation(double pelevation) {
    if (pelevation >= 0) {
      _elevation = pelevation;
    }
  }
}
