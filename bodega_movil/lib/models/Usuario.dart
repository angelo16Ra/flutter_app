class Usuario {
  String? apellido;
  String? correo;
  String? edad;
  String? nombre;
  String? password;
  String? rol;
  String? telefono;
  String? usuario;

  Usuario(
      {this.apellido,
      this.correo,
      this.edad,
      this.nombre,
      this.password,
      this.rol,
      this.telefono,
      this.usuario});

  Usuario.fromJson(Map<String, dynamic> json) {
    apellido = json['apellido'];
    correo = json['correo'];
    edad = json['edad'];
    nombre = json['nombre'];
    password = json['password'];
    rol = json['rol'];
    telefono = json['telefono'];
    usuario = json['usuario'];
  }
}
