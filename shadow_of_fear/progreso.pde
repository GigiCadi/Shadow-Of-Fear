final int MODO_FACIL = 0;
final int MODO_NORMAL = 1;
final int MODO_DIFICIL = 2;
final int TOTAL_MODOS = 3;

String[] nombresModos = {"Modo Fácil", "Modo Normal", "Modo Difícil"};
int modoActual = MODO_FACIL;

boolean[] modosDesbloqueados = new boolean[TOTAL_MODOS];
boolean verNivelesDesbloqueado = false;

final int ACCION_REINTENTAR_MODO_ACTUAL = 0;
final int ACCION_SELECTOR_MODO = 1;
final int ACCION_VOLVER_MENU = 4;
final int ACCION_VER_NIVELES = 5;

String[] opcionesFinalJuego1 = new String[0];
boolean[] opcionesFinalActivasJuego1 = new boolean[0];
int[] accionesFinalJuego1 = new int[0];
int opcionFinalJuego1 = 0;
int modoFinalSeleccionado = MODO_FACIL;

void inicializarProgresoJuego1() {
  for (int i = 0; i < TOTAL_MODOS; i++) modosDesbloqueados[i] = false;
  modosDesbloqueados[MODO_FACIL] = true;
  verNivelesDesbloqueado = true;
}

boolean modoEstaDesbloqueado(int modo) {
  if (modo < 0 || modo >= TOTAL_MODOS) return false;
  return modosDesbloqueados[modo];
}

void iniciarModoJuego1(int modo) {
  if (!modoEstaDesbloqueado(modo)) {
    feedback = "Modo bloqueado";
    tiempoFeedback = 60;
    return;
  }
  modoActual = modo;
  dificultadNivel1 = modoActual + 1;
  estadoFinal = 0;
  estadoPausa = 0;
  opcionFinalJuego1 = 0;
  iniciarNivel1();
  cargarDatosModoJuego1(modoActual);
  mezclarMensajes();
  generarUsuariosAnonimos();
  inicializarComentariosMostrados();
  cargarMensaje();
  iniciarLoreJuego1();
}

void reiniciarModoActual() {
  iniciarModoJuego1(modoActual);
}

void completarModoJuego1(int modo) {
  if (modo + 1 < TOTAL_MODOS) modosDesbloqueados[modo + 1] = true;
  if (modo == MODO_DIFICIL) verNivelesDesbloqueado = true;
}

void terminarModoJuego1(boolean gano) {

  // evitar que se dispare varias veces
  if (estadoFinal != 0) return;
detenerAudioGeneral();

  nivel1Terminado = true;

  // 🔇 DETENER TODA LA MÚSICA
  if (musicaNivel1 != null && musicaNivel1.isPlaying()) {
    musicaNivel1.stop();
  }

  if (musicaMenu != null && musicaMenu.isPlaying()) {
    musicaMenu.stop();
  }

  if (sonidoVoz != null && sonidoVoz.isPlaying()) {
    sonidoVoz.stop();
  }

  // 🎯 SONIDOS DE FINAL
  if (gano) {
    completarModoJuego1(modoActual);

    if (victoria != null) {
      victoria.stop();
      victoria.play();
    }

    generarMensajeFinal(2);
    estadoFinal = 2;

  } else {
    if (derrota != null) {
      derrota.stop();
      derrota.play();
    }

    generarMensajeFinal(1);
    estadoFinal = 1;
  }

  opcionFinalJuego1 = 0;
  prepararMenuFinalJuego1();
}

