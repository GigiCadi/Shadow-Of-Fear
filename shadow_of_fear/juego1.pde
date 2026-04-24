// ==========================
// NIVEL 1 - CIBERBULLYING
// ==========================

// ---------- ESTADO ----------
int estadoEmocion = 0;
int indiceMensaje = 0;
boolean nivel1Terminado = false;

String feedback = "";
int tiempoFeedback = 0;
String[] usuariosComentarios;

// 1 = eliminar, 2 = reemplazar
int[] accionCorrecta = {2, 2, 2, 2};

// índice de palabra ofensiva correcta
int[] palabraCorrecta = {1, 0, 0, 1};

// ---------- MENSAJES ----------
String[] mensajes = {
  "Eres raro",
  "Nadie te quiere",
  "No encajas",
  "Eres inutil"
};

String[] respuestas = {
  "Eres unico",
  "Todos te quieren",
  "Si encajas",
  "Eres capaz"
};

// ---------- WORDBANK ----------
String[] bancoPalabras = {
  "unico", "todos", "si", "capaz"
};

// ---------- DINÁMICAS ----------
String[] palabrasActuales;
int palabraSeleccionada = -1;
int palabraBancoSeleccionada = -1;

// ---------- DIFICULTAD ----------
float mensajeX = 610;
float mensajeY = 330;
float mensajeAncho = 500;
float interlineadoMensaje = 30;

int maxMensajesVisibles = 3;
float comentarioX = 605;
float comentarioYInicial = 315;
float comentarioAncho = 470;
float espacioEntreComentarios = 85;

float comentarioTextSize = 18;

// ---------- ESPERA ENTRE MENSAJES ----------
boolean esperandoSiguienteMensaje = false;
int temporizadorSiguienteMensaje = 0;


// ==========================
// INICIAR NIVEL
// ==========================
void iniciarNivel1() {
  estadoEmocion = 0;
  indiceMensaje = 0;
  nivel1Terminado = false;
  feedback = "";
  tiempoFeedback = 0;
  esperandoSiguienteMensaje = false;
  temporizadorSiguienteMensaje = 0;
  generarUsuariosAnonimos();
  cargarMensaje();
}


// ==========================
// NIVEL DIFÍCIL
// ==========================
void iniciarNivel1Dificil() {
  iniciarNivel1();

  if (dificultadNivel1 == 1) {
    mensajes = new String[] {
      "No mereces respeto",
      "Eres incapaz de aprender",
      "No puedes mejorar",
      "Eres debil ante los problemas",
      "No tienes derecho a opinar",
      "Nadie aprecia tu esfuerzo"
    };

    respuestas = new String[] {
      "Mereces respeto",
      "Eres capaz de aprender",
      "Puedes mejorar",
      "Eres fuerte ante los problemas",
      "Tienes derecho a opinar",
      "Todos aprecian tu esfuerzo"
    };

    bancoPalabras = new String[] {
      "capaz",
      "fuerte",
      "todos",
      "valioso",
      "importante",
      "respetan"
    };

    accionCorrecta = new int[] {1, 2, 1, 2, 1, 2};
    palabraCorrecta = new int[] {0, 1, 0, 1, 0, 0};
  }
  else if (dificultadNivel1 == 2) {
    mensajes = new String[] {
      "No deberias expresar tus ideas",
      "Eres incapaz de resolver problemas complejos",
      "No mereces participar en el grupo",
      "Nadie valora tu esfuerzo constante",
      "No puedes aprender cosas nuevas",
      "Eres debil frente a la presion"
    };

    respuestas = new String[] {
      "Deberias expresar tus ideas",
      "Eres capaz de resolver problemas complejos",
      "Mereces participar en el grupo",
      "Todos valoran tu esfuerzo constante",
      "Puedes aprender cosas nuevas",
      "Eres fuerte frente a la presion"
    };

    bancoPalabras = new String[] {
      "capaz",
      "todos",
      "fuerte",
      "importante",
      "creativo",
      "valioso"
    };

    accionCorrecta = new int[] {1, 2, 1, 2, 1, 2};
    palabraCorrecta = new int[] {0, 1, 0, 0, 0, 1};
  }
  generarUsuariosAnonimos();
  cargarMensaje();
}


// ==========================
// CARGAR MENSAJE
// ==========================
void cargarMensaje() {
  if (indiceMensaje < mensajes.length) {
    palabrasActuales = split(mensajes[indiceMensaje], " ");
    palabraSeleccionada = -1;
    palabraBancoSeleccionada = -1;
  }
}


