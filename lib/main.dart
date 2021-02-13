import 'package:flutter/material.dart';
import 'package:geo_transform/screens/menu.dart';
import 'package:geo_transform/screens/normalization.dart';
import 'package:geo_transform/screens/plotter.dart';
import 'package:geo_transform/screens/shape_creator.dart';

void main() => runApp(MaterialApp(
      routes: {
        "/": (context) => Menu(),
        "/normalization": (context) => Normalization(),
        "/shape_creator": (context) => ShapeCreator(),
        "/plotter": (context) => Plotter()
      },
    ));
