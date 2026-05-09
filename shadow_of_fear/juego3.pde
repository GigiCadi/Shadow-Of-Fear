// ================================================================
// JUEGO 3 - SOMBRA DEL MIEDO
// ================================================================

// ESTADO DEL JUEGO
int j3_estado = 0;        // 0 = jugando, 1 = final trágico, 2 = final intermedio, 3 = final bueno
boolean j3_iniciado = false;
int j3_moral = 0;
int j3_momentoActual = 0;
int j3_opcionSeleccionada = 0;
boolean j3_esperandoInput = true;
boolean j3_mostrandoRespuesta = false;
int j3_timerRespuesta = 0;
final int J3_TIEMPO_RESPUESTA = 130;

// DATOS DEL JUEGO
String[] j3_dialogosBully = {
  "Morton: Oye, Alimaña... ¿a dónde con tanta prisa? A ver si tan valiente ahora sin el rector",
  "Morton: ¿En serio creíste que te ibas a salvar? Ilusa.",
  "Morton: Me causas asco, no debiste haber nacido si quiera",
  "Morton: Da igual lo que hagas. Nadie va a salvarte.",
  "Ali cierra los ojos. Recuerda lo que le dijo su mamá...",
  "Un vecino baja corriendo las escaleras del edificio. Morton se asusta y retrocede."
};

String[][] j3_opciones = {
  {"Acelerar el paso", "Volverse y mirar", "Hacerse la sorda"},
  {"Buscar una salida", "Preguntarle qué quiere", "Mantener silencio"},
  {"Insultar de vuelta", "Decir que no es cierto", "Preguntar por qué es así"},
  {"Enfrentarlo con odio", "Llorar y rogar que pare", "Intentar razonar"},
  {"Gritar pidiendo ayuda", "Intentar huir", "Empujar y correr"},
  {"Decir la verdad", "Decir que no pasa nada", "Quedarse en silencio"}
};

int[][] j3_valoresOpciones = {
  {-1, 0, 1},
  {-1, 1, 0},
  {-2, 0, 2},
  {-2, -1, 1},
  {3, 0, -2},
  {2, -2, -1}
};

String[][] j3_reaccionesBully = {
  {"\"Morton: Detente si no quieres que te vaya peor\"", "\"Morton: Jaja, no eres tan cobarde como pensé\"", "\"Morton: Además de estúpida, sorda\""},
  {"\"Morton: ¿De verdad crees que vas a escapar?\"", "\"Morton: Fácil, que la basura como tú desaparezca\"", "\"Morton: ¿Por qué tan callada? Si hace un rato estabas de sapa con el director\""},
  {"\"Debería romperte la boca a ver si dices lo mismo\"", "\"Morton: Ay tontita, ¿no te miras al espejo?\"", "\"Morton: ¿Por qué? Porque la basura como tú lo merece\""},
  {"\"¿Me vas a pegar? Dale, atrévete\"", "\"Morton: Eso es lo único que sabes hacer\"", "\"Morton: Cállate alimaña tonta\""},
  {"\"Una ventana se abre. Alguien grita: '¿Quién está ahí?'\"", "\"Morton la alcanza y la detiene\"", "\"Morton se recupera y la persigue\""},
  {"\"Morton huye. El vecino acompaña a Ali a casa\"", "\"Morton se ríe y se va. Ali se queda sola\"", "\"El vecino se va confundido\""}
};

// prota[0]=Aliviada  prota[1]=Arrodillada  prota[2]=Asustada
// prota[3]=Corre     prota[4]=Depresiva    prota[5]=llora  prota[6]=Ira
int[] j3_bullySprite = {0, 0, 2, 2, 1, 0};

