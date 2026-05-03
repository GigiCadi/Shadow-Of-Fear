// CONTROL GENERAL
int juegoActual = 0; 
// 0 = juego1, 1 = juego2, 2 = juego3

// LORE
int subEstado = 0; 
// 0 = lore
// 1 = juego

int paginaLore = 0;

PImage[][] lores = new PImage[3][4]; // 3 juegos, 4 imágenes cada uno
String[][] textosLore = new String[3][4];

// EFECTO ESCRITURA
String textoCompleto = "";
String textoVisible = "";

int indiceTexto = 0;
int velocidadTexto = 2;
int contadorTexto = 0;


// AUDIO JUEGOS

//SoundFile musicaJuego2;
//SoundFile musicaJuego3;

void imagenes() {
//IMÁGENES LORE
lores[0][0] = loadImage("imagenes/Lore/c1.png");
lores[0][1] = loadImage("imagenes/Lore/c2.png");
lores[0][2] = loadImage("imagenes/Lore/c3.png");
lores[0][3] = loadImage("imagenes/Lore/c4.png");
    

  // TEXTOS LORE JUEGO1
  textosLore[0][0] = "Después del cole encendí mi computador como cualquier otro día...\n" +
  "Era una rutina... algo simple, casi automático.\n"+ 
  "\n"+
  "Solo quería entrar a mi web, revisar lo de siempre y luego ir a dormir.";
  
  textosLore[0][1] = "Al principio todo parecía normal.\n"+
"Notificaciones nuevas, algunos comentarios... nada fuera de lo común.\n"+
"Pensé que sería otro día tranquilo frente a la pantalla.";

  textosLore[0][2] = "Pero de la nada...\n"+
"Me empezaron a llegar mensajes ofensivos  por el grupo escolar.\n"+
"\n"+
"No les bastaba burlarse en clase ahora también tenian que hacerlo por chat...";
  
  textosLore[0][3] = "Dejé de ver reels y empecé a leer ataques.\n"+
"Palabras de burla, que me hiriron...\n"+
"Y aun así… no podía dejar de mirar la pantalla.\n"+
"\n"+
"Ahora ¿que hago con esto?...";
}
// ========================================
// MOSTRAR LORE
// ========================================
void mostrarLore() {
  // Verificar que las imágenes existen
  if (lores == null || lores[juegoActual] == null || lores[juegoActual][paginaLore] == null) {
    // Fondo de respaldo
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Historia no disponible", width/2, height/2);
    return;
  }
  imageMode(CORNER);
  image(lores[juegoActual][paginaLore], 0, 0, width, height);
  // Verificar que hay texto
  if (textosLore == null || textosLore[juegoActual] == null || textosLore[juegoActual][paginaLore] == null) {
    return;
  }

  actualizarTexto();

  fill(255);
  textAlign(LEFT, TOP);
  textSize(22);
  text(textoVisible, 100, height - 250, width - 200, 200);
  
// =======================
// BOTÓN SIGUIENTE
// =======================

btnX = width - btnW - 10;
btnY = height - btnH - 40;

hoverBtn = mouseX > btnX && mouseX < btnX + btnW &&
           mouseY > btnY && mouseY < btnY + btnH;

// ✨ GLOW BLANCO
if (hoverBtn) {
  tint(255, 255, 255, 90);

  image(btnext, btnX - 4, btnY, btnW, btnH);
  image(btnext, btnX + 4, btnY, btnW, btnH);
  image(btnext, btnX, btnY - 3, btnW, btnH);
  image(btnext, btnX, btnY + 3, btnW, btnH);

  image(btnext, btnX - 3, btnY - 2, btnW, btnH);
  image(btnext, btnX + 3, btnY - 2, btnW, btnH);
  image(btnext, btnX - 3, btnY + 2, btnW, btnH);
  image(btnext, btnX + 3, btnY + 2, btnW, btnH);

  noTint();
}

// 🌑 SOMBRA REAL (esto te faltaba)
if (hoverBtn) {
  tint(0, 120);
  image(btnext, btnX + 5, btnY + 5, btnW, btnH);
  noTint();
}

// 🎮 BOTÓN
if (hoverBtn) {
  tint(255, 255);
  image(btnext, btnX, btnY - 3, btnW, btnH);
  noTint();
} else {
  image(btnext, btnX, btnY, btnW, btnH);
}

// =======================
// BOTÓN SKIP (arriba derecha)
// =======================

btnSkipX = width - btnSkipW - 20;
btnSkipY = 20;

hoverSkip = mouseX > btnSkipX && mouseX < btnSkipX + btnSkipW &&
            mouseY > btnSkipY && mouseY < btnSkipY + btnSkipH;

// ✨ glow
if (hoverSkip) {
  tint(255, 255, 255, 90);

  image(btnskip, btnSkipX - 4, btnSkipY, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX + 4, btnSkipY, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX, btnSkipY - 3, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX, btnSkipY + 3, btnSkipW, btnSkipH);

  noTint();
}

// 🌑 sombra
if (hoverSkip) {
  tint(0, 120);
  image(btnskip, btnSkipX + 4, btnSkipY + 4, btnSkipW, btnSkipH);
  noTint();
}

// botón
if (hoverSkip) {
  image(btnskip, btnSkipX, btnSkipY - 2, btnSkipW, btnSkipH);
} else {
  image(btnskip, btnSkipX, btnSkipY, btnSkipW, btnSkipH);
}
}
// ========================================
// ACTUALIZAR TEXTO (EFECTO ESCRITURA)
// ========================================
void actualizarTexto() {
  if (indiceTexto < textoCompleto.length()) {
    contadorTexto++;
    
    if (contadorTexto >= velocidadTexto) {
      textoVisible += textoCompleto.charAt(indiceTexto);
      indiceTexto++;
      contadorTexto = 0;

      delayVoz++;

      if (delayVoz >= intervaloVoz && sonidoVoz != null) {
        sonidoVoz.play();
        delayVoz = 0;
      }
    }
  }
}

// ========================================
// CARGAR TEXTO DEL LORE
// ========================================
void cargarTextoLore() {
  // Verificar que el texto existe
  if (textosLore[juegoActual] == null || textosLore[juegoActual][paginaLore] == null) {
    textoCompleto = "Historia no disponible...";
  } else {
    textoCompleto = textosLore[juegoActual][paginaLore];
  }
  textoVisible = "";
  indiceTexto = 0;
  contadorTexto = 0;
}
void iniciarLoreJuego1() {
  juegoActual = 0;
  subEstado = 0;
  paginaLore = 0;
  cargarTextoLore();
}
void avanzarLore() {
  if (paginaLore + 1 < 4) {
    paginaLore++;
    cargarTextoLore();
  } else {
    subEstado = 1;
    iniciarNivel1();  // Iniciar el juego
  }
}
