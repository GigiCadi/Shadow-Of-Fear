// ============================================================
// PANTALLA DE SELECCIÓN DE JUEGOS (NIVELES)
// ============================================================

void pantallaNiveles() {
  imageMode(CENTER);
  image(fondoniveles, width/2, height/2, width, height);
  dibujarBotonConSombra(btnjuegos[0], width/2, height/2 - 130, 621, 126); // Juego 1
  dibujarBotonConSombra(btnjuegos[1], width/2, height/2 + 20, 621, 126);  // Juego 2
  dibujarBotonConSombra(btnjuegos[2], width/2, height/2 + 170, 621, 126); // Juego 3
}

// ============================================================
// CONTROLES DE LA PANTALLA DE NIVELES
// ============================================================

void controlarNiveles() {
  // Botón Juego 1 (superior)
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > height/2 - 193 && mouseY < height/2 - 67) {
    if (fuente != null) iniciarJuego1Completo();
    return;
  }
  
  // Botón Juego 2 (central)
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > height/2 - 43 && mouseY < height/2 + 83) {
    iniciarJuego2();
    return;
  }
  
  // Botón Juego 3 (inferior)
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > height/2 + 107 && mouseY < height/2 + 233) {
    iniciarJuego3();
    return;
  }
}
