

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

  fill(0, 190);
  rect(0, 0, width, height);

  textAlign(CENTER, CENTER);

  fill(255);
  textSize(28);
  text("PAUSA", width / 2, height / 2 - 120);

  textSize(16);

  int total = totalOpcionesPausaJuego1();

  int x = width / 2;
  int yInicial = height / 2 - 10;
  int espacioY = 55;

  for (int i = 0; i < total; i++) {
    int y = yInicial + i * espacioY;

    if (i == opcionPausa) {
      fill(255, 230, 120);
    } else {
      fill(255);
    }

    String texto = "";

    if (i == 0) {
      texto = "Continuar";
    }

    else if (i == 1) {
      texto = "Reiniciar modo actual";
    }

    else if (verNivelesDesbloqueado && i == 2) {
      texto = "<  Modo [" + nombresModos[modoPausaSeleccionado] + "]  >";
    }

    else if (verNivelesDesbloqueado && i == 3) {
      texto = "Volver al menú";
    }

    else if (!verNivelesDesbloqueado && i == 2) {
      texto = "Volver al menú";
    }

    if (i == opcionPausa) {
      text("> " + texto, x, y);
    } else {
      text(texto, x, y);
    }
  }

  if (verNivelesDesbloqueado && opcionPausa == 2) {
    fill(180);
    textSize(12);
    text("Usa LEFT / RIGHT para cambiar de modo", width / 2, height / 2 + 170);
  }
}

void dibujarFinal() {

  fill(0, 180);
  rect(0, 0, width, height);

  textAlign(CENTER, CENTER);
  fill(255);

  textSize(24);
  text(mensajeFinalTitulo, width/2, height/2 - 150);

  textSize(14);
  dibujarTextoCentrado(mensajeFinalSubtexto, width/2, height/2 - 100, 520, 22);

  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) {
    prepararMenuFinalJuego1();
  }

  textSize(16);

  int x = width / 2;
  int yInicial = height / 2 + 10;
  int espacioY = 55;

  for (int i = 0; i < opcionesFinalJuego1.length; i++) {
    int y = yInicial + i * espacioY;

    if (!opcionesFinalActivasJuego1[i]) {
      fill(120);
    } else if (i == opcionFinalJuego1) {
      fill(255, 230, 120);
    } else {
      fill(255);
    }

    String texto = "";

    if (i == 1) {
      texto = "<  Modo [" + nombresModos[modoFinalSeleccionado] + "]  >";

      if (!modoEstaDesbloqueado(modoFinalSeleccionado)) {
        texto += " [Bloqueado]";
      }
    } else {
      texto = opcionesFinalJuego1[i];
    }

    if (i == opcionFinalJuego1) {
      text("> " + texto, x, y);
    } else {
      text(texto, x, y);
    }
  }

  if (opcionFinalJuego1 == 1) {
    fill(180);
    textSize(12);
    text("Usa LEFT / RIGHT para cambiar de modo", width / 2, height / 2 + 200);
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
