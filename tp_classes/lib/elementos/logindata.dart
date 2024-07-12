class Login {
  String usuario;
  String contrasena;

  Login({
    required this.usuario,
    required this.contrasena,
  });
}

List<Login> logInList = [
  Login(usuario: 'Gabo', contrasena: '123'),
  Login(usuario: 'Joaco', contrasena: '456'),
  Login(usuario: 'Benja', contrasena: '789'),
];
