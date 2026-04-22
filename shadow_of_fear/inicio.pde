void pantallaInicio() {

  // Fondo
  image(fondo1, 0, 0, width, height);

  // Posición centrada del logo
  float x = width/2 - logo.width/2;
  float yCentro = height/2 - logo.height/2;

  // Animación flotante
  tiempo += 0.09;
  float offsetY = sin(tiempo) * 12;

  // Logo
  image(logo, x, yCentro + offsetY);

  // Texto
  text("Presiona cualquier tecla para continuar", width/2, height - 50);
}
