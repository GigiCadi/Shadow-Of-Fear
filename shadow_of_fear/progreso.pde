// ==========================
// PROGRESO Y MODOS JUEGO 1
// ==========================

// Modos del Juego 1
final int MODO_FACIL = 0;
final int MODO_NORMAL = 1;
final int MODO_DIFICIL = 2;
final int TOTAL_MODOS = 3;

String[] nombresModos = {
  "Modo Fácil",
  "Modo Normal",
  "Modo Difícil"
};

int modoActual = MODO_FACIL;

boolean[] modosCompletados = new boolean[TOTAL_MODOS];
boolean[] modosDesbloqueados = new boolean[TOTAL_MODOS];

boolean verNivelesDesbloqueado = false;

// Acciones del menú final dinámico
final int ACCION_REINTENTAR_MODO_ACTUAL = 0;
final int ACCION_IR_MODO_FACIL = 1;
final int ACCION_IR_MODO_NORMAL = 2;
final int ACCION_IR_MODO_DIFICIL = 3;
final int ACCION_VOLVER_MENU = 4;
final int ACCION_VER_NIVELES = 5;

// Opciones dinámicas del menú final
String[] opcionesFinalJuego1 = new String[0];
boolean[] opcionesFinalActivasJuego1 = new boolean[0];
int[] accionesFinalJuego1 = new int[0];

int opcionFinalJuego1 = 0;
int modoFinalSeleccionado = MODO_FACIL;

// ==========================
// INICIALIZAR PROGRESO
// ==========================
void inicializarProgresoJuego1() {
  for (int i = 0; i < TOTAL_MODOS; i++) {
    modosCompletados[i] = false;
    modosDesbloqueados[i] = false;
  }

  // Al inicio solo está desbloqueado el modo fácil
  modosDesbloqueados[MODO_FACIL] = true;

  verNivelesDesbloqueado = false;

  // Compatibilidad con tu variable antigua
  nivel1Completado = false;
}

// ==========================
// CONSULTAR SI UN MODO ESTÁ DESBLOQUEADO
// ==========================
boolean modoEstaDesbloqueado(int modo) {
  if (modo < 0 || modo >= TOTAL_MODOS) {
    return false;
  }

  return modosDesbloqueados[modo];
}

// ==========================
// INICIAR UN MODO DEL JUEGO 1
// ==========================
void iniciarModoJuego1(int modo) {
  if (!modoEstaDesbloqueado(modo)) {
    feedback = "Modo bloqueado";
    tiempoFeedback = 60;
    return;
  }

  modoActual = modo;

  // Compatibilidad con la variable antigua dificultadNivel1
  // Antes: 1 = fácil, 2 = normal, 3 = difícil
  dificultadNivel1 = modoActual + 1;

  estadoFinal = 0;
  estadoPausa = 0;
  opcionFinal = 0;
  opcionFinalJuego1 = 0;

  iniciarNivel1();
  cargarDatosModoJuego1(modoActual);
  mezclarMensajes();
  generarUsuariosAnonimos();
  inicializarComentariosMostrados();
  cargarMensaje();

  pantalla = 2;
}

// ==========================
// REINICIAR EL MODO ACTUAL
// ==========================
void reiniciarModoActual() {
  iniciarModoJuego1(modoActual);
}

// ==========================
// COMPLETAR MODO
// ==========================
void completarModoJuego1(int modo) {
  if (modo < 0 || modo >= TOTAL_MODOS) {
    return;
  }

  modosCompletados[modo] = true;

  // Si completo fácil, desbloqueo normal.
  // Si completo normal, desbloqueo difícil.
  if (modo + 1 < TOTAL_MODOS) {
    modosDesbloqueados[modo + 1] = true;
  }

  // Si completo difícil, desbloqueo Ver Niveles.
  if (modo == MODO_DIFICIL) {
    verNivelesDesbloqueado = true;

    // Compatibilidad con tu menú viejo
    nivel1Completado = true;
  }
}

// ==========================
// TERMINAR MODO
// ==========================
void terminarModoJuego1(boolean victoria) {
  nivel1Terminado = true;

  if (victoria) {
    completarModoJuego1(modoActual);
    generarMensajeFinal(2);
    estadoFinal = 2;
  } else {
    generarMensajeFinal(1);
    estadoFinal = 1;
  }

  opcionFinal = 0;
  opcionFinalJuego1 = 0;

  prepararMenuFinalJuego1();
}

