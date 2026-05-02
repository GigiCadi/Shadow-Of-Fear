// ==========================
// VARIABLES MENU
// ==========================

int opcionSeleccionada = 0;

String[] opciones = {
  "Iniciar juego",
  "Niveles",
  "Como jugar",
  "Creditos",
  "Configuración", 
  "Salir"
};

// ==========================
// DIBUJAR MENU
// ==========================
void menuPrincipal() {
  pushStyle();  
  
  imageMode(CORNER);

  // Fondo
  image(fondo2, 0, 0, width, height);

  // Logo
  float ancho = logo.width * 0.45;
  float alto = logo.height * 0.45;
  float xLogo = 340 - ancho/2;
  image(logo, xLogo, 40, ancho, alto);
  
  // ← RESTAURAR configuraciones de texto para el menú
  textFont(fuente);
  textAlign(LEFT);
  textSize(18);
  
  int x = 150;
  
  // Opciones
  for (int i = 0; i < opciones.length; i++) {
    int y = 480 + i * 60;

    if (i == 1 && !verNivelesDesbloqueado) {
      fill(120);
    } else {
      fill(255);
    }

    if (i == opcionSeleccionada) {
      text("> " + opciones[i], x, y);
    } else {
      text(opciones[i], x, y);
    }
  }
  
  popStyle();  
}

// ==========================
// CONTROL MENU
// ==========================
void controlarMenu() {

  if (keyCode == UP) {
    opcionSeleccionada--;
    if (opcionSeleccionada < 0) {
      opcionSeleccionada = opciones.length - 1;
    }
  }

  if (keyCode == DOWN) {
    opcionSeleccionada++;
    if (opcionSeleccionada >= opciones.length) {
      opcionSeleccionada = 0;
    }
  }

  if (key == ' ') {
    ejecutarOpcion();
  }
  
}

// ==========================
// ACCIONES
// ==========================
void ejecutarOpcion() {

  // Iniciar juego
  if (opcionSeleccionada == 0) {
iniciarModoJuego1(MODO_FACIL);
iniciarJuego1Completo(); 
  }

  // Niveles
  if (opcionSeleccionada == 1) {
    if (verNivelesDesbloqueado) {
      pantalla = 3;
    }
  }

  // Como jugar
  if (opcionSeleccionada == 2) {
    pantalla = 4;
  }

  // Créditos
  if (opcionSeleccionada == 3) {
    pantalla = 5;
  }

  // Configuración
  if (opcionSeleccionada == 4) {
    pantalla = 6; // o lo que quieras
  }

  // Salir
  if (opcionSeleccionada == 5) {
    exit();
  }
}
