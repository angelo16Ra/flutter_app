import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Producto.dart'; // Asegúrate de importar la clase correcta
import 'custom_search_delegate.dart'; // Importa el archivo donde definiste CustomSearchDelegate

class CatalogoFullState extends StatefulWidget {
  const CatalogoFullState({Key? key}) : super(key: key);

  @override
  State<CatalogoFullState> createState() => _CatalogoFullState();
}

class _CatalogoFullState extends State<CatalogoFullState> {
  late Future<List<VProducto>> listaproductos;

  @override
  void initState() {
    super.initState();
    listaproductos = getProductos();
  }

  static Future<List<VProducto>> getProductos() async {
    var url = Uri.parse('https://bodegayani.somee.com/api/Producto/');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List body = json.decode(response.body);
      return body.map((e) => VProducto.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F3460),
        title: const Text(
          'Catálogo de Productos',
          style: TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 1.5),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/usuario');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/agregar');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final productos = await listaproductos;
              showSearch(context: context, delegate: CustomSearchDelegate(productos));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<VProducto>>(
          future: listaproductos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent));
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text("Error al cargar los productos",
                      style: TextStyle(color: Colors.redAccent)));
            } else if (snapshot.hasData) {
              final products = snapshot.data!;
              return buildProductos(products);
            } else {
              return const Center(
                  child: Text("No hay productos disponibles",
                      style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }

  Widget buildProductos(List<VProducto> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: const Color(0xFF16213E),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: product.imagen != null
                      ? Image.network(
                          product.imagen!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[700],
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 50),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Código: ${product.codigo}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent),
                      ),
                      Text(
                        'Nombre: ${product.nombre}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        'Stock: ${product.stock}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        'Precio: ${product.precio}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