// Sprite base de Ali por momento (mientras escucha al bully y elige)
int[] j3_protaSprite = {
  2,  
  2,  
  4,  
  4,  
  0,  
  0  

int[][] j3_protaSpriteReaccion = {
  {3, 2, 2},   // momento 1: A=Acelerar→Corre  B=Volverse→Asustada  C=Hacerse sorda→Asustada
  {3, 2, 4},   // momento 2: A=Buscar salida→Corre  B=Preguntar→Asustada  C=Silencio→Depresiva
  {6, 4, 2},   // momento 3: A=Insultar→asustada  B=Decir que no→Depresiva  C=Preguntar por qué→Asustada
  {6, 5, 2},   // momento 4: A=Enfrentar con odio→Ira  B=Llorar→Llora  C=Razonar→Asustada
  {0, 3, 3},   // momento 5: A=Gritar ayuda→Aliviada  B=Huir→Corre  C=Empujar y correr→Corre
  {0, 4, 4}    // momento 6: A=Decir verdad→Aliviada  B=No pasa nada→Depresiva  C=Silencio→Depresiva
};

// PANTALLA FINAL
int opcionFinalJuego3 = 0;
String[] opcionesFinalJuego3 = {"Volver a intentar", "Volver al menú"};

// ================================================================
// INICIALIZAR
// ================================================================
void iniciarJuego3() {
  reiniciarLore(); 
  j3_estado = 0;
  j3_iniciado = true;
  j3_moral = 0;
  j3_momentoActual = 0;
  j3_opcionSeleccionada = 0;
  j3_esperandoInput = true;
  j3_mostrandoRespuesta = false;
  j3_timerRespuesta = 0;
  
  estadoPausa = 0;
  estadoFinal = 0;
  pantalla = 7;
}

// ================================================================
// PANTALLA PRINCIPAL
// ================================================================
void nivelJuego3() {
  if (!j3_iniciado) return;
  
  // Dibujar fondo UNA SOLA VEZ
  imageMode(CORNER);
  if (juego3 != null) {
    image(juego3, 0, 0, width, height);
  } else {
    background(20, 15, 35);
  }
  
  if (j3_estado == 0) {
    dibujarContenidoJuego3();
  } else {
    dibujarFinalJuego3();
  }
  
  dibujarUI();
}

// ================================================================
// DIBUJAR CONTENIDO DEL JUEGO (escenas y diálogos)
// ================================================================
void dibujarContenidoJuego3() {
  pushStyle();
  
  float centroX = width / 2;
  float centroY = height / 2;
  
  // ESCENA INICIAL (momento 0)
  if (j3_momentoActual == 0) {
    imageMode(CENTER);
    if (bullyParado != null) {
      image(bullyParado, centroX + 280, height - 220, 420, 510);
    }
    
    if (aliEspaldas != null) {
      image(aliEspaldas, centroX + 50, height - 320, 120, 158);
    }
    // Texto narrativo
    fill(0, 0, 0, 200);
    noStroke();
    rect(0, height - 280, width, 280);
    
    fill(245, 235, 255);
    textFont(fuente);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Ali sale de la escuela. El sol se oculta. Camina sola...", width/2, height - 200);
    text("Escucha pasos detrás de ella. Alguien la sigue...", width/2, height - 155);
    
    textSize(14);
    fill(190, 165, 255);
    text("Presiona cualquier tecla o haz clic para continuar", width/2, height - 90);
    
    popStyle();
    return;
  }
  // DIÁLOGOS Y OPCIONES 
  int index = j3_momentoActual - 1;
  
  if (index < 0 || index >= j3_dialogosBully.length) {
    popStyle();
    return;
  }
  
  float altoFranja = height * 0.32;
  float yFranja = height - altoFranja;
  
  if (j3_bullySprite[index] >= 0 && bully[j3_bullySprite[index]] != null) {
    imageMode(CENTER);
    image(bully[j3_bullySprite[index]], centroX, centroY + 140, 620, 710);
  }
  int spriteProta;
  
  // Fondo UI
  fill(0, 0, 0, 200);
  noStroke();
  rect(0, yFranja, width, altoFranja);
  
  // Línea divisoria
  float xDivisor = width/2 - 200;
  stroke(150, 100, 200);
  strokeWeight(1);
  line(xDivisor, yFranja + 20, xDivisor, height - 20);
  noStroke();
  
  // Opciones
  float xIzq = xDivisor - 530;
  float yTitulo = yFranja + 35;
  
  fill(245, 235, 255);
  textSize(18);
  textAlign(LEFT, TOP);
  text("¿QUÉ HARÁS?", xIzq, yTitulo);
  
  float yOpcion = yTitulo + 50;
  float espacioOpcion = 45;
  
  for (int i = 0; i < 3; i++) {
    String letra = (i == 0 ? "A" : i == 1 ? "B" : "C");
    String textoOpcion = j3_opciones[index][i];
    
    if (i == j3_opcionSeleccionada && j3_esperandoInput && !j3_mostrandoRespuesta) {
      fill(190, 165, 255);
      text("> " + letra + ". " + textoOpcion, xIzq, yOpcion + i * espacioOpcion);
    } else {
      fill(180, 170, 200);
      text("  " + letra + ". " + textoOpcion, xIzq, yOpcion + i * espacioOpcion);
    }
  }
  
  // Diálogo del bully
  float xDer = xDivisor + 40;
  float yDer = yFranja + 50;
  float anchoTexto = width - xDer - 380;
  
  fill(245, 235, 255);
  textSize(16);
  textAlign(LEFT, TOP);
  
  String dialogo = j3_dialogosBully[index];
  if (j3_mostrandoRespuesta && j3_timerRespuesta > 0) {
    dialogo = j3_reaccionesBully[index][j3_opcionSeleccionada];
  }
  
  String[] lineas = dividirTexto(dialogo, anchoTexto);
  float yLinea = yDer;
  for (int i = 0; i < lineas.length; i++) {
    text(lineas[i], xDer, yLinea + i * 28);
  }
    if (j3_mostrandoRespuesta && j3_timerRespuesta > 0) {
    spriteProta = j3_protaSpriteReaccion[index][j3_opcionSeleccionada];
  } else {
    spriteProta = j3_protaSprite[index];
  }
  if (spriteProta >= 0 && prota[spriteProta] != null) {
    imageMode(CENTER);
    image(prota[spriteProta], width-180, height-120, 400, 450);
  }
  
  // Timer para respuesta
  if (j3_mostrandoRespuesta && j3_timerRespuesta > 0) {
    j3_timerRespuesta--;
    if (j3_timerRespuesta <= 0) {
      j3_mostrandoRespuesta = false;
      j3_momentoActual++;
      
      if (j3_momentoActual > j3_dialogosBully.length) {
        evaluarFinalJuego3();
      } else {
        j3_esperandoInput = true;
      }
    }
  }
  
  popStyle();
}

// ================================================================
// FUNCIONES AUXILIARES
// ================================================================
String[] dividirTexto(String texto, float anchoMax) {
  ArrayList<String> lineas = new ArrayList<String>();
  String[] palabras = split(texto, " ");
  String linea = "";
  
  textSize(16);
  for (int i = 0; i < palabras.length; i++) {
    String prueba = linea + (linea.equals("") ? "" : " ") + palabras[i];
    if (textWidth(prueba) > anchoMax) {
      lineas.add(linea);
      linea = palabras[i];
    } else {
      linea = prueba;
    }
  }
  if (!linea.equals("")) lineas.add(linea);
  
  return lineas.toArray(new String[0]);
}

void procesarDecisionJuego3(int opcion) {
  if (!j3_esperandoInput || j3_mostrandoRespuesta) return;
  
  int index = j3_momentoActual - 1;
  if (index < 0 || index >= j3_dialogosBully.length) return;
  
  j3_opcionSeleccionada = opcion;
  j3_moral += j3_valoresOpciones[index][opcion];
  
  j3_esperandoInput = false;
  j3_mostrandoRespuesta = true;
  j3_timerRespuesta = J3_TIEMPO_RESPUESTA;
}

void evaluarFinalJuego3() {
  if (j3_moral < 0) {
    j3_estado = 1;
  } else if (j3_moral <= 6) {
    j3_estado = 2;
  } else {
    j3_estado = 3;
  }
}
// ================================================================
// PANTALLA FINAL
// ================================================================
void dibujarFinalJuego3() {
  pushStyle();
  
  // ============================================================
  // IMAGEN DE FONDO SEGÚN EL FINAL 
  // ============================================================
  imageMode(CORNER);
  
  if (j3_estado == 3 && fondoFinalBueno != null) {
    tint(255, 255);  
    image(fondoFinalBueno, 0, 0, width, height);
    noTint();
  } 
  else if (j3_estado == 2 && fondoFinalMedio != null) {
    tint(255, 255);  
    image(fondoFinalMedio, 0, 0, width, height);
    noTint();
  } 
  else if (j3_estado == 1 && fondoFinalMalo != null) {
    tint(255, 255);  
    image(fondoFinalMalo, 0, 0, width, height);
    noTint();
  }
  
  // Capa oscura semitransparente 
  fill(0, 120);
  rect(0, 0, width, height);
  
  textFont(fuente);
  textAlign(CENTER, CENTER);
  
  if (j3_estado == 1) {
    fill(255, 80, 80);
    textSize(28);
    text("FINAL TRÁGICO", width/2, height/2 - 150);
    fill(230, 200, 200);
    textSize(16);
    text("Ali llega a casa llorando. No le cuenta nada a nadie.", width/2, height/2 - 90);
    text("El bullying continúa...", width/2, height/2 - 60);
    fill(255, 200, 100);
    textSize(14);
    text("\"El silencio alimenta el miedo. Habla con alguien\"", width/2, height/2 - 20);
    if (musicaNivel3.isPlaying()) musicaNivel3.stop();
    if (victoria.isPlaying()) victoria.stop();
    if (!derrota.isPlaying()) derrota.loop();
  } 
  else if (j3_estado == 2) {
    fill(255, 200, 80);
    textSize(28);
    text("FINAL INTERMEDIO", width/2, height/2 - 150);
    fill(230, 230, 200);
    textSize(16);
    text("Ali logra llegar a casa sola. Le cuenta a su mamá lo que pasó.", width/2, height/2 - 90);
    text("Buscará ayuda mañana.", width/2, height/2 - 60);
    fill(255, 200, 100);
    textSize(14);
    text("\"Pedir ayuda es el primer paso para sanar\"", width/2, height/2 - 20);
    if (musicaNivel3.isPlaying()) musicaNivel3.stop();
    if (!victoria.isPlaying()) victoria.loop();
    if (derrota.isPlaying()) derrota.stop();
  } 
  else if (j3_estado == 3) {
    fill(120, 255, 160);
    textSize(28);
    text("FINAL BUENO", width/2, height/2 - 150);
    fill(200, 230, 200);
    textSize(16);
    text("Ali es acompañada a casa por el vecino. Decide hablar con un adulto.", width/2, height/2 - 90);
    text("El bullying se detiene.", width/2, height/2 - 60);
    fill(255, 200, 100);
    textSize(14);
    text("\"Hablar con alguien de confianza rompe el ciclo del acoso\"", width/2, height/2 - 20);
    if (musicaNivel3.isPlaying()) musicaNivel3.stop();
   
    if (!victoria.isPlaying()) victoria.loop();
    if (derrota.isPlaying()) derrota.stop();
  }
  
  int yBase = height/2 + 60;
  int espacioY = 55;
  
  for (int i = 0; i < opcionesFinalJuego3.length; i++) {
    int yOpc = yBase + i * espacioY;
    
    if (i == opcionFinalJuego3) {
      fill(190, 165, 255);
      text("> " + opcionesFinalJuego3[i], width/2, yOpc);
    } else {
      fill(245, 235, 255);
      text(opcionesFinalJuego3[i], width/2, yOpc);
    }
  }
  
  popStyle();
}
// ================================================================
// CONTROL POR MOUSE
// ================================================================
void mouseJuego3() {
  if (j3_estado != 0) {
    int yBase = height/2 + 60;
    int espacioY = 55;
    
    if (mouseX > width/2 - 220 && mouseX < width/2 + 220 &&
        mouseY > yBase - 22 && mouseY < yBase + 22) {
      iniciarJuego3();
      return;
    }
    if (mouseX > width/2 - 220 && mouseX < width/2 + 220 &&
        mouseY > yBase + espacioY - 22 && mouseY < yBase + espacioY + 22) {
      j3_estado = 0;
      j3_iniciado = false;
      estadoPausa = 0;
      pantalla = 1;
    }
    return;
  }
  
  // Avanzar escena inicial
  if (j3_momentoActual == 0) {
    j3_momentoActual = 1;
    return;
  }
  
  // Seleccionar opción
  if (!j3_mostrandoRespuesta && j3_esperandoInput) {
    float altoFranja = height * 0.32;
    float yFranja = height - altoFranja;
    float xDivisor = width * 0.45;
    float xIzq = xDivisor - 480;
    float yOpcion = yFranja + 85;
    float espacioOpcion = 45;
    float anchoOpt = 350;
    
    for (int i = 0; i < 3; i++) {
      float yOpt = yOpcion + i * espacioOpcion;
      if (mouseX > xIzq - 20 && mouseX < xIzq + anchoOpt &&
          mouseY > yOpt - 18 && mouseY < yOpt + 18) {
        procesarDecisionJuego3(i);
        return;
      }
    }
  }
}
// CONTROL POR TECLADO
void controlarJuego3Teclado() {
  // Pantalla de final
  if (j3_estado != 0) {
    if (keyCode == UP) {
      opcionFinalJuego3--;
      if (opcionFinalJuego3 < 0) opcionFinalJuego3 = opcionesFinalJuego3.length - 1;
    }
    else if (keyCode == DOWN) {
      opcionFinalJuego3++;
      if (opcionFinalJuego3 >= opcionesFinalJuego3.length) opcionFinalJuego3 = 0;
    }
    else if (key == ' ' || keyCode == ENTER) {
      if (opcionFinalJuego3 == 0) iniciarJuego3();
      else if (opcionFinalJuego3 == 1) {
        j3_estado = 0;
        j3_iniciado = false;
        pantalla = 1;
      }
    }
    return;
  }
  if (keyCode == ESC) {
    pantallaOrigen = 7;
    estadoPausa = 1;
    opcionPausa = 0;
    tipoPausa = 2;
    key = 0;
    return;
  }
  if (j3_momentoActual == 0) {
    j3_momentoActual = 1;
    key = 0;
    return;
  }
  if (!j3_mostrandoRespuesta && j3_esperandoInput) {
    if (keyCode == UP) {
      j3_opcionSeleccionada--;
      if (j3_opcionSeleccionada < 0) j3_opcionSeleccionada = 2;
    }
    else if (keyCode == DOWN) {
      j3_opcionSeleccionada++;
      if (j3_opcionSeleccionada > 2) j3_opcionSeleccionada = 0;
    }
    else if (key == ' ' || keyCode == ENTER) {
      procesarDecisionJuego3(j3_opcionSeleccionada);
    }
  }
}

// CONTROL DE PAUSA
void controlarPausaJuego3Teclado() {
  String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};
  
  if (keyCode == UP) {
    opcionPausa--;
    if (opcionPausa < 0) opcionPausa = opciones.length - 1;
  }
  else if (keyCode == DOWN) {
    opcionPausa++;
    if (opcionPausa >= opciones.length) opcionPausa = 0;
  }
  else if (key == ' ' || keyCode == ENTER) {
    if (opcionPausa == 0) {
      estadoPausa = 0;
    }
    else if (opcionPausa == 1) {
      estadoPausa = 0;
      iniciarJuego3();
    }
    else if (opcionPausa == 2) {
      estadoPausa = 0;
      pantalla = 1;
    }
  }
}

void controlarPausaJuego3Mouse() {
  String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};
  int ancho = 430;
  int alto = 42;
  int xCentro = width / 2;
  int yInicial = height / 2 - 10;
  int espacioY = 55;

  for (int i = 0; i < opciones.length; i++) {
    int y = yInicial + i * espacioY;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y - alto/2 && mouseY < y + alto/2) {
      opcionPausa = i;
      if (i == 0) estadoPausa = 0;
      else if (i == 1) {
        estadoPausa = 0;
        iniciarJuego3();
      }
      else if (i == 2) {
        estadoPausa = 0;
        pantalla = 1;
      }
      return;
    }
  }
}