// ==========================
// PREPARAR MENÚ FINAL DINÁMICO
// ==========================
void prepararMenuFinalJuego1() {
  String[] textosTemp = new String[4];
  boolean[] activasTemp = new boolean[4];
  int[] accionesTemp = new int[4];

  int total = 0;

  // Al abrir el popup final, el selector empieza en el modo actual.
  modoFinalSeleccionado = modoActual;

  total = agregarOpcionFinalJuego1(
    textosTemp,
    activasTemp,
    accionesTemp,
    total,
    "Volver a intentar modo actual",
    true,
    ACCION_REINTENTAR_MODO_ACTUAL
  );

  total = agregarOpcionFinalJuego1(
    textosTemp,
    activasTemp,
    accionesTemp,
    total,
    "Selector de modo",
    true,
    ACCION_IR_MODO_FACIL
  );

  if (verNivelesDesbloqueado) {
    total = agregarOpcionFinalJuego1(
      textosTemp,
      activasTemp,
      accionesTemp,
      total,
      "Ver Niveles",
      true,
      ACCION_VER_NIVELES
    );
  }

  total = agregarOpcionFinalJuego1(
    textosTemp,
    activasTemp,
    accionesTemp,
    total,
    "Volver al menú",
    true,
    ACCION_VOLVER_MENU
  );

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

// ==========================
// AGREGAR OPCIÓN AL MENÚ FINAL
// ==========================
int agregarOpcionFinalJuego1(
  String[] textos,
  boolean[] activas,
  int[] acciones,
  int total,
  String texto,
  boolean activa,
  int accion
) {
  textos[total] = texto;
  activas[total] = activa;
  acciones[total] = accion;

  return total + 1;
}

// ==========================
// CONTROLAR MENÚ FINAL CON TECLADO
// ==========================
void controlarMenuFinalJuego1Teclado() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) {
    prepararMenuFinalJuego1();
  }

  if (keyCode == UP) {
    opcionFinalJuego1--;

    if (opcionFinalJuego1 < 0) {
      opcionFinalJuego1 = opcionesFinalJuego1.length - 1;
    }
  }

  else if (keyCode == DOWN) {
    opcionFinalJuego1++;

    if (opcionFinalJuego1 >= opcionesFinalJuego1.length) {
      opcionFinalJuego1 = 0;
    }
  }

  // La opción 1 es el selector de modo.
  else if (opcionFinalJuego1 == 1 && keyCode == LEFT) {
    cambiarModoFinal(-1);
  }

  else if (opcionFinalJuego1 == 1 && keyCode == RIGHT) {
    cambiarModoFinal(1);
  }

  else if (key == ' ' || keyCode == ENTER) {
    ejecutarOpcionFinalJuego1();
  }
}

// ==========================
// CONTROLAR MENÚ FINAL CON MOUSE
// ==========================
void controlarMenuFinalJuego1Mouse() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) {
    prepararMenuFinalJuego1();
  }

  int ancho = 430;
  int alto = 42;
  int xCentro = width / 2;
  int yInicial = height / 2 + 10;
  int espacioY = 55;

  for (int i = 0; i < opcionesFinalJuego1.length; i++) {
    int y = yInicial + i * espacioY;

    if (
      mouseX > xCentro - ancho / 2 &&
      mouseX < xCentro + ancho / 2 &&
      mouseY > y - alto / 2 &&
      mouseY < y + alto / 2
    ) {
      opcionFinalJuego1 = i;

      // Si hizo click en la opción del selector de modo
      if (opcionFinalJuego1 == 1) {

        // Zona izquierda
        if (mouseX < xCentro - 120) {
          cambiarModoFinal(-1);
          return;
        }

        // Zona derecha
        if (mouseX > xCentro + 120) {
          cambiarModoFinal(1);
          return;
        }

        // Centro: entrar al modo seleccionado
        ejecutarOpcionFinalJuego1();
        return;
      }

      ejecutarOpcionFinalJuego1();
      return;
    }
  }
}

