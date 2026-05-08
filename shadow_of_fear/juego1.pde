
// ==========================
// NIVEL 1 - CIBERBULLYING
// ==========================

// ---------- ESTADO ----------
int estadoEmocion = 0;
int indiceMensaje = 0;
boolean nivel1Terminado = false;
int subEstadoJuego1 = 0;
String feedback = "";
int tiempoFeedback = 0;
String[] usuariosComentarios;
String[] comentariosMostrados;

// 1 = eliminar, 2 = reemplazar
int[] accionCorrecta = {2, 2, 2, 2, 2, 2, 2, 2};

// índice de palabra ofensiva correcta
int[] palabraCorrecta = {1, 0, 0, 1, 1, 1, 0, 1};

// ---------- MENSAJES (FÁCIL - 8 mensajes) ----------
String[] mensajes = {
  "Eres rara",
  "Nadie te quiere",
  "No encajas",
  "Eres inutil",
  "Eres fea",
  "Eres tonta",
  "No vales",
  "Eres debil"
};

String[] respuestas = {
  "Eres unica",
  "Todos te quieren",
  "Si encajas",
  "Eres capaz",
  "Eres especial",
  "Eres inteligente",
  "Si vales",
  "Eres fuerte"
};

// ---------- WORDBANK ----------
String[] bancoPalabras = {
  "unica", "todas", "si", "capaz",
  "especial", "inteligente", "fuerte"
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
float comentarioX = 630;
float comentarioYInicial = 315;
float comentarioAncho = 470;
float espacioEntreComentarios = 85;

float comentarioTextSize = 18;

// ---------- ESPERA ENTRE MENSAJES ----------
boolean esperandoSiguienteMensaje = false;
int temporizadorSiguienteMensaje = 0;

String mensajeFinalTitulo = "";
String mensajeFinalSubtexto = "";

String[] mensajesDerrota = {
  "El silencio también deja marcas",
  "Las palabras hieren más de lo que parecen",
  "Lo que se escribe también puede lastimar",
  "Un comentario cruel puede quedarse mucho tiempo",
  "Detrás de una pantalla también hay emociones"
};

String[] subtextosDerrota = {
  "No todo ataque se ve, pero sí se siente.",
  "El ciberacoso no es un juego, deja huellas reales.",
  "Responder tarde también enseña: cada palabra importa.",
  "En internet también se puede cuidar o destruir.",
  "Reflexiona: lo que parece broma puede convertirse en daño."
};

String[] mensajesVictoria = {
  "Hoy frenaste el daño a tiempo",
  "Elegiste transformar el mensaje",
  "Convertiste agresión en apoyo",
  "Tu respuesta cambió el rumbo del comentario",
  "Hoy usaste tus palabras para proteger"
};

String[] subtextosVictoria = {
  "Una respuesta correcta también puede ser un acto de empatía.",
  "En redes, corregir el daño también es tomar postura.",
  "Las palabras pueden herir, pero también reparar.",
  "Actuar frente al ciberacoso cambia la experiencia de otros.",
  "Responder con conciencia también es construir un espacio más sano."
};

String normalizar(String s) {
  s = s.toLowerCase();
  s = s.replace("á", "a").replace("é", "e").replace("í", "i").replace("ó", "o").replace("ú", "u");
  return s;
}
// ==========================
// MEZCLAR MENSAJES (ALEATORIO)
// ==========================
void mezclarMensajes() {
  int n = mensajes.length;

  int[] indices = new int[n];
  for (int i = 0; i < n; i++) indices[i] = i;

  for (int i = n - 1; i > 0; i--) {
    int j = (int) random(i + 1);
    int temp = indices[i];
    indices[i] = indices[j];
    indices[j] = temp;
  }

  String[] nuevosMensajes   = new String[n];
  String[] nuevasRespuestas = new String[n];
  int[]    nuevaAccion      = new int[n];
  int[]    nuevaPalabra     = new int[n];

  for (int i = 0; i < n; i++) {
    nuevosMensajes[i]   = mensajes[indices[i]];
    nuevasRespuestas[i] = respuestas[indices[i]];
    nuevaAccion[i]      = accionCorrecta[indices[i]];
    nuevaPalabra[i]     = palabraCorrecta[indices[i]];
  }

  mensajes        = nuevosMensajes;
  respuestas      = nuevasRespuestas;
  accionCorrecta  = nuevaAccion;
  palabraCorrecta = nuevaPalabra;
}

// ==========================
// INICIAR NIVEL
// ==========================
void iniciarNivel1() {  
  detenerAudiosFinales();
  estadoEmocion = 0;
  indiceMensaje = 0;
  nivel1Terminado = false;
  feedback = "";
  tiempoFeedback = 0;
  esperandoSiguienteMensaje = false;
  temporizadorSiguienteMensaje = 60;
  palabraSeleccionada = -1;
  palabraBancoSeleccionada = -1;
  }

void inicializarComentariosMostrados() {
  comentariosMostrados = new String[mensajes.length];
  for (int i = 0; i < mensajes.length; i++) {
    comentariosMostrados[i] = mensajes[i];
  }
}

void generarMensajeFinal(int tipoFinal) {
  int i;
  if (tipoFinal == 1) {
    i = (int) random(mensajesDerrota.length);
    mensajeFinalTitulo = mensajesDerrota[i];
    mensajeFinalSubtexto = subtextosDerrota[i];
  } else if (tipoFinal == 2) {
    i = (int) random(mensajesVictoria.length);
    mensajeFinalTitulo = mensajesVictoria[i];
    mensajeFinalSubtexto = subtextosVictoria[i];
  }
}

// ==========================
// NIVEL DIFÍCIL
// ==========================
void iniciarNivel1Dificil() {
  iniciarNivel1();

  // FACIL
  if (dificultadNivel1 == 1) {
    mensajes = new String[] {
      "Eres rara",
      "Nadie te quiere",
      "No encajas",
      "Eres inutil",
      "Eres fea",
      "Eres tonta",
      "No vales",
      "Eres debil"
    };

    respuestas = new String[] {
      "Eres unica",
      "Todos te quieren",
      "Encajas",
      "Eres capaz",
      "Eres especial",
      "Eres inteligente",
      "Vales",
      "Eres fuerte"
    };

    bancoPalabras = new String[] {
      "unica", "todos", "capaz", "especial",
      "inteligente", "fuerte", "vales"
    };

    accionCorrecta = new int[] {2, 2, 1, 2, 2, 2, 1, 2};
    palabraCorrecta = new int[] {1, 0, 0, 1, 1, 1, 0, 1};
  }

  // NORMAL
  else if (dificultadNivel1 == 2) {
    mensajes = new String[] {
      "No mereces respeto",
      "Eres incapaz de aprender",
      "No puedes mejorar",
      "Eres debil ante los problemas",
      "No tienes derecho a opinar",
      "Nadie aprecia tu esfuerzo",
      "No deberias expresar tus ideas",
      "Eres inutil resolviendo esto",
      "Nadie valora lo que haces",
      "No puedes lograrlo"
    };

    respuestas = new String[] {
      "Mereces respeto",
      "Eres capaz de aprender",
      "Puedes mejorar",
      "Eres fuerte ante los problemas",
      "Tienes derecho a opinar",
      "Todos aprecian tu esfuerzo",
      "Deberias expresar tus ideas",
      "Eres capaz resolviendo esto",
      "Todos valoran lo que haces",
      "Puedes lograrlo"
    };

    bancoPalabras = new String[] {
      "capaz", "fuerte", "todos", "valiosa",
      "importante", "respetan", "puedes"
    };

    accionCorrecta = new int[] {1, 2, 1, 2, 1, 2, 1, 2, 2, 1};
    palabraCorrecta = new int[] {0, 1, 0, 1, 0, 0, 0, 1, 0, 0};
  }

  // DIFICIL
  else if (dificultadNivel1 == 3) {
    mensajes = new String[] {
      "No deberias expresar tus ideas",
      "Eres incapaz de resolver problemas complejos",
      "No mereces participar en el grupo",
      "Nadie valora tu esfuerzo constante",
      "No puedes aprender cosas nuevas",
      "Eres debil frente a la presion",
      "No tienes nada valioso que aportar",
      "Nadie reconoce lo mucho que te esfuerzas"
    };

    respuestas = new String[] {
      "Deberias expresar tus ideas",
      "Eres capaz de resolver problemas complejos",
      "Mereces participar en el grupo",
      "Todos valoran tu esfuerzo constante",
      "Puedes aprender cosas nuevas",
      "Eres fuerte frente a la presion",
      "Tienes algo valioso que aportar",
      "Todos reconocen lo mucho que te esfuerzas"
    };

    bancoPalabras = new String[] {
      "capaz", "todos", "fuerte", "algo",
      "valiosa", "importante", "reconocen"
    };

    accionCorrecta = new int[] {1, 2, 1, 2, 1, 2, 2, 2};
    palabraCorrecta = new int[] {0, 1, 0, 0, 0, 1, 1, 0};
  }

  mezclarMensajes();
  generarUsuariosAnonimos();
  inicializarComentariosMostrados();
  cargarMensaje();
}

// ==========================
// CARGAR MENSAJE
// ==========================
void cargarMensaje() {
  if (indiceMensaje < comentariosMostrados.length) {
    palabrasActuales = split(comentariosMostrados[indiceMensaje], " ");
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

  int inicio = max(0, indiceMensaje - (maxMensajesVisibles - 1));
  int fin = min(indiceMensaje, mensajes.length - 1);
  int ordenVisible = 0;

  for (int m = inicio; m <= fin; m++) {
    // Verificar que el índice existe
    if (m >= comentariosMostrados.length) {
      continue;
    }
    
    if (m >= usuariosComentarios.length) {
      continue;
    }
    
    float baseX = comentarioX;
    float baseY = comentarioYInicial + ordenVisible * espacioEntreComentarios;

    String[] palabrasMostrar;
    if (m == indiceMensaje && palabrasActuales != null) {
      palabrasMostrar = palabrasActuales;
    } else {
      // Verificar que comentariosMostrados[m] no sea null
      if (comentariosMostrados[m] == null) {
        continue;
      }
      palabrasMostrar = split(comentariosMostrados[m], " ");
    }

    textAlign(LEFT);
    textSize(14);
    if (m == indiceMensaje) fill(80, 60, 120);
    else fill(110, 90, 145);
    text(usuariosComentarios[m], baseX - 20, baseY - 20);

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

void nivel1() { 
  
  
  // ========================================
  // DIBUJAR NIVEL
  // ========================================
  imageMode(CORNER);
  image(fondo3, 0, 0, width, height);
  image(pc, 372, 164, 793, 476);
  image(web, 412, 194, 693, 376);
  fill(101, 70, 155);
  dibujarComentariosScroll();
  imageMode(CENTER);
  dibujarBotonConSombra(btneliminar, width/3, height - 70, 470, 94);
  dibujarBotonConSombra(btnreemplazar, width - width/3, height - 70, 470, 94);
  image(wordbank, width, height/2, 700, 680);
  textAlign(CENTER, CENTER);
  textSize(20);
  textFont(fuente);

  float xWB = width - 170;
  float yWB = height / 2 - 200;

  for (int i = 0; i < bancoPalabras.length; i++) {
    if (i == palabraBancoSeleccionada) {
      fill(155, 125, 210);
    } else {
      fill(55, 40, 100);
    }
    text(bancoPalabras[i], xWB, yWB + i * 60);
  }
  image(emotionbar, 150, height/2, 139, 642);
  image(emojis[estadoEmocion], 150, height/2 + 230, 90, 90);
  dibujarBarras();
  dibujarUI();
  if (tiempoFeedback > 0) {
    dibujarFeedbackJuego1();
    tiempoFeedback--;
  }
  if (esperandoSiguienteMensaje) {
    temporizadorSiguienteMensaje--;
    if (temporizadorSiguienteMensaje <= 0) {
      esperandoSiguienteMensaje = false;
      siguienteMensaje();
    }
  }
}
void dibujarFeedbackJuego1() {
  float x = width / 2;
  float y = 100;

  boolean esBien = feedback.equals("¡Bien!");

  // Calcular el ancho necesario según el texto
  float anchoCaja;
  float altoCaja = 62;  // Alto base
  
  textFont(fuente);
  textSize(16);
  
  if (esBien) {
    anchoCaja = 320;
  } else {
    // Calcular ancho dinámico según el texto
    float anchoTexto = textWidth(feedback);
    // Añadir padding de 60 píxeles
    anchoCaja = anchoTexto + 80;
    // Limitar ancho máximo y mínimo
    anchoCaja = constrain(anchoCaja, 400, 800);
    
    // Si el texto es muy largo, ajustar altura
    if (anchoTexto > 700) {
      altoCaja = 82;
    }
  }

  pushStyle();

  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textFont(fuente);

  // Sombra
  noStroke();
  fill(30, 25, 55, 180);
  rect(x + 5, y + 5, anchoCaja, altoCaja, 10);

  // Fondo morado
  fill(190, 165, 255, 235);
  rect(x, y, anchoCaja, altoCaja, 10);

  // Borde
  stroke(55, 40, 100);
  strokeWeight(4);
  noFill();
  rect(x, y, anchoCaja, altoCaja, 10);

  // Texto
  if (esBien) {
    textSize(22);
  } else {
    textSize(16);
  }

  fill(45, 35, 85);
  text(feedback, x + 3, y + 5);

  fill(245, 235, 255);
  text(feedback, x, y + 4);

  popStyle();
}
// ==========================
// MOUSE NIVEL
// ==========================
void mouseNivel1() {
  if (palabrasActuales == null) return;
  if (estadoPausa == 1) return;
  if (estadoFinal != 0) return;
  if (esperandoSiguienteMensaje) return;

  if (mouseX > width/3 - 200 && mouseX < width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {
    eliminarPalabra();
    return;
  }

  if (mouseX > width - width/3 - 200 && mouseX < width - width/3 + 200 &&
      mouseY > height - 120 && mouseY < height - 20) {
    reemplazarPalabra();
    return;
  }

  float xWB = width - 250;
  float yWB = height/2 - 200;

  for (int i = 0; i < bancoPalabras.length; i++) {
    if (mouseX > xWB && mouseX < xWB + 220 &&
        mouseY > yWB + i * 60 - 20 && mouseY < yWB + i * 60 + 12) {
      palabraBancoSeleccionada = i;
      return;
    }
  }

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
    feedback = "Selecciona la palabra ofensiva correcta";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }
  if (accionCorrecta[indiceMensaje] != 1) {
    feedback = "Para este mensaje debes usar REEMPLAZAR, no eliminar";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }
  // Asignar la respuesta completa
  comentariosMostrados[indiceMensaje] = respuestas[indiceMensaje];
  palabrasActuales = split(comentariosMostrados[indiceMensaje], " ");
  feedback = "¡Bien!";
  tiempoFeedback = 60;
  programarSiguienteMensaje();
}

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
    feedback = "Selecciona la palabra ofensiva correcta";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }
  if (accionCorrecta[indiceMensaje] != 2) {
    feedback = "Para este mensaje debes usar ELIMINAR, no reemplazar";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  // Obtener la palabra esperada del banco (normalizada)
  String palabraEsperada = normalizar(obtenerPalabraCorrectaDelBanco());
  // Obtener la palabra elegida por el jugador (normalizada)
  String palabraElegida = normalizar(bancoPalabras[palabraBancoSeleccionada]);

  if (!palabraElegida.equals(palabraEsperada)) {
    feedback = "Esa no es la palabra correcta para reemplazar";
    tiempoFeedback = 60;
    estadoEmocion++;
    siguienteMensaje();
    return;
  }

  // Asignar la respuesta completa
  comentariosMostrados[indiceMensaje] = respuestas[indiceMensaje];
  palabrasActuales = split(comentariosMostrados[indiceMensaje], " ");
  feedback = "¡Bien!";
  tiempoFeedback = 60;
  programarSiguienteMensaje();
}


String obtenerPalabraCorrectaDelBanco() {
  // Busca cuál palabra del banco aparece en la respuesta correcta
  // pero NO en el mensaje original, para evitar falsos positivos.
  // Esto resuelve casos donde la respuesta tiene distinta longitud
  // que el mensaje original (ej: "No tienes nada..." -> "Tienes algo...").
  String respuestaNorm = normalizar(respuestas[indiceMensaje]);
  String mensajeNorm   = normalizar(mensajes[indiceMensaje]);

  for (String palabra : bancoPalabras) {
    String pNorm = normalizar(palabra);
    boolean enRespuesta = (" " + respuestaNorm + " ").contains(" " + pNorm + " ");
    boolean enOriginal  = (" " + mensajeNorm   + " ").contains(" " + pNorm + " ");
    if (enRespuesta && !enOriginal) return palabra;
  }

  // Fallback: metodo original por indice (funciona cuando las longitudes coinciden)
  String[] palabrasRespuesta = split(respuestas[indiceMensaje], " ");
  int indiceCorrecto = palabraCorrecta[indiceMensaje];
  if (indiceCorrecto >= 0 && indiceCorrecto < palabrasRespuesta.length) {
    return palabrasRespuesta[indiceCorrecto];
  }

  return "";
}

// ==========================
// SIGUIENTE MENSAJE
// ==========================
void siguienteMensaje() {
  indiceMensaje++;
  palabraSeleccionada = -1;
  palabraBancoSeleccionada = -1;

if (estadoEmocion >= 4) {
  terminarModoJuego1(false);
  return;
}

if (indiceMensaje >= mensajes.length) {
  terminarModoJuego1(true);
  return;
}

  cargarMensaje();
}

// ==========================
// REINICIAR
// ==========================
void reiniciarNivel1() {
  reiniciarModoActual();
}


// ==========================
// CONTROL NIVEL 1 (TECLADO)
// ==========================
void controlarNivel1() {
  if (estadoPausa == 1) return;
  if (esperandoSiguienteMensaje) return;
  if (indiceMensaje >= mensajes.length) return;

  if (keyCode == ESC) {
    key = 0;
    estadoPausa = 1;
    opcionPausa = 0;
  }
}

void generarUsuariosAnonimos() {
  usuariosComentarios = new String[mensajes.length];
  for (int i = 0; i < mensajes.length; i++) {
    int idAnonimo = (int)(random(1000, 9999));
    usuariosComentarios[i] = "Anonimo" + idAnonimo;
  }
}

void iniciarJuego1Completo() {
  iniciarModoJuego1(MODO_FACIL);
  subEstado = 0;
  tipoLore = 1;
  paginaLore = 0;
  cargarTextoLore();
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
