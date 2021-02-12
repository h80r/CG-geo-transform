import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text("geoTransform"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/normalization"),
                child: Text("Normalizar Coordenadas"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => print("Botão 2"),
                child: Text("Transformações Geométricas"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