void prepararMenuFinalJuego1() {
  String[] textosTemp = new String[4];
  boolean[] activasTemp = new boolean[4];
  int[] accionesTemp = new int[4];
  int total = 0;
  modoFinalSeleccionado = modoActual;
  total = agregarOpcionFinalJuego1(textosTemp, activasTemp, accionesTemp, total,
    "Volver a intentar modo actual", true, ACCION_REINTENTAR_MODO_ACTUAL);
  total = agregarOpcionFinalJuego1(textosTemp, activasTemp, accionesTemp, total,
    "Selector de modo", true, ACCION_SELECTOR_MODO);
  if (verNivelesDesbloqueado) {
    total = agregarOpcionFinalJuego1(textosTemp, activasTemp, accionesTemp, total,
      "Ver Niveles", true, ACCION_VER_NIVELES);
  }
  total = agregarOpcionFinalJuego1(textosTemp, activasTemp, accionesTemp, total,
    "Volver al menú", true, ACCION_VOLVER_MENU);
  opcionesFinalJuego1 = new String[total];
  opcionesFinalActivasJuego1 = new boolean[total];
  accionesFinalJuego1 = new int[total];
  for (int i = 0; i < total; i++) {
    opcionesFinalJuego1[i] = textosTemp[i];
    opcionesFinalActivasJuego1[i] = activasTemp[i];
    accionesFinalJuego1[i] = accionesTemp[i];
  }
  opcionFinalJuego1 = 0;
}

int agregarOpcionFinalJuego1(String[] textos, boolean[] activas, int[] acciones,
                             int total, String texto, boolean activa, int accion) {
  textos[total] = texto;
  activas[total] = activa;
  acciones[total] = accion;
  return total + 1;
}

void controlarMenuFinalJuego1Teclado() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) prepararMenuFinalJuego1();
  if (keyCode == UP) {
    opcionFinalJuego1--;
    if (opcionFinalJuego1 < 0) opcionFinalJuego1 = opcionesFinalJuego1.length - 1;
  } else if (keyCode == DOWN) {
    opcionFinalJuego1++;
    if (opcionFinalJuego1 >= opcionesFinalJuego1.length) opcionFinalJuego1 = 0;
  } else if (opcionFinalJuego1 == 1 && keyCode == LEFT) {
    cambiarModoFinal(-1);
  } else if (opcionFinalJuego1 == 1 && keyCode == RIGHT) {
    cambiarModoFinal(1);
  } else if (key == ' ' || keyCode == ENTER) {
    ejecutarOpcionFinalJuego1();
  }
}

void controlarMenuFinalJuego1Mouse() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) prepararMenuFinalJuego1();
  int ancho = 430, alto = 42, xCentro = width/2, yInicial = height/2 + 10, espacioY = 55;
  for (int i = 0; i < opcionesFinalJuego1.length; i++) {
    int y = yInicial + i * espacioY;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y - alto/2 && mouseY < y + alto/2) {
      opcionFinalJuego1 = i;
      if (opcionFinalJuego1 == 1) {
        if (mouseX < xCentro - 120) { cambiarModoFinal(-1); return; }
        if (mouseX > xCentro + 120) { cambiarModoFinal(1); return; }
        ejecutarOpcionFinalJuego1();
        return;
      }
      ejecutarOpcionFinalJuego1();
      return;
    }
  }
}

void ejecutarOpcionFinalJuego1() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) return;
  if (!opcionesFinalActivasJuego1[opcionFinalJuego1]) {
    feedback = "Opción bloqueada";
    tiempoFeedback = 60;
    return;
  }
  int accion = accionesFinalJuego1[opcionFinalJuego1];
  if (opcionFinalJuego1 == 1) {
    if (modoEstaDesbloqueado(modoFinalSeleccionado)) {
      estadoFinal = 0;
      estadoPausa = 0;
      opcionFinalJuego1 = 0;
      iniciarModoJuego1(modoFinalSeleccionado);
    } else {
      feedback = "Modo bloqueado";
      tiempoFeedback = 60;
    }
    return;
  }
  estadoFinal = 0;
  estadoPausa = 0;
  opcionFinalJuego1 = 0;
  if (accion == ACCION_REINTENTAR_MODO_ACTUAL) {
    iniciarModoJuego1(modoActual);
  } else if (accion == ACCION_VOLVER_MENU) {
    pantalla = 1;
  } else if (accion == ACCION_VER_NIVELES) {
    pantalla = 3;
  }
}

