// ==========================
// NIVEL 1 - CIBERBULLYING
// ==========================

// ---------- ESTADO ----------
int estadoEmocion = 0;
int indiceMensaje = 0;
boolean nivel1Terminado = false;

String feedback = "";
int tiempoFeedback = 0;

// 1 = eliminar, 2 = reemplazar
int[] accionCorrecta = {1, 2, 2, 1};

// índice de palabra ofensiva correcta
int[] palabraCorrecta = {1, 2, 1, 1};

// ---------- MENSAJES ----------
String[] mensajes = {
  "Eres raro",
  "Nadie te quiere",
  "No encajas",
  "Eres inutil"
};

String[] respuestas = {
  "Todos somos diferentes",
  "Merezco respeto",
  "Si encajo",
  "Soy valioso"
};

// ---------- WORDBANK ----------
String[] bancoPalabras = {
  "genial", "valioso", "capaz", "fuerte"
};

// ---------- DINÁMICAS ----------
String[] palabrasActuales;
int palabraSeleccionada = -1;
int palabraBancoSeleccionada = -1;


// ==========================
// INICIAR NIVEL
// ==========================
void iniciarNivel1() {
  estadoEmocion = 0;
  indiceMensaje = 0;
  nivel1Terminado = false;
  feedback = "";
  tiempoFeedback = 0;
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
// DIBUJAR NIVEL
// ==========================
void nivel1() {

  imageMode(CORNER);
  image(fondo3, 0, 0, width, height);
  image(pc, 372, 164, 793, 476);
  image(web, 412, 194, 693, 376);

  // ----- MENSAJE -----
  fill(255);
  textAlign(LEFT);
  textSize(20);

  if (indiceMensaje < mensajes.length && palabrasActuales != null) {

    float x = 620;
    float y = 350;

    for (int i = 0; i < palabrasActuales.length; i++) {

      if (i == palabraSeleccionada) fill(255, 200, 200);
      else fill(255);

      text(palabrasActuales[i], x, y);
      x += textWidth(palabrasActuales[i] + " ");
    }
  }

  // ----- BOTONES -----
  imageMode(CENTER);
  image(btneliminar, width/3, height - 70, 470, 94);
  image(btnreemplazar, width - width/3, height - 70, 470, 94);

  // ----- WORDBANK -----
  image(wordbank, width, height/2, 700, 680);

  textAlign(LEFT);
  textSize(18);

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
}

// ==========================
// MOUSE NIVEL
// ==========================
void mouseNivel1() {
  if (palabrasActuales == null) return;
  if (estadoPausa == 1) return;

  // ----- SELECCIONAR PALABRA -----
  float x = 620;
  float y = 350;

  for (int i = 0; i < palabrasActuales.length; i++) {

    float w = textWidth(palabrasActuales[i] + " ");

    if (mouseX > x && mouseX < x + w &&
        mouseY > y - 20 && mouseY < y + 10) {

      palabraSeleccionada = i;
    }

    x += w;
  }

  // ----- SELECCIONAR WORDBANK -----
  float xWB = width - 500;
  float yWB = height/2 - 200;

  for (int i = 0; i < bancoPalabras.length; i++) {

    if (mouseX > xWB && mouseX < xWB + 200 &&
        mouseY > yWB + i*40 - 20 && mouseY < yWB + i*40 + 10) {

      palabraBancoSeleccionada = i;
    }
  }

  // ----- BOTÓN ELIMINAR -----
  if (mouseX > width/3 - 200 && mouseX < width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {

    eliminarPalabra();
  }

  // ----- BOTÓN REEMPLAZAR -----
  if (mouseX > width - width/3 - 200 && mouseX < width - width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {

    reemplazarPalabra();
  }
}

// ==========================
// EVALUAR
// ==========================
void evaluarDecision(int decision) {

  if (decision == accionCorrecta[indiceMensaje] &&
      palabraSeleccionada == palabraCorrecta[indiceMensaje]) {

    feedback = "¡Bien!";
  } else {
    estadoEmocion++;
    feedback = "Incorrecto";
  }

  tiempoFeedback = 60;
}
// ==========================
// ELIMINAR
// ==========================
void eliminarPalabra() {

  if (palabraSeleccionada == -1) return;
  
  if (palabraSeleccionada != palabraCorrecta[indiceMensaje]) {
  feedback = "Selecciona la palabra ofensiva";
  tiempoFeedback = 60;
  return;
}
  evaluarDecision(1);

  palabrasActuales = (String[]) splice(palabrasActuales, palabraSeleccionada, 1);

  siguienteMensaje();
}

// ==========================
// REEMPLAZAR
// ==========================
void reemplazarPalabra() {

  if (palabraSeleccionada == -1) return;
  if (palabraBancoSeleccionada == -1) return;

  palabrasActuales[palabraSeleccionada] = bancoPalabras[palabraBancoSeleccionada];

  if (palabraSeleccionada != palabraCorrecta[indiceMensaje]) {
  feedback = "Selecciona la palabra ofensiva";
  tiempoFeedback = 60;
  return;
}

  evaluarDecision(2);

  siguienteMensaje();
}



// ==========================
// SIGUIENTE MENSAJE
// ==========================
void siguienteMensaje() {

  indiceMensaje++;

  if (estadoEmocion >= 4) {
    println("PERDISTE");
    pantalla = 1;
    return;
  }

  if (indiceMensaje >= mensajes.length) {
    nivel1Terminado = true;
    nivel1Completado = true;
    pantalla = 1;
    return;
  }

  cargarMensaje();
}

// ==========================
// REINICIAR
// ==========================
void reiniciarNivel1() {
  iniciarNivel1();
}

// ==========================
// CONTROL NIVEL 1 (TECLADO)
// ==========================
void controlarNivel1() {

  if (estadoPausa == 1) return;

  // evitar errores si ya terminó
  if (indiceMensaje >= mensajes.length) return;

  // OPCIONAL: usar teclado como alternativa al mouse
  if (key == '1') {
    eliminarPalabra();
  }

  if (key == '2') {
    reemplazarPalabra();
  }
}
