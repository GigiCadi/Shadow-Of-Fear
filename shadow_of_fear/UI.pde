

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

  textAlign(CENTER, CENTER);
  fill(255);

  textSize(24);
  text(mensajeFinalTitulo, width/2, height/2 - 120);

  textSize(14);
  dibujarTextoCentrado(mensajeFinalSubtexto, width/2, height/2 - 70, 420, 22);

  textSize(20);

  String[] opciones;

  if (estadoFinal == 2) {
    opciones = new String[] {
      "Continuar",
      "Reiniciar",
      "Regresar al menú"
    };
  } 
  else {
    opciones = new String[] {
      "Volver a jugar",
      "Reiniciar",
      "Regresar al menú"
    };
  }

  int x = width/2;

  for (int i = 0; i < opciones.length; i++) {
    int y = height/2 + 20 + i * 55;

    if (i == opcionFinal) {
      text("> " + opciones[i], x, y);
    } else {
      text(opciones[i], x, y);
    }
  }
}

void dibujarTextoCentrado(String texto, float cx, float yInicial, float anchoMax, float interlineado) {
  String[] palabras = split(texto, " ");
  String linea = "";
  float y = yInicial;

  textAlign(CENTER, CENTER);

  for (int i = 0; i < palabras.length; i++) {
    String prueba;

    if (linea.equals("")) {
      prueba = palabras[i];
    } else {
      prueba = linea + " " + palabras[i];
    }

    if (textWidth(prueba) > anchoMax) {
      text(linea, cx, y);
      linea = palabras[i];
      y += interlineado;
    } else {
      linea = prueba;
    }
  }

  if (!linea.equals("")) {
    text(linea, cx, y);
  }
}