int modoPausaSeleccionado = MODO_FACIL;

int totalOpcionesPausaJuego1() {
  return verNivelesDesbloqueado ? 4 : 3;
}

void cambiarModoPausa(int direccion) {
  modoPausaSeleccionado += direccion;
  if (modoPausaSeleccionado < 0) modoPausaSeleccionado = TOTAL_MODOS - 1;
  if (modoPausaSeleccionado >= TOTAL_MODOS) modoPausaSeleccionado = 0;
}

void cambiarModoFinal(int direccion) {
  modoFinalSeleccionado += direccion;
  if (modoFinalSeleccionado < 0) modoFinalSeleccionado = TOTAL_MODOS - 1;
  if (modoFinalSeleccionado >= TOTAL_MODOS) modoFinalSeleccionado = 0;
}

void controlarPausaJuego1Teclado() {
  if (pantallaOrigen == 4) {
    if (keyCode == UP || keyCode == DOWN) opcionPausa = (opcionPausa == 0) ? 1 : 0;
    else if (key == ' ' || keyCode == ENTER) ejecutarOpcionPausaJuego1();
    return;
  }
  int total = totalOpcionesPausaJuego1();
  if (keyCode == UP) {
    opcionPausa--;
    if (opcionPausa < 0) opcionPausa = total - 1;
  } else if (keyCode == DOWN) {
    opcionPausa++;
    if (opcionPausa >= total) opcionPausa = 0;
  } else if (verNivelesDesbloqueado && opcionPausa == 2 && keyCode == LEFT) {
    cambiarModoPausa(-1);
  } else if (verNivelesDesbloqueado && opcionPausa == 2 && keyCode == RIGHT) {
    cambiarModoPausa(1);
  } else if (key == ' ' || keyCode == ENTER) {
    ejecutarOpcionPausaJuego1();
  }
}

void controlarPausaJuego1Mouse() {
  if (pantallaOrigen == 4) {
    String[] opcionesManual = {"Continuar", "Volver al menú"};
    int ancho = 430, alto = 42, xCentro = width/2, yInicial = height/2 - 10, espacioY = 55;
    for (int i = 0; i < opcionesManual.length; i++) {
      int y = yInicial + i * espacioY;
      if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
          mouseY > y - alto/2 && mouseY < y + alto/2) {
        opcionPausa = i;
        ejecutarOpcionPausaJuego1();
        return;
      }
    }
    return;
  }
  int total = totalOpcionesPausaJuego1();
  int ancho = 430, alto = 42, xCentro = width/2, yInicial = height/2 - 10, espacioY = 55;
  for (int i = 0; i < total; i++) {
    int y = yInicial + i * espacioY;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y - alto/2 && mouseY < y + alto/2) {
      opcionPausa = i;
      if (verNivelesDesbloqueado && opcionPausa == 2) {
        if (mouseX < xCentro - 120) { cambiarModoPausa(-1); return; }
        if (mouseX > xCentro + 120) { cambiarModoPausa(1); return; }
        ejecutarOpcionPausaJuego1();
        return;
      }
      ejecutarOpcionPausaJuego1();
      return;
    }
  }
}

void ejecutarOpcionPausaJuego1() {
  if (opcionPausa == 0) {
    estadoPausa = 0;
  } else if (opcionPausa == 1) {
    estadoPausa = 0;
    reiniciarModoActual();
  } else if (verNivelesDesbloqueado && opcionPausa == 2) {
    estadoPausa = 0;
    iniciarModoJuego1(modoPausaSeleccionado);
  } else if (verNivelesDesbloqueado && opcionPausa == 3) {
    estadoPausa = 0;
    pantalla = 1;
  } else if (!verNivelesDesbloqueado && opcionPausa == 2) {
    estadoPausa = 0;
    pantalla = 1;
  }
}
