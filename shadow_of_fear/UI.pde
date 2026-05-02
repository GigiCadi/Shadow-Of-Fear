

void dibujarUI() {
  pushStyle();
  imageMode(CENTER);
  int tamaño = 100;
  int espacio = 15;
  int y = 80;
  int x = width - (tamaño * 3);
  // Solo el botón de pausa
  image(btnpause[estadoPausa], x + (tamaño + espacio) * 2, y, tamaño, tamaño);
  popStyle();
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
  pushStyle();  
  
  fill(0, 190);
  rect(0, 0, width, height);

  textAlign(CENTER, CENTER);
  textFont(fuente);
  fill(245, 235, 255);
  textSize(28);
  text("PAUSA", width / 2, height / 2 - 120);
  textSize(16);

  int x = width / 2;
  int yInicial = height / 2 - 10;
  int espacioY = 55;

  // =========================
  // PAUSA JUEGO 2
  // =========================
  if (tipoPausa == 1) {
    String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};

    for (int i = 0; i < opciones.length; i++) {
      int y = yInicial + i * espacioY;

      if (i == opcionPausa) {
        fill(190, 165, 255);
        text("> " + opciones[i], x, y);
      } else {
        fill(245, 235, 255);
        text(opciones[i], x, y);
      }
    }
    popStyle();  
    return;      
  }

  // PAUSA JUEGO 1
  if (pantallaOrigen == 4) {
    String[] opcionesManual = {"Continuar", "Volver al menú"};
    for (int i = 0; i < opcionesManual.length; i++) {
      int y = yInicial + i * espacioY;
      if (i == opcionPausa) {
        fill(190, 165, 255);
        text("> " + opcionesManual[i], x, y);
      } else {
        fill(245, 235, 255);
        text(opcionesManual[i], x, y);
      }
    }
    popStyle(); 
    return;
  }
  
  // PAUSA JUEGO 3
  if (tipoPausa == 2) {
      String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};
          for (int i = 0; i < opciones.length; i++) {
      int y = yInicial + i * espacioY;

      if (i == opcionPausa) {
        fill(190, 165, 255);
        text("> " + opciones[i], x, y);
      } else {
        fill(245, 235, 255);
        text(opciones[i], x, y);
      }
    }
    popStyle();  
       return;
  }
  int total = totalOpcionesPausaJuego1();

  for (int i = 0; i < total; i++) {
    int y = yInicial + i * espacioY;
    String texto = "";

    if (i == 0) texto = "Continuar";
    else if (i == 1) texto = "Reiniciar modo actual";
    else if (verNivelesDesbloqueado && i == 2) texto = "<  Modo [" + nombresModos[modoPausaSeleccionado] + "]  >";
    else if (verNivelesDesbloqueado && i == 3) texto = "Volver al menú";
    else if (!verNivelesDesbloqueado && i == 2) texto = "Volver al menú";

    if (i == opcionPausa) {
      fill(190, 165, 255);
      text("> " + texto, x, y);
    } else {
      fill(245, 235, 255);
      text(texto, x, y);
    }
  }

  if (verNivelesDesbloqueado && opcionPausa == 2) {
    fill(190, 165, 255);
    textSize(12);
    text("Usa LEFT / RIGHT para cambiar de modo", width / 2, height / 2 + 170);
  }
  
  popStyle(); 
}

void dibujarFinal() {
  pushStyle();  
  
  fill(0, 180);
  rect(0, 0, width, height);

  textAlign(CENTER, CENTER);
  textFont(fuente);

  // Título del mensaje final.
  fill(245, 235, 255);
  textSize(24);
  text(mensajeFinalTitulo, width/2, height/2 - 150);

  // Subtexto del mensaje final.
  fill(245, 235, 255);
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

    // Color de cada opción del menú final.
    if (!opcionesFinalActivasJuego1[i]) {
      fill(110, 95, 140);       // morado grisáceo para opciones bloqueadas
    } else if (i == opcionFinalJuego1) {
      fill(190, 165, 255);      // lila claro para opción seleccionada
    } else {
      fill(245, 235, 255);      // lila muy claro para opciones normales
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
    fill(190, 165, 255);
    textSize(12);
    text("Usa LEFT / RIGHT para cambiar de modo", width / 2, height / 2 + 200);
  }
  
  popStyle(); 
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
