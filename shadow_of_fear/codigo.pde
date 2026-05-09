// ========================================
// PANTALLA DE CÓDIGO
// ========================================

int paginaCodigo = 0;
int totalPaginasCodigo = 6;

String[][] textosCodigo = {
  {
    "HOLA, SOY RUTH. YO TRABAJÉ CON LAS CADENAS DE TEXTO.",
    "",
    "EN NUESTRO JUEGO, TODO LO QUE LEE EL JUGADOR SON",
    "CADENAS. YO ME ENCARGUÉ DE CREAR LOS MENSAJES",
    "OFENSIVOS, LAS RESPUESTAS POSITIVAS, LOS DIÁLOGOS",
    "DEL BULLY Y LOS TEXTOS DEL LORE."
  },
  {
    "GRACIAS A LAS CADENAS, EL JUEGO PUEDE MOSTRAR",
    "FRASES, COMPARAR RESPUESTAS Y SABER SI EL",
    "JUGADOR ELIGIÓ LA OPCIÓN CORRECTA.",
    "",
    "SIN ELLAS, SOLO HABRÍA NÚMEROS EN PANTALLA."
  },
  {
    "HOLA, SOY GILARYS. YO ORGANICÉ LA INFORMACIÓN",
    "CON ARREGLOS Y ESTRUCTURÉ EL JUEGO CON FUNCIONES.",
    "",
    "LOS ARREGLOS ME PERMITIERON AGRUPAR DATOS",
    "SIMILARES: TODOS LOS MENSAJES OFENSIVOS VAN",
    "JUNTOS, TODAS LAS RESPUESTAS BUENAS TAMBIÉN.",
    "ASÍ ES MÁS FÁCIL ACCEDER A ELLOS CUANDO LOS",
    "NECESITAMOS."
  },
  {
    "LAS FUNCIONES, POR OTRO LADO, ME AYUDARON A",
    "DIVIDIR EL CÓDIGO EN PARTES PEQUEÑAS. CADA",
    "PANTALLA TIENE SU PROPIA FUNCIÓN: EL MENÚ, EL",
    "JUEGO, LOS CRÉDITOS. ESTO HACE QUE EL PROGRAMA",
    "SEA MÁS LIMPIO Y FÁCIL DE MODIFICAR."
  },
  {
    "HOLA, SOY NASHED. YO ME ENCARGUÉ DE QUE LOS",
    "PERSONAJES COBREN VIDA CON VECTORES Y SPRITES.",
    "",
    "LOS VECTORES SON ARREGLOS ESPECIALES QUE GUARDAN",
    "MÚLTIPLES IMÁGENES. CADA PERSONAJE TIENE SU",
    "PROPIO VECTOR CON TODAS SUS POSICIONES: CAMINANDO",
    "ARRIBA, ABAJO, IZQUIERDA, DERECHA."
  },
  {
    "LOS SPRITES SON CADA UNA DE ESAS IMÁGENES.",
    "YO LAS ORDENÉ PARA QUE CAMBIEN RÁPIDAMENTE",
    "CUANDO EL PERSONAJE SE MUEVE. ASÍ, EL JUGADOR",
    "NO VE IMÁGENES FIJAS, SINO UNA ANIMACIÓN FLUIDA",
    "QUE HACE LA EXPERIENCIA MÁS REAL."
  }
};