// ==========================
// PROGRAMAR SIGUIENTE MENSAJE
// ==========================
void programarSiguienteMensaje() {
  esperandoSiguienteMensaje = true;
  temporizadorSiguienteMensaje = 60;
}


void dibujarComentariosScroll() {
  if (mensajes == null || mensajes.length == 0) return;

  int inicio = max(0, indiceMensaje - (maxMensajesVisibles - 1));
  int fin = min(indiceMensaje, mensajes.length - 1);

  int ordenVisible = 0;

  for (int m = inicio; m <= fin; m++) {
    float baseX = comentarioX;
    float baseY = comentarioYInicial + ordenVisible * espacioEntreComentarios;

    String[] palabrasMostrar;

    if (m == indiceMensaje && palabrasActuales != null) {
      palabrasMostrar = palabrasActuales;
    } else {
      palabrasMostrar = split(mensajes[m], " ");
    }

    // ----- NOMBRE DE USUARIO -----
    textAlign(LEFT);
    textSize(14);

    if (m == indiceMensaje) fill(80, 60, 120);
    else fill(110, 90, 145);
text(usuariosComentarios[m], baseX, baseY - 20);

    // ----- MENSAJE -----
    float x = baseX;
    float y = baseY;

    textSize(comentarioTextSize);

    for (int i = 0; i < palabrasMostrar.length; i++) {
      String palabra = palabrasMostrar[i];
      float w = textWidth(palabra + " ");

      if (x + w > baseX + comentarioAncho) {
        x = baseX;
        y += interlineadoMensaje;
      }

      if (m == indiceMensaje && i == palabraSeleccionada) fill(157, 126, 211);
      else if (m == indiceMensaje) fill(101, 70, 155);
      else fill(140, 120, 170);

      text(palabra, x, y);
      x += w;
    }

    ordenVisible++;
  }
}


// ==========================
// OBTENER PALABRA CLICKEADA
// ==========================
int obtenerPalabraClickeada(float mx, float my) {
  if (palabrasActuales == null) return -1;

  int inicio = max(0, indiceMensaje - (maxMensajesVisibles - 1));
  int ordenVisible = indiceMensaje - inicio;

  float baseX = comentarioX;
  float baseY = comentarioYInicial + ordenVisible * espacioEntreComentarios;

  float x = baseX;
  float y = baseY;

  textAlign(LEFT);
  textSize(comentarioTextSize);

  float altoCaja = comentarioTextSize + 8;

  for (int i = 0; i < palabrasActuales.length; i++) {
    String palabra = palabrasActuales[i];
    float w = textWidth(palabra + " ");

    if (x + w > baseX + comentarioAncho) {
      x = baseX;
      y += interlineadoMensaje;
    }

    if (mx >= x && mx <= x + w &&
        my >= y - altoCaja + 4 && my <= y + 6) {
      return i;
    }

    x += w;
  }

  return -1;
}


// ==========================
// DIBUJAR NIVEL
// ==========================
void nivel1() {

  imageMode(CORNER);
  image(fondo3, 0, 0, width, height);
  image(pc, 372, 164, 793, 476);
  image(web, 412, 194, 693, 376);

  // ----- MENSAJE -----
  fill(101, 70, 155);
  dibujarComentariosScroll();

  // ----- BOTONES -----
  imageMode(CENTER);
  image(btneliminar, width/3, height - 70, 470, 94);
  image(btnreemplazar, width - width/3, height - 70, 470, 94);

  // ----- WORDBANK -----
  image(wordbank, width, height/2, 700, 680);

  textAlign(LEFT);
  textSize(20);

  float xWB = width - 250;
  float yWB = height/2 - 200;

  for (int i = 0; i < bancoPalabras.length; i++) {

    if (i == palabraBancoSeleccionada) fill(200, 255, 200);
    else fill(0);

    text(bancoPalabras[i], xWB, yWB + i * 60);
  }

  // ----- BARRA EMOCIONAL -----
  image(emotionbar, 150, height/2, 139, 642);
  image(emojis[estadoEmocion], 150, height/2 + 230, 90, 90);
  dibujarBarras();

  // ----- UI GENERAL -----
  dibujarUI();

  // ----- FEEDBACK -----
  if (tiempoFeedback > 0) {

    textAlign(CENTER);
    textSize(22);

    if (feedback.equals("¡Bien!")) fill(0, 255, 0);
    else fill(255, 0, 0);

    text(feedback, width/2, 100);
    tiempoFeedback--;
  }

  // ----- ESPERA ANTES DE PASAR AL SIGUIENTE MENSAJE -----
  if (esperandoSiguienteMensaje) {
    temporizadorSiguienteMensaje--;

    if (temporizadorSiguienteMensaje <= 0) {
      esperandoSiguienteMensaje = false;
      siguienteMensaje();
    }
  }
}


