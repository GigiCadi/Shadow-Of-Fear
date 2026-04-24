

void dibujarUI() {
  imageMode(CENTER);

  int tamaño = 100;
  int espacio = 15;
  int y = 80;

  int x = width - (tamaño * 3);

  image(btnmusic[estadoMusica], x + tamaño + espacio, y, tamaño, tamaño);
  image(btnpause[estadoPausa], x + (tamaño + espacio) * 2, y, tamaño, tamaño);
}

//  -->> IU juego 1
void dibujarBarras() {
  imageMode(CENTER);

  int x = 150;
  int yBase = height/2 + 125; // abajo
  int espacio = 110;

  for (int i = 0; i < 4; i++) {

    // Mostrar solo las que NO han desaparecido
    if (i >= estadoEmocion) {
      image(bars[i], x, yBase - (3 - i) * espacio, 90, 90);
    }
  }
}

void dibujarPause() {

  fill(0, 180);
  rect(0, 0, width, height);

  textAlign(CENTER);
  textSize(20);

  String[] opciones = {
    "Continuar",
    "Reiniciar",
    "Configuración",
    "Regresar al menú"
  };

  int x = width/2;

  for (int i = 0; i < opciones.length; i++) {

    int y = height/2 - 40 + i * 60;

    fill(255);

    if (i == opcionPausa) {
      text("> " + opciones[i], x, y);
    } else {
      text(opciones[i], x, y);
    }
  }
}

void dibujarFinal() {

  fill(0, 180);
  rect(0, 0, width, height);

  textAlign(CENTER);
  fill(255);

  textSize(28);
  if (estadoFinal == 1) {
    text("PERDISTE", width/2, height/2 - 110);
  } 
  else if (estadoFinal == 2) {
    text("GANASTE", width/2, height/2 - 110);
  }

  textSize(20);

  String[] opciones;

  if (estadoFinal == 2) {
    opciones = new String[] {
      "Continuar",
      "Regresar al menú"
    };
  } 
  else {
    opciones = new String[] {
      "Volver a jugar",
      "Regresar al menú"
    };
  }

  int x = width/2;

  for (int i = 0; i < opciones.length; i++) {
    int y = height/2 - 10 + i * 60;

    if (i == opcionFinal) {
      text("> " + opciones[i], x, y);
    } else {
      text(opciones[i], x, y);
    }
  }
}
