import 'package:flutter/material.dart';
import 'models/Producto.dart'; // Asegúrate de importar la clase VProducto desde la ubicación correcta

class ProductDetailsPage extends StatelessWidget {
  final VProducto producto;

  const ProductDetailsPage({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Fondo oscuro futurista
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F3460), // Color oscuro del AppBar
        title: Text(producto.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: producto.imagen != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        producto.imagen!,
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 150,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Código:', producto.codigo.toString()),
            _buildDetailRow('Nombre:', producto.nombre),
            _buildDetailRow('Stock:', producto.stock.toString()),
            _buildDetailRow('Descripción:', producto.descripcion),
            _buildDetailRow('Estado:', producto.estado ? 'Disponible' : 'No Disponible'),
            _buildDetailRow('Precio:', '\$${producto.precio.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E), // Fondo oscuro de las tarjetas
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
