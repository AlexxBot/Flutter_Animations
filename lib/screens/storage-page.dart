import 'package:flutter/material.dart';
import '/models/puntos.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final List<Punto> centros = [];

  void onPanUpdate(BuildContext context, DragUpdateDetails details) {
    print('esta es la posicion global');
    print(details.globalPosition.dx.toString());
    print(details.globalPosition.dy.toString());
    print('esta es la posicion local');
    print(details.localPosition.dx.toString());
    print(details.localPosition.dy.toString());
    print('esta es el valor de delta');
    print(details.delta.dx);
    print(details.delta.dy);
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());

    setState(() {
      centros.add(Punto(x, y, indice: centros.length));
      print('esta es la cantidad de puntos que he almacenado ' +
          centros.length.toString());
    });
  }

  void _seleccionarRuma(int indice) {
    print('se tiene que rendidrizar el punto con indice =' + indice.toString());
    setState(() {
      if (centros[indice].elevation == 0) {
        centros[indice].elevation = 20;
      } else {
        centros[indice].elevation = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(children: [
        Container(
            color: Colors.amber,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width),
        ...centros
            .map((punto) => Positioned(
                left: punto.x,
                top: punto.y,
                child: GestureDetector(
                    onTap: () => _seleccionarRuma(punto.indice),
                    child: Material(
                        color: Colors.transparent,
                        elevation: punto.elevation,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              //border: BoxBorder.lerp(BoxBorder., 2, 2)
                              shape: BoxShape.circle,
                              //borderRadius: StadiumBorder(side: )
                            ),
                            height: 25,
                            width: 25)))))
            .toList(),
      ]),
      //onTap: () => print('hola se hizo un tap'),
      //onTapDown: (TapDownDetails details) => _onTapDown(details),
      onTapUp: (TapUpDetails details) => _onTapUp(details),
      //onPanUpdate: (details) => onPanUpdate(context, details),
    );
  }
}
