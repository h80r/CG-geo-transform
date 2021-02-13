import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _possibleCoordinates { x, y }

class ShapeCreator extends StatefulWidget {
  @override
  _ShapeCreatorState createState() => _ShapeCreatorState();
}

class _ShapeCreatorState extends State<ShapeCreator> {
  var shapeVertices = <Point>[];

  void updateVerticesCount(String input) {
    final parsedInput = int.tryParse(input);
    if (parsedInput is int && parsedInput > 0) {
      setState(() {
        shapeVertices = List.generate(parsedInput, (index) => Point(0, 0));
      });
    }
  }

  num parseCoordinate(String input) {
    return num.tryParse(input) ?? 0;
  }

  void updatePoint(String input, int point, _possibleCoordinates coordinate) {
    final currentPoint = shapeVertices[point];
    final newCoordinate = parseCoordinate(input);
    Point newPoint;

    switch (coordinate) {
      case _possibleCoordinates.x:
        newPoint = Point(newCoordinate, currentPoint.y);
        break;

      case _possibleCoordinates.y:
        newPoint = Point(currentPoint.x, newCoordinate);
        break;
    }

    shapeVertices[point] = newPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Shape Configuration"),
          backgroundColor: Colors.blueGrey[900]),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Text(
                "How many vertices does your shape have?",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (input) => updateVerticesCount(input),
                maxLength: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Configure every point:",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Point ${i + 1}:",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(labelText: "X"),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              onChanged: (input) =>
                                  updatePoint(input, i, _possibleCoordinates.x),
                            ),
                          ),
                          Spacer(),
                          Flexible(
                            flex: 3,
                            child: TextField(
                              decoration: InputDecoration(labelText: "Y"),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              onChanged: (input) =>
                                  updatePoint(input, i, _possibleCoordinates.y),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: shapeVertices.length,
                ),
              ),
              Divider(),
              ElevatedButton(
                  onPressed: () => print(shapeVertices), child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}