void pantallaCodigo() {
  imageMode(CORNER);
  
  // Fondo
  if (fondoCodigo != null) {
    image(fondoCodigo, 0, 0, width, height);
  } else {
    background(30, 25, 55);
  }
  
  imageMode(CENTER);
  
  // Página 0
  if (paginaCodigo == 0) {
    if (personajeRuth != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeRuth.height * (tamanoX / personajeRuth.width);
      image(personajeRuth, width * 0.2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.3;
    float yTexto = height * 0.25;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 280, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[0].length; i++) {
      fill(255);
      text(textosCodigo[0][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Página 1
  if (paginaCodigo == 1) {
    if (personajeRuth2 != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeRuth2.height * (tamanoX / personajeRuth2.width);
      image(personajeRuth2, width / 2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.2;
    float yTexto = height * 0.12;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 200, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[1].length; i++) {
      fill(255);
      text(textosCodigo[1][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Página 2
  if (paginaCodigo == 2) {
    if (personajeGigi != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeGigi.height * (tamanoX / personajeGigi.width);
      image(personajeGigi, width * 0.2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.3;
    float yTexto = height * 0.25;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 300, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[2].length; i++) {
      fill(255);
      text(textosCodigo[2][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Página 3
  if (paginaCodigo == 3) {
    if (personajeGigi2 != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeGigi2.height * (tamanoX / personajeGigi2.width);
      image(personajeGigi2, width / 2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.2;
    float yTexto = height * 0.12;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 220, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[3].length; i++) {
      fill(255);
      text(textosCodigo[3][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Página 4
  if (paginaCodigo == 4) {
    if (personajeNashedCreditos != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeNashedCreditos.height * (tamanoX / personajeNashedCreditos.width);
      image(personajeNashedCreditos, width * 0.2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.3;
    float yTexto = height * 0.25;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 300, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[4].length; i++) {
      fill(255);
      text(textosCodigo[4][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Página 5
  if (paginaCodigo == 5) {
    if (personajeNashed != null) {
      float tamanoX = width * 0.55;
      float tamanoY = personajeNashed.height * (tamanoX / personajeNashed.width);
      image(personajeNashed, width / 2, height * 0.8, tamanoX, tamanoY);
    }
    
    float anchoTexto = width * 0.6;
    float xTexto = width * 0.2;
    float yTexto = height * 0.12;
    
    fill(0, 0, 0, 200);
    noStroke();
    rectMode(CORNER);
    rect(xTexto - 20, yTexto - 20, anchoTexto + 40, 220, 15);
    
    textFont(fuente);
    textSize(18);
    textAlign(LEFT, TOP);
    
    float yLinea = yTexto;
    for (int i = 0; i < textosCodigo[5].length; i++) {
      fill(255);
      text(textosCodigo[5][i], xTexto, yLinea + i * 28);
    }
  }
  
  // Botón volver
  imageMode(CENTER);
  dibujarBotonConSombra(btnvolver, width - 140, 40, 250, 64);
  
  // Botón siguiente
  if (paginaCodigo < totalPaginasCodigo - 1) {
    dibujarBotonConSombra(btnext, width - 140, height - 40, 250, 64);
  }
  
  // Botón anterior
  if (paginaCodigo > 0) {
    dibujarBotonConSombra(btnback, 140, height - 40, 250, 64);
  }
}

void controlarCodigo() {
  float radioX = 125;
  float radioY = 32;
  
  // BOTÓN VOLVER
  if (mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > 40 - radioY && mouseY < 40 + radioY) {
    pantalla = 1;
    return;
  }
  
  // BOTÓN SIGUIENTE
  if (paginaCodigo < totalPaginasCodigo - 1 &&
      mousePressed &&
      mouseX > width - 140 - radioX && mouseX < width - 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {
    paginaCodigo++;
    return;
  }
  
  // BOTÓN ANTERIOR
  if (paginaCodigo > 0 &&
      mousePressed &&
      mouseX > 140 - radioX && mouseX < 140 + radioX &&
      mouseY > height - 40 - radioY && mouseY < height - 40 + radioY) {
    paginaCodigo--;
    return;
  }
}

void controlarCodigoTeclado() {
  if (keyCode == RIGHT) {
    if (paginaCodigo < totalPaginasCodigo - 1) {
      paginaCodigo++;
    }
  }
  else if (keyCode == LEFT) {
    if (paginaCodigo > 0) {
      paginaCodigo--;
    }
  }
  else if (keyCode == ESC) {
    pantalla = 1;
  }
}
