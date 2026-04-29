int paginaManual = 0;

void pantallaManual(){
  imageMode(CORNER);
  image(manual[0], 0, 0, width, height);
  imageMode(CENTER);
  image(btnext, width - 140, height - 40, 250, 64);
  image(btnback, 140, height - 40, 250, 64);
  dibujarUI();
  controlarManual();
}

void controlarManual() {

  float radioX = 125; // mitad del ancho (250 / 2)
  float radioY = 32;  // mitad del alto (64 / 2)

  // BOTÓN NEXT
  if (mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {

    paginaManual++;

    // 🔥 evita que se pase del límite
    if (paginaManual > manual.length - 1) {
      paginaManual = manual.length - 1;
    }
  }

  // BOTÓN BACK
  if (mousePressed &&
      mouseX > 140 - radioX && mouseX < 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {

    paginaManual--;

    if (paginaManual < 0) {
      paginaManual = 0;
    }
  }
}
