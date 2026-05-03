int paginaManual = 0;
int totalPaginasManual = 3; 

void pantallaManual() {
  imageMode(CORNER);
  
  // Asegurar que la página esté dentro del rango
  if (paginaManual < 0) paginaManual = 0;
  if (paginaManual >= manual.length) paginaManual = manual.length - 1;
  
  image(manual[paginaManual], 0, 0, width, height);
  imageMode(CENTER);
  image(btnext,   width - 140, height - 40, 250, 64);
  image(btnback,  140,         height - 40, 250, 64);
  image(btnvolver, width - 140, 40,         250, 64);
}

void controlarManual() {
  float radioX = 125;
  float radioY = 32;

  // BOTÓN VOLVER
  if (mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > 40 - radioY          && mouseY < 40 + radioY) {
    pantalla = 1;
    return;
  }

  // BOTÓN NEXT
  if (mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {
    paginaManual++;
    if (paginaManual >= manual.length) paginaManual = manual.length - 1;
  }

  // BOTÓN BACK
  if (mousePressed &&
      mouseX > 140 - radioX && mouseX < 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {
    paginaManual--;
    if (paginaManual < 0) paginaManual = 0;
  }
}

// Nueva función para controlar manual con teclado
void controlarManualTeclado() {
  if (keyCode == RIGHT) {
    paginaManual++;
    if (paginaManual >= manual.length) paginaManual = manual.length - 1;
  }
  else if (keyCode == LEFT) {
    paginaManual--;
    if (paginaManual < 0) paginaManual = 0;
  }
  else if (keyCode == ESC) {
    pantalla = 1;
  }
}
