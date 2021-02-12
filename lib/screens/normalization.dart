import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_transform/operations/normalization.dart';

class Normalization extends StatefulWidget {
  @override
  _NormalizationState createState() => _NormalizationState();
}

class _NormalizationState extends State<Normalization> {
  var homogeneousCoordinates = {"x": 0.0, "y": 0.0, "z": 0.0, "scale": 1.0};
  String normalizationResult = "";

  void updateCoordinate(String input, String coord) {
    homogeneousCoordinates[coord] =
        num.tryParse(input) ?? homogeneousCoordinates[coord];
  }

  void normalizeCoordinates() {
    setState(() {
      normalizationResult = coordinateNormalization(
                  homogeneousCoordinates["x"], homogeneousCoordinates["y"],
                  z: homogeneousCoordinates["z"],
                  scale: homogeneousCoordinates["scale"])
              ?.toString() ??
          "Insertion Error.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordinates Normalization"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Insert homogeneous coordinates:"),
              Divider(),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(labelText: "X"),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      onChanged: (input) => updateCoordinate(input, "x"),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(labelText: "Y"),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      onChanged: (input) => updateCoordinate(input, "y"),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(labelText: "Z"),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      onChanged: (input) => updateCoordinate(input, "z"),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(labelText: "Scale"),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      onChanged: (input) => updateCoordinate(input, "scale"),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => normalizeCoordinates(),
                  child: Text("Normalize")),
              SizedBox(
                height: 20,
              ),
              Text("Normalized coordinates:"),
              Divider(),
              Text(normalizationResult)
            ],
          )),
    );
  }
}


/*Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
          padding: const EdgeInsets.all(40.0),
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(labelText: "Enter your number"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
], // Only numbers can be entered
          ),
        ],
      )),
    );*/