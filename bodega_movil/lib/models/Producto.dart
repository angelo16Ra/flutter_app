class VProducto {
  int codigo;
  int codigoUnidadMedida;
  int codigoCategoria;
  int codigoSubCategoria;
  int codigoProveedor;
  int codigoAlmacenes;
  String nombre;
  double stock;
  double precio;
  String? imagen;
  String descripcion;
  bool estado;

  VProducto({
    required this.codigo,
    required this.codigoUnidadMedida,
    required this.codigoCategoria,
    required this.codigoSubCategoria,
    required this.codigoProveedor,
    required this.codigoAlmacenes,
    required this.nombre,
    required this.stock,
    required this.precio,
    this.imagen,
    required this.descripcion,
    required this.estado,
  });

  factory VProducto.fromJson(Map<String, dynamic> json) {
    return VProducto(
      codigo: json['codigoProducto'],
      codigoUnidadMedida: json['codigoUnidadMedida'],
      codigoCategoria: json['codigoCategoria'],
      codigoSubCategoria: json['codigoSubCategoria'],
      codigoProveedor: json['codigoProveedor'],
      codigoAlmacenes: json['codigoAlmacenes'],
      nombre: json['nombre'],
      stock: json['stock'].toDouble(),
      precio: json['precio'].toDouble(),
      imagen: json['imagen'],
      descripcion: json['descripcion'],
      estado: json['estado'],
    );
  }
}
