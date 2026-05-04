// CONTROL GENERAL
int tipoLore = 0; 
int juegoActual = 0; 
// 0 = juego1, 1 = juego2, 2 = juego3

// LORE
int subEstado = 0; 
// 0 = lore
// 1 = juego

int paginaLore = 0;

PImage[][] lores = new PImage[4][4]; // 3 juegos, 4 imágenes cada uno
String[][] textosLore = new String[4][4];

// EFECTO ESCRITURA
String textoCompleto = "";
String textoVisible = "";

int indiceTexto = 0;
int velocidadTexto = 2;
int contadorTexto = 0;

int btnX, btnY;
int btnW = 210;
int btnH = 60;
boolean hoverBtn = false;
int PANTALLA_LORE_INICIO = -1;
int btnSkipX, btnSkipY;
int btnSkipW = 210;
int btnSkipH = 60;
boolean hoverSkip = false;
// AUDIO JUEGOS

//SoundFile musicaJuego2;
//SoundFile musicaJuego3;

void imagenes() {
//IMÁGENES LORE
lores[0][0] = loadImage("imagenes/Lore/f1.png");
lores[0][1] = loadImage("imagenes/Lore/f2.png");
lores[0][2] = loadImage("imagenes/Lore/f3.png");
lores[0][3] = loadImage("imagenes/Lore/f4.png");
lores[1][0] = loadImage("imagenes/Lore/c1.png");
lores[1][1] = loadImage("imagenes/Lore/c2.png");
lores[1][2] = loadImage("imagenes/Lore/c3.png");
lores[1][3] = loadImage("imagenes/Lore/c4.png");

// TEXTOS LORE INICIO
textosLore[0][0] = "Mi nombre es Ali. Antes estudiaba en otra escuela…\n" +
  "pero las cosas no iban bien para mí.";
  
  textosLore[0][1] = "Mis compañeros me trataban mal.\n"+
"Días largos, silencios incómodos…\n"+
"y palabras que dolían más de lo que parecía.";

  textosLore[0][2] = "Al final, me cambiaron de colegio.\n"+
"Pensé que todo había terminado…\n"+
"\n"+
"que por fin podría empezar de nuevo.";
  
  textosLore[0][3] = "Pero no fue así.\n"+
"En mi nueva escuela…\n"+
"la pesadilla apenas comenzaba.\n"+
"\n"+
".......";

  // TEXTOS LORE JUEGO1
  textosLore[1][0] = "Después del cole encendí mi computador como cualquier otro día...\n" +
  "Era una rutina... algo simple, casi automático.\n"+ 
  "\n"+
  "Solo quería entrar a mi web, revisar lo de siempre y luego ir a dormir.";
  
  textosLore[1][1] = "Al principio todo parecía normal.\n"+
"Notificaciones nuevas, algunos comentarios... nada fuera de lo común.\n"+
"Pensé que sería otro día tranquilo frente a la pantalla.";

  textosLore[1][2] = "Pero de la nada...\n"+
"Me empezaron a llegar mensajes ofensivos  por el grupo escolar.\n"+
"\n"+
"No les bastaba burlarse en clase ahora también tenian que hacerlo por chat...";
  
  textosLore[1][3] = "Dejé de ver reels y empecé a leer ataques.\n"+
"Palabras de burla, que me hirieron...\n"+
"Y aun así… no podía dejar de mirar la pantalla.\n"+
"\n"+
"Ahora ¿que hago con esto?...";
}
// ========================================
// MOSTRAR LORE
// ========================================
void mostrarLore() {
  // Verificar que las imágenes existen
  if (lores == null || lores[tipoLore] == null || lores[tipoLore][paginaLore] == null) {
    // Fondo de respaldo
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Historia no disponible", width/2, height/2);
    return;
  }
  imageMode(CORNER);
  image(lores[tipoLore][paginaLore], 0, 1, width, height);
  // Verificar que hay texto
  if (textosLore == null || textosLore[tipoLore] == null || textosLore[tipoLore][paginaLore] == null) {
    return;
  }

  actualizarTexto();

  fill(255);
  textAlign(LEFT, TOP);
  textSize(22);
  text(textoVisible, 100, height - 250, width - 200, 200);
  
// BOTÓN SIGUIENTE

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
if (hoverBtn) {
  tint(0, 120);
  image(btnext, btnX + 5, btnY + 5, btnW, btnH);
  noTint();
}

// BOTÓN
if (hoverBtn) {
  tint(255, 255);
  image(btnext, btnX, btnY - 3, btnW, btnH);
  noTint();
} else {
  image(btnext, btnX, btnY, btnW, btnH);
}


// BOTÓN SKIP 

btnSkipX = width - btnSkipW - 20;
btnSkipY = 20;

hoverSkip = mouseX > btnSkipX && mouseX < btnSkipX + btnSkipW &&
            mouseY > btnSkipY && mouseY < btnSkipY + btnSkipH;

if (hoverSkip) {
  tint(255, 255, 255, 90);

  image(btnskip, btnSkipX - 4, btnSkipY, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX + 4, btnSkipY, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX, btnSkipY - 3, btnSkipW, btnSkipH);
  image(btnskip, btnSkipX, btnSkipY + 3, btnSkipW, btnSkipH);

  noTint();
}

if (hoverSkip) {
  tint(0, 120);
  image(btnskip, btnSkipX + 4, btnSkipY + 4, btnSkipW, btnSkipH);
  noTint();
}

if (hoverSkip) {
  image(btnskip, btnSkipX, btnSkipY - 2, btnSkipW, btnSkipH);
} else {
  image(btnskip, btnSkipX, btnSkipY, btnSkipW, btnSkipH);
}
}


// ========================================
// CARGAR TEXTO DEL LORE
// ========================================
void cargarTextoLore() {
  // Verificar que el texto existe
  if (textosLore[tipoLore] == null || textosLore[tipoLore][paginaLore] == null) {
    textoCompleto = "Historia no disponible...";
  } else {
    textoCompleto = textosLore[tipoLore][paginaLore];
  }
  textoVisible = "";
  indiceTexto = 0;
  contadorTexto = 0;
}
void iniciarLoreInicio() {
  pantalla = -1;
  tipoLore = 0; // f
  subEstado = 0;
  paginaLore = 0;
  cargarTextoLore();
}
void iniciarLoreJuego1() {
  pantalla = 2;
  tipoLore = 1;
  subEstado = 0;
  paginaLore = 0;
  cargarTextoLore();
}
void avanzarLore() {
  if (paginaLore + 1 < 4) {
    paginaLore++;
    cargarTextoLore();
  } else {

    // 👇 AQUÍ ESTÁ LA CLAVE
    if (tipoLore == 0) {
      pantalla = -1;
      iniciarTransicion(0); // ir a pantalla inicio
    } else {
      subEstado = 1;
      iniciarNivel1();
    }
  }
}

void reiniciarLore() {
  subEstado = 0;
  paginaLore = 0;
  indiceTexto = 0;
  contadorTexto = 0;
  textoVisible = "";
  cargarTextoLore();
}