// ==========================
// EJECUTAR OPCIÓN DEL MENÚ FINAL
// ==========================
void ejecutarOpcionFinalJuego1() {
  if (opcionesFinalJuego1 == null || opcionesFinalJuego1.length == 0) {
    return;
  }

  if (!opcionesFinalActivasJuego1[opcionFinalJuego1]) {
    feedback = "Opción bloqueada";
    tiempoFeedback = 60;
    return;
  }

  int opcionElegida = opcionFinalJuego1;
  int accion = accionesFinalJuego1[opcionFinalJuego1];

  // Selector de modo
  if (opcionElegida == 1) {
    if (modoEstaDesbloqueado(modoFinalSeleccionado)) {
      estadoFinal = 0;
      estadoPausa = 0;
      opcionFinal = 0;
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
  opcionFinal = 0;
  opcionFinalJuego1 = 0;

  if (accion == ACCION_REINTENTAR_MODO_ACTUAL) {
    iniciarModoJuego1(modoActual);
  }

  else if (accion == ACCION_VOLVER_MENU) {
    pantalla = 1;
  }

  else if (accion == ACCION_VER_NIVELES) {
    pantalla = 3;
  }
}

// ==========================
// SELECTOR DE MODO EN PAUSA
// ==========================

int modoPausaSeleccionado = MODO_FACIL;

// 0 = continuar
// 1 = reiniciar modo actual
// 2 = selector de modo, si ya se desbloqueó Ver Niveles
// 3 = volver al menú, si ya se desbloqueó Ver Niveles
//
// Antes de desbloquear Ver Niveles:
// 0 = continuar
// 1 = reiniciar modo actual
// 2 = volver al menú

int totalOpcionesPausaJuego1() {
  if (verNivelesDesbloqueado) {
    return 4;
  }

  return 3;
}

void cambiarModoPausa(int direccion) {
  modoPausaSeleccionado += direccion;

  if (modoPausaSeleccionado < 0) {
    modoPausaSeleccionado = TOTAL_MODOS - 1;
  }

  if (modoPausaSeleccionado >= TOTAL_MODOS) {
    modoPausaSeleccionado = 0;
  }
}

void cambiarModoFinal(int direccion) {
  modoFinalSeleccionado += direccion;

  if (modoFinalSeleccionado < 0) {
    modoFinalSeleccionado = TOTAL_MODOS - 1;
  }

  if (modoFinalSeleccionado >= TOTAL_MODOS) {
    modoFinalSeleccionado = 0;
  }
}

void controlarPausaJuego1Teclado() {
  int total = totalOpcionesPausaJuego1();

  if (keyCode == UP) {
    opcionPausa--;

    if (opcionPausa < 0) {
      opcionPausa = total - 1;
    }
  }

  else if (keyCode == DOWN) {
    opcionPausa++;

    if (opcionPausa >= total) {
      opcionPausa = 0;
    }
  }

  else if (verNivelesDesbloqueado && opcionPausa == 2 && keyCode == LEFT) {
    cambiarModoPausa(-1);
  }

  else if (verNivelesDesbloqueado && opcionPausa == 2 && keyCode == RIGHT) {
    cambiarModoPausa(1);
  }

  else if (key == ' ' || keyCode == ENTER) {
    ejecutarOpcionPausaJuego1();
  }
}

void controlarPausaJuego1Mouse() {
  int total = totalOpcionesPausaJuego1();

  int ancho = 430;
  int alto = 42;
  int xCentro = width / 2;
  int yInicial = height / 2 - 10;
  int espacioY = 55;

  for (int i = 0; i < total; i++) {
    int y = yInicial + i * espacioY;

    if (
      mouseX > xCentro - ancho / 2 &&
      mouseX < xCentro + ancho / 2 &&
      mouseY > y - alto / 2 &&
      mouseY < y + alto / 2
    ) {
      opcionPausa = i;

      // Si hizo click en la opción Modo [...]
      if (verNivelesDesbloqueado && opcionPausa == 2) {

        // Botón izquierdo <
        if (mouseX < xCentro - 120) {
          cambiarModoPausa(-1);
          return;
        }

        // Botón derecho >
        if (mouseX > xCentro + 120) {
          cambiarModoPausa(1);
          return;
        }

        // Si hace click en el centro, entra al modo seleccionado
        ejecutarOpcionPausaJuego1();
        return;
      }

      ejecutarOpcionPausaJuego1();
      return;
    }
  }
}

void ejecutarOpcionPausaJuego1() {

  // Continuar
  if (opcionPausa == 0) {
    estadoPausa = 0;
  }

  // Reiniciar modo actual
  else if (opcionPausa == 1) {
    estadoPausa = 0;
    reiniciarModoActual();
  }

  // Si Ver Niveles ya está desbloqueado,
  // la opción 2 es el selector de modo.
  else if (verNivelesDesbloqueado && opcionPausa == 2) {
    estadoPausa = 0;
    iniciarModoJuego1(modoPausaSeleccionado);
  }

  // Volver al menú cuando Ver Niveles está desbloqueado
  else if (verNivelesDesbloqueado && opcionPausa == 3) {
    estadoPausa = 0;
    pantalla = 1;
  }

  // Volver al menú antes de desbloquear Ver Niveles
  else if (!verNivelesDesbloqueado && opcionPausa == 2) {
    estadoPausa = 0;
    pantalla = 1;
  }
}
