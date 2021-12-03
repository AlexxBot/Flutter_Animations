import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/expansionTile_widget.dart';

class ExpansionTilePage extends StatefulWidget {
  const ExpansionTilePage({Key? key}) : super(key: key);

  @override
  _ExpansionTilePageState createState() => _ExpansionTilePageState();
}

class _ExpansionTilePageState extends State<ExpansionTilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ExpansionTileWidget(
              callback: () => print('callback'),
              trailing:
                  RawMaterialButton(child: Text("boton"), onPressed: null),
              title: Text("Hola"),
              children: [Text("hijo1"), Text("hijo 2")])),
    );
  }
}
