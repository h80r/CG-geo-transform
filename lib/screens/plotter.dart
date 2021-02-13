import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_plot/flutter_plot.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:geo_transform/operations/transformations.dart';

enum _geoTransform { translate, rotate, resize }

class Plotter extends StatefulWidget {
  @override
  _PlotterState createState() => _PlotterState();
}

class _PlotterState extends State<Plotter> {
  List<Point> originalShape;

  List<Point> currentShape;

  void loadOriginalShape() {
    originalShape ??= ModalRoute.of(context).settings.arguments;
    currentShape ??= originalShape;
  }

  void updateShape(_geoTransform operation, List values) {
    values = values.map((e) => num.parse(e)).toList();
    List<Point> newShape;

    switch (operation) {
      case _geoTransform.translate:
        newShape = currentShape.map((e) => e.translate(values)).toList();
        break;
      case _geoTransform.rotate:
        newShape = currentShape.map((e) => e.rotate(values)).toList();
        break;
      case _geoTransform.resize:
        newShape = currentShape.map((e) => e.resize(values)).toList();
        break;
    }

    setState(() {
      currentShape = newShape;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadOriginalShape();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shape Plotting"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Container(
          width: 500,
          padding: EdgeInsets.all(10),
          child: Plot(
            height: 500.0,
            data: currentShape,
            gridSize: Offset(1.0, 1.0),
            centered: true,
            style: PlotStyle(
                pointRadius: 3.0,
                outlineRadius: 1.0,
                primary: Colors.white,
                secondary: Colors.blueAccent,
                textStyle: TextStyle(
                  fontSize: 10.0,
                  color: Colors.blueGrey,
                ),
                axis: Colors.blueGrey[600],
                gridline: Colors.blueGrey[100],
                trace: true,
                traceClose: true,
                showCoordinates: true),
            padding: EdgeInsets.fromLTRB(40.0, 12.0, 12.0, 40.0),
            xTitle: 'X',
            yTitle: 'Y',
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        fabCloseColor: Colors.blueGrey[800],
        fabOpenColor: Colors.blueGrey[800],
        ringColor: Colors.blueGrey[700],
        fabSize: 48,
        ringDiameter: 200,
        fabCloseIcon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        fabOpenIcon: Icon(
          Icons.architecture,
          color: Colors.white,
        ),
        children: [
          IconButton(
              icon: Icon(
                Icons.directions,
                color: Colors.white,
              ),
              onPressed: () async {
                final values = await showTextInputDialog(
                    context: context,
                    title: "Translate Transformation",
                    textFields: [
                      DialogTextField(
                          hintText: "Horizontal translation",
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: (input) => num.tryParse(input) == null
                              ? "Insert a valid number."
                              : null),
                      DialogTextField(
                          hintText: "Vertical translation",
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: (input) => num.tryParse(input) == null
                              ? "Insert a valid number."
                              : null)
                    ]);
                values != null
                    ? updateShape(_geoTransform.translate, values)
                    : print("Operation cancelled");
              }),
          IconButton(
              icon: Icon(
                Icons.rotate_right,
                color: Colors.white,
              ),
              onPressed: () async {
                final values = await showTextInputDialog(
                    context: context,
                    title: "Rotate Transformation",
                    textFields: [
                      DialogTextField(
                          hintText: "Rotation Angle",
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: (input) => num.tryParse(input) == null
                              ? "Insert a valid number."
                              : null)
                    ]);
                values != null
                    ? updateShape(_geoTransform.rotate, values)
                    : print("Operation cancelled");
              }),
          IconButton(
              icon: Icon(
                Icons.aspect_ratio,
                color: Colors.white,
              ),
              onPressed: () async {
                final values = await showTextInputDialog(
                    context: context,
                    title: "Resize Transformation",
                    message:
                        "Insert the amount you want to multiply your scale.\n" +
                            "1.0 will keep it the same\n" +
                            "2.0 will double it\n" +
                            "0.5 will reduce it in half.",
                    textFields: [
                      DialogTextField(
                          hintText: "Horizontal resize",
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: (input) => num.tryParse(input) == null
                              ? "Insert a valid number."
                              : null),
                      DialogTextField(
                          hintText: "Vertical resize",
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          validator: (input) => num.tryParse(input) == null
                              ? "Insert a valid number."
                              : null)
                    ]);
                values != null
                    ? updateShape(_geoTransform.resize, values)
                    : print("Operation cancelled");
              }),
        ],
      ),
    );
  }
}
