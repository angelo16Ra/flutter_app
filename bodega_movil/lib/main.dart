import 'package:bodega_movil/catalogo.dart';
import 'package:bodega_movil/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/catalogo': (context) => CatalogoFullState(),
        
      },
    );
  }
}
