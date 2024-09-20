import 'package:bodega_movil/ProductDetailsPage.dart';
import 'package:flutter/material.dart';
import 'models/Producto.dart'; // Asegúrate de importar la clase VProducto desde la ubicación correcta

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<VProducto> productos;

  CustomSearchDelegate(this.productos);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<VProducto> results = productos
        .where((producto) =>
            producto.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final producto = results[index];
        return Card(
          color: const Color(0xFF16213E),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: producto.imagen != null
                  ? Image.network(
                      producto.imagen!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[700],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 30),
                    ),
            ),
            title: Text(
              producto.nombre,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Código: ${producto.codigo}',
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(producto: producto),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<VProducto> suggestions = productos
        .where((producto) =>
            producto.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final producto = suggestions[index];
        return Card(
          color: const Color(0xFF16213E),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: producto.imagen != null
                  ? Image.network(
                      producto.imagen!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[700],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 30),
                    ),
            ),
            title: Text(
              producto.nombre,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Código: ${producto.codigo}',
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              query = producto.nombre;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
