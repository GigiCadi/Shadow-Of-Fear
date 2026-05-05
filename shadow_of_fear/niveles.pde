void pantallaNiveles() {
  imageMode(CENTER);
  image(fondoniveles, width/2,height/2, width, height);
  dibujarBotonConSombra(btnjuegos[0],   width/2, height/2 - 130, 621, 126);
  dibujarBotonConSombra(btnjuegos[1],  width/2,  height/ 2 + 20, 621, 126);
  dibujarBotonConSombra(btnjuegos[2], width/2, height/2 + 170, 621, 126);
}
void controlarNiveles() {
  // Botón juego 1
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > (height/2 - 130) - 63 && mouseY < (height/2 - 130) + 63) {
    
    if (fuente == null) {
      return;
    }
    iniciarJuego1Completo();  // ← Comenta esta línea si causa problema
    return;
  }
  
  // Botón juego 2
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > (height/2 + 20) - 63 && mouseY < (height/2 + 20) + 63) {
    iniciarJuego2();
    return;
  }
  
  // Botón juego 3
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > (height/2 + 170) - 63 && mouseY < (height/2 + 170) + 63) {
      iniciarJuego3();
      return;
  }
}