// ==========================
// MOUSE NIVEL
// ==========================
void mouseNivel1() {
  if (palabrasActuales == null) return;
  if (estadoPausa == 1) return;
  if (estadoFinal != 0) return;
  if (esperandoSiguienteMensaje) return;

  // ----- BOTÓN ELIMINAR -----
  if (mouseX > width/3 - 200 && mouseX < width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {
    eliminarPalabra();
    return;
  }

  // ----- BOTÓN REEMPLAZAR -----
  if (mouseX > width - width/3 - 200 && mouseX < width - width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {
    reemplazarPalabra();
    return;
  }

  // ----- SELECCIONAR WORDBANK -----
  float xWB = width - 250;
  float yWB = height/2 - 200;

  for (int i = 0; i < bancoPalabras.length; i++) {
    if (mouseX > xWB && mouseX < xWB + 220 &&
        mouseY > yWB + i * 60 - 20 && mouseY < yWB + i * 60 + 12) {
      palabraBancoSeleccionada = i;
      return;
    }
  }

  // ----- SELECCIONAR PALABRA DEL COMENTARIO ACTUAL -----
  int palabraClickeada = obtenerPalabraClickeada(mouseX, mouseY);
  if (palabraClickeada != -1) {
    palabraSeleccionada = palabraClickeada;
    return;
  }
}


// ==========================
// ELIMINAR
// ==========================
void eliminarPalabra() {

  if (palabraSeleccionada == -1) {
    feedback = "Selecciona una palabra";
    tiempoFeedback = 60;
    return;
  }

  if (palabraSeleccionada != palabraCorrecta[indiceMensaje]) {
    feedback = "Selecciona la palabra correcta";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  if (accionCorrecta[indiceMensaje] != 1) {
    feedback = "Debes reemplazar, no eliminar";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  // mostrar la frase correcta completa
  palabrasActuales = split(respuestas[indiceMensaje], " ");

  feedback = "¡Bien!";
  tiempoFeedback = 60;
  programarSiguienteMensaje();
}


// ==========================
// REEMPLAZAR
// ==========================
void reemplazarPalabra() {

  if (palabraSeleccionada == -1) {
    feedback = "Selecciona una palabra";
    tiempoFeedback = 60;
    return;
  }

  if (palabraBancoSeleccionada == -1) {
    feedback = "Selecciona una palabra del banco";
    tiempoFeedback = 60;
    return;
  }

  if (palabraSeleccionada != palabraCorrecta[indiceMensaje]) {
    feedback = "Selecciona la palabra ofensiva";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  if (accionCorrecta[indiceMensaje] != 2) {
    feedback = "Debes eliminar, no reemplazar";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  // mostrar la frase correcta completa para evitar errores gramaticales
  palabrasActuales = split(respuestas[indiceMensaje], " ");

  feedback = "¡Bien!";
  tiempoFeedback = 60;
  programarSiguienteMensaje();
}


// ==========================
// SIGUIENTE MENSAJE
// ==========================
void siguienteMensaje() {

  indiceMensaje++;

  palabraSeleccionada = -1;
  palabraBancoSeleccionada = -1;

  if (estadoEmocion >= 4) {
    nivel1Terminado = true;
    estadoFinal = 1;   // derrota
    opcionFinal = 0;
    return;
  }

  if (indiceMensaje >= mensajes.length) {
    nivel1Terminado = true;
    nivel1Completado = true;
    estadoFinal = 2;   // victoria
    opcionFinal = 0;
    return;
  }

  cargarMensaje();
}


// ==========================
// REINICIAR
// ==========================
void reiniciarNivel1() {
  estadoFinal = 0;
  opcionFinal = 0;
  iniciarNivel1();
}


// ==========================
// CONTROL NIVEL 1 (TECLADO)
// ==========================
void controlarNivel1() {

  if (estadoPausa == 1) return;
  if (esperandoSiguienteMensaje) return;

  if (indiceMensaje >= mensajes.length) return;

  if (key == '1') {
    eliminarPalabra();
  }

  if (key == '2') {
    reemplazarPalabra();
  }

  if (keyCode == ESC) {
    key = 0;
    estadoPausa = 1;
    opcionPausa = 0;
  }
}

void generarUsuariosAnonimos() {
  usuariosComentarios = new String[mensajes.length];

  for (int i = 0; i < mensajes.length; i++) {
    int idAnonimo = int(random(1000, 9999));
    usuariosComentarios[i] = "Anonimo" + idAnonimo;
  }
}
