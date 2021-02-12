import 'package:flutter/material.dart';
import 'package:geo_transform/screens/menu.dart';
import 'package:geo_transform/screens/normalization.dart';

void main() => runApp(MaterialApp(
      routes: {
        "/": (context) => Menu(),
        "/normalization": (context) => Normalization()
      },
    ));
