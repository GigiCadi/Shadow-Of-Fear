// ========================================
// PANTALLA DE CÓDIGO
// ========================================

int paginaCodigo = 0;
int totalPaginasCodigo = 1;

String[] textosCodigo = {
  "HOLA, SOY RUTH. LOS ARREGLOS NOS AYUDAN A GUARDAR",
  "INFORMACIÓN EN ORDEN.",
  "",
  "EN EL JUEGO GUARDAMOS LOS MENSAJES OFENSIVOS EN",
  "UN ARREGLO LLAMADO MENSAJES[] Y LAS RESPUESTAS",
  "POSITIVAS EN RESPUESTAS[]. CADA MENSAJE TIENE SU",
  "PAREJA EN LA MISMA POSICIÓN."
};

void pantallaCodigo() {
  imageMode(CORNER);
  
  // Fondo
  if (fondoCodigo != null) {
    image(fondoCodigo, 0, 0, width, height);
  } else {
    background(30, 25, 55);
  }
  
  // Personaje Ruth
  imageMode(CENTER);
  if (personajeRuth != null) {
    float tamanoX = width * 0.55;
    float tamanoY = personajeRuth.height * (tamanoX / personajeRuth.width);
    image(personajeRuth, width * 0.2, height * 0.8, tamanoX, tamanoY);
  }
  
  // Cuadro de texto
  float anchoTexto = width * 0.6;  // Más ancho
  float xTexto = width * 0.3;       // Texto más a la izquierda
  float yTexto = height * 0.25;
  
  fill(0, 0, 0, 200);
  noStroke();
  rectMode(CORNER);
  rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 280, 15); 
  
  fill(245, 235, 255);
  textFont(fuente);
  textSize(18);
  textAlign(LEFT, TOP);
  
  float yLinea = yTexto;
  for (int i = 0; i < textosCodigo.length; i++) {
    fill(255);
    text(textosCodigo[i], xTexto, yLinea + i * 28);
  }
  
  // Botón volver
  imageMode(CENTER);
  image(btnvolver, width - 140, 40, 250, 64);
}

void controlarCodigo() {
  float radioX = 125;
  float radioY = 32;
  
  // BOTÓN VOLVER
  if (mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > 40 - radioY && mouseY < 40 + radioY) {
    pantalla = 1;
  }
}

void controlarCodigoTeclado() {
  if (keyCode == ESC) {
    pantalla = 1;
  }
}
