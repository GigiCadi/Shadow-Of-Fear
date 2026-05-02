void pantallaNiveles() {
  imageMode(CENTER);
  image(fondoniveles, width/2,height/2, width, height);
  image(btnjuegos[0],   width/2, height/2 - 130, 621, 126);
  image(btnjuegos[1],  width/2,  height/ 2 + 20, 621, 126);
  image(btnjuegos[2], width/2, height/2 + 170, 621, 126);
}
void controlarNiveles() {
  // Botón juego 1
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > (height/2 - 130) - 63 && mouseY < (height/2 - 130) + 63) {
    println("Iniciando juego 1 desde niveles");
    
    // Verificar que todo está cargado antes de cambiar
    if (fuente == null) {
      println("ERROR: Fuente no cargada");
      return;
    }
    
    iniciarModoJuego1(MODO_FACIL);
    // iniciarJuego1Completo();  // ← Comenta esta línea si causa problema
    return;
  }
  
  // Botón juego 2
  if (mousePressed &&
      mouseX > width/2 - 310 && mouseX < width/2 + 310 &&
      mouseY > (height/2 + 20) - 63 && mouseY < (height/2 + 20) + 63) {
    println("Iniciando juego 2 desde niveles");
    iniciarJuego2();
    return;
  }
}
