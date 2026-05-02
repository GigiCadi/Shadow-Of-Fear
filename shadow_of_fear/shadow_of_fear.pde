PImage logo, fondo1, fondo2, fondo3,fondoJuego2, pc, web, btneliminar, btnreemplazar, emotionbar, wordbank, btnext, btnback, btnvolver, fondoniveles, platano, reptor, protamareada,fondoVictoria,fondoDerrota;
PImage[] emojis = new PImage[5];
PImage[] bars = new PImage[4];
PImage[] btnmusic = new PImage[2];
PImage[] btnpause = new PImage[2];
PImage[] manual = new PImage[2];
PImage[] btnjuegos = new PImage[3];
PImage[] corazon = new PImage [2];
PFont fuente;

// Pantalla de créditos
PImage fondoCreditos;
PImage popupRuth, popupGilarys, popupNashed;

// Estados de créditos
boolean mostrarPopup = false;
int popupActual = 0; // 0=ruth, 1=gilarys, 2=nashed

// Textos de los popups
String textoRuth = "LÍDER: RUTH BELTRÁN\n\nSoy la líder del equipo. Me encargué de organizar el proyecto, coordinar el trabajo y guiar el desarrollo del juego para que todo avanzara correctamente.";
String textoGilarys = "DISEÑADORA UX: GILARYS CASTILLEJO\n\nMe encargué del diseño de interfaz, la experiencia de usuario y la creación de los assets visuales del juego.";
String textoNashed = "PROGRAMADOR: NASHED KAMELL\n\nMe encargué de la implementación técnica, la programación de las mecánicas y la documentación del código.";

// vectores animaciones
PImage[]protaup = new PImage[3];
PImage[]protadown = new PImage[3];
PImage[]protaleft = new PImage[3];
PImage[]protaright = new PImage[3];
PImage[]bullyup = new PImage[2];
PImage[]bullydown = new PImage[2];
PImage[]bullyleft = new PImage[2];
PImage[]bullyright = new PImage[2];


float tiempo = 0;

//  Control de pantallas
//int pantalla = 0;
//PRUEBA PANTALLAS---------------------------------
final int PANTALLA_NIVEL2 = 3;
final int PANTALLA_NIVEL3 = 4;
final int PANTALLA_CONFIG = 5;
import processing.sound.*;
SoundFile musicaMenu;
SoundFile musicaNivel1;
SoundFile sonidoVoz;

int pantalla = 0;
int pantallaDestino = 0;
int dificultadNivel1 = 1;
int pantallaOrigen = 0; // pantalla desde donde se abrió la pausa
int tipoPausa = 0; 
// 0 = juego1
// 1 = juego2
// ==========================
// TRANSICIÓN
// ==========================
boolean enTransicion = false;
boolean mitadTransicion = false;
float alphaTransicion = 0;
float velocidadTransicion = 12;
//----------------------------------------------
// Progreso del juego
boolean nivel1Completado = false;

//estados UI
  int estadoMusica = 0;
  int estadoPausa = 0;
  int opcionPausa = 0;
  int estadoFinal = 0;
int opcionFinal = 0;
//-----------------------------------------------
// ==========================
// CONFIGURACIÓN
// ==========================
float brilloPantalla = 1.0;

boolean arrastrandoVolumen = false;
boolean arrastrandoBrillo = false;

float sliderX = 0;
float sliderW = 0;
float sliderVolY = 0;
float sliderBriY = 0;





//-------------------------------------------------------

void setup() {
  fullScreen();
  pixelDensity(1);
  noSmooth();

  // ========================================
  // CARGAR IMÁGENES PRINCIPALES
  // ========================================
  logo = loadImage("imagenes/Titulos/titulo.png");
  fondo1 = loadImage("imagenes/fondo/fondoprincipal2.2.png");
  fondo2 = loadImage("imagenes/fondo/fondoprincipal2.0.png");
  fondo3 = loadImage("imagenes/fondo/fondogame1.jpg");
  fondoJuego2 = loadImage("imagenes/fondo/juego2.png");
  pc = loadImage("imagenes/fondo/pc2.png");
  web = loadImage("imagenes/fondo/web.png");
  fuente = createFont("fuentes/PressStart2P-Regular.ttf", 24);
  btneliminar = loadImage("imagenes/UI/ELIMINAR.png");
  btnreemplazar = loadImage("imagenes/UI/reemplazar.png");
  emotionbar = loadImage("imagenes/UI/emotionbar.png");
  wordbank = loadImage("imagenes/UI/wordbank.png");
  
  // Estados emojis
  emojis[0] = loadImage("imagenes/UI/happy.png");
  emojis[1] = loadImage("imagenes/UI/good.png");
  emojis[2] = loadImage("imagenes/UI/mal.png");
  emojis[3] = loadImage("imagenes/UI/triste.png");
  emojis[4] = loadImage("imagenes/UI/lose.png");
  
  // Estados Boton de Música
  btnmusic[0] = loadImage("imagenes/UI/musicon.png");
  btnmusic[1] = loadImage("imagenes/UI/musicoff.png");
  
  // Estados Botón de pausa
  btnpause[0] = loadImage("imagenes/UI/unpause.png");
  btnpause[1] = loadImage("imagenes/UI/pause.png");
  
  // Barras de colores emocionales
  bars[0] = loadImage("imagenes/UI/green.png");
  bars[1] = loadImage("imagenes/UI/yellow.png");
  bars[2] = loadImage("imagenes/UI/orange.png");
  bars[3] = loadImage("imagenes/UI/red.png");

  // Imagenes manual
  manual[0] = loadImage("imagenes/UI/juego1.png");
  manual[1] = loadImage("imagenes/UI/juego2.png");
  btnext = loadImage("imagenes/UI/siguiente.png");
  btnback = loadImage("imagenes/UI/anterior.png");
  btnvolver = loadImage("imagenes/UI/volver.png");
  
  // imagenes botones niveles
  btnjuegos[0] = loadImage("imagenes/UI/wordreset.png");
  btnjuegos[1] = loadImage("imagenes/UI/HallwaysofSilence.png");
  btnjuegos[2] = loadImage("imagenes/UI/mortalHit.png");  
  fondoniveles = loadImage("imagenes/fondo/niveles.png");
  
  // Fondo de victoria y derrota juego 2
  fondoVictoria = loadImage("imagenes/fondo/victoria.jpeg");
  fondoDerrota = loadImage("imagenes/fondo/derrota.jpeg");

 // ========================================
// CARGAR IMÁGENES DE CRÉDITOS
// ========================================
fondoCreditos = loadImage("imagenes/fondo/popup_creditos.png");
println("Cargando fondoCreditos: " + (fondoCreditos != null ? "OK" : "ERROR"));

popupRuth = loadImage("imagenes/fondo/popup_ruth.png");
println("Cargando popupRuth: " + (popupRuth != null ? "OK" : "ERROR"));

popupGilarys = loadImage("imagenes/fondo/popup_gigi.png");
println("Cargando popupGilarys: " + (popupGilarys != null ? "OK" : "ERROR"));

popupNashed = loadImage("imagenes/fondo/popup_nashed.png");
println("Cargando popupNashed: " + (popupNashed != null ? "OK" : "ERROR"));
  
  // ========================================
  // CARGAR SPRITES DE ANIMACIONES
  // ========================================
  
  // ------ PROTAGONISTA (JUGADOR)
  protaup[0] = loadImage("imagenes/personajes/protacaminadoarriba1.png");
  protaup[1] = loadImage("imagenes/personajes/protacaminadoarriba2.png");
  protaup[2] = loadImage("imagenes/personajes/protacaminadoarriba3.png");
  protadown[0] = loadImage("imagenes/personajes/protacaminadoabajo1.png");
  protadown[1] = loadImage("imagenes/personajes/protacaminadoabajo2.png");
  protadown[2] = loadImage("imagenes/personajes/protacaminadoabajo3.png");
  protaleft[0] = loadImage("imagenes/personajes/protacaminandoizquierda1.png");
  protaleft[1] = loadImage("imagenes/personajes/protacaminandoizquierda2.png");
  protaleft[2] = loadImage("imagenes/personajes/protacaminandoizquierda3.png");
  protaright[0] = loadImage("imagenes/personajes/protacaminandoderecha1.png");
  protaright[1] = loadImage("imagenes/personajes/protacaminandoderecha2.png");
  protaright[2] = loadImage("imagenes/personajes/protacaminandoderecha3.png");
  protamareada = loadImage("imagenes/personajes/protamerada.png");
  
  // ------ BULLY (ENEMIGO)
  bullyup[0] = loadImage("imagenes/personajes/bullycaminandoarriba1.png"); 
  bullyup[1] = loadImage("imagenes/personajes/bullycaminandoarriba2.png"); 
  bullydown[0] = loadImage("imagenes/personajes/bullycaminandoabajo1.png"); 
  bullydown[1] = loadImage("imagenes/personajes/bullycaminandoabajo2.png"); 
  bullyleft[0] = loadImage("imagenes/personajes/bullycaminandoizquierda1.png"); 
  bullyleft[1] = loadImage("imagenes/personajes/bullycaminandoizquierda2.png"); 
  bullyright[0] = loadImage("imagenes/personajes/bullycaminandoderecha1.png"); 
  bullyright[1] = loadImage("imagenes/personajes/bullycaminandoderecha2.png"); 
  
  reptor = loadImage("imagenes/personajes/reptor.png");
  platano = loadImage("imagenes/UI/platano.png");

  // ========================================
  // CONFIGURACIÓN DE TEXTO Y SONIDO
  // ========================================
  textFont(fuente);
  textSize(18);
  fill(255);
  textAlign(CENTER);

  // Sliders configuración
  sliderW = 400;
  sliderX = width/2 - sliderW/2;
  sliderVolY = height/2 - 40;
  sliderBriY = height/2 + 80;
  
  // Inicializar progreso y lore
  inicializarProgresoJuego1();
  imagenes();           // ← AGREGAR ESTA LÍNEA
  cargarTextoLore();
  
  //sonido
  musicaMenu = new SoundFile(this, "musica/menu.mp3");
  musicaNivel1 = new SoundFile(this, "musica/nivel1.mp3");
  sonidoVoz = new SoundFile(this, "musica/voz.mp3");
}
void draw() {
  background(0);
  controlarMusica(); 
  println("Pantalla actual: " + pantalla);
  
  if (pantalla == 0) {
    pantallaInicio();
  }
  else if (pantalla == 1) {
    menuPrincipal();
  }
  else if (pantalla == 2) {
    println("subEstado actual: " + subEstado);  // ← VERIFICAR subEstado
    if (subEstado == 0){
      println("Llamando a mostrarLore()");
      mostrarLore();
    } else {
      println("Llamando a nivel1()");
      nivel1();
    }
  }
  else if (pantalla == 3) {
    pantallaNiveles();
  }
  else if (pantalla == 4) {
    pantallaManual();
  }
  else if (pantalla == 5) {
    nivelJuego2();
  }
  else if (pantalla == 6) {
    pantallaCreditos();
  }

  // Pausa y final se dibujan encima en cualquier pantalla que los use
  if (estadoPausa == 1) {
    dibujarPause();
  }

  if (estadoFinal != 0) {
    dibujarFinal();
  }

  aplicarBrillo();
  actualizarTransicion();
}
//PRUEBA TRANSCISION--------------------------------
void iniciarTransicion(int destino) {
  enTransicion = true;
  mitadTransicion = false;
  alphaTransicion = 0;
  pantallaDestino = destino;
}

void actualizarTransicion() {
  if (!enTransicion) return;

  if (!mitadTransicion) {
    alphaTransicion += velocidadTransicion;

    if (alphaTransicion >= 255) {
      alphaTransicion = 255;
      pantalla = pantallaDestino;
      //cambiarMusicaSegunPantalla();
      mitadTransicion = true;
    }
  } else {
    alphaTransicion -= velocidadTransicion;

    if (alphaTransicion <= 0) {
      alphaTransicion = 0;
      enTransicion = false;
      mitadTransicion = false;
    }
  }

  noStroke();
  fill(0, alphaTransicion);
  rect(0, 0, width, height);
}
//--------------------------------------------------------------------------
//PRUEBA BRILLO-----------------------------------------
void aplicarBrillo() {
  float oscuridad = map(brilloPantalla, 0, 1, 220, 0);
  noStroke();
  fill(0, oscuridad);
  rect(0, 0, width, height);
}
//------------------------------------------------------------
void keyPressed() {

  // Guardar si ESC fue presionado ANTES de bloquearlo
  boolean escPresionado = (keyCode == ESC);

  // Bloquear ESC para que no cierre el programa
  if (keyCode == ESC) {
    key = 0;
  }

  // PAUSA activa
  if (estadoPausa == 1) {
    if (tipoPausa == 0) {
      controlarPausaJuego1Teclado();
    } else {
      controlarPausaJuego2Teclado();
    }
    return;
  }

  // POPUP FINAL activo - Juego 1
  if (estadoFinal != 0 && pantalla == 2) {
    controlarMenuFinalJuego1Teclado();
    return;
  }
  
  // POPUP FINAL activo - Juego 2
  if (j2_estado != 0 && pantalla == 5) {
    controlarFinalJuego2Teclado();
    return;
  }

  if (pantalla == 0) {
    iniciarTransicion(1);
  }
  else if (pantalla == 1) {
    controlarMenu();
  }
  else if (pantalla == 2) {
    controlarNivel1();
  }
  else if (pantalla == 3) {
    if (escPresionado) {
      pantalla = 1;
    }
  }
  else if (pantalla == 4) {
    controlarManualTeclado();
  }
  else if (pantalla == 5) {
    j2_keyPressed();
  }
  else if (pantalla == 6) {  // ← NUEVO: Créditos
    controlarCreditosTeclado();
  }
}
void mousePressed() {
  if (enTransicion) return;

  if (estadoFinal != 0) {
    controlarMenuFinalJuego1Mouse();
    return;
  }

  if (estadoPausa == 1) {
    if (tipoPausa == 0) {
      controlarPausaJuego1Mouse();
    } else {
      controlarPausaJuego2Mouse();
    }
    return;
  }

  // Botón pausa — solo en pantalla 2
  if (pantalla == 2) {
    int tamaño = 100;
    int espacio = 20;
    int y = 80;
    int x = width - (tamaño * 3) - 10;
    int xPause = x + (tamaño + espacio) * 2;
    int radio = tamaño / 2;

    if (dist(mouseX, mouseY, xPause, y) < radio) {
      pantallaOrigen = pantalla;
      estadoPausa = 1;
      opcionPausa = 0;
      tipoPausa = 0;
      return;
    }
    
    // 🔥 LORE
    if (subEstado == 0) {
      if (indiceTexto < textoCompleto.length()) {
        textoVisible = textoCompleto;
        indiceTexto = textoCompleto.length();
        return;
      }

      paginaLore++;
      if (paginaLore >= 4) {
        subEstado = 1;
        paginaLore = 0;
        return;
      }
      cargarTextoLore();
      return;
    }

    // 🎮 JUEGO
    if (subEstado == 1) {
      mouseNivel1();
    }
  }

  if (pantalla == 3) {
    controlarNiveles();
  }
  
  // Manual
  if (pantalla == 4) {
    controlarManual();
  }

  if (pantalla == 5) {
    int sz = 100; 
    int esp = 15; 
    int yUI = 80;
    int xBase = width - (sz * 3);
    int xPause = xBase + (sz + esp) * 2;
    
    if (dist(mouseX, mouseY, xPause, yUI) < sz/2) {
      if (j2_estado == 0) {
        pantallaOrigen = 5;
        estadoPausa = 1;
        opcionPausa = 0; 
        tipoPausa = 1;
      }
      return;
    }
    if (j2_estado != 0) {
      clicFinalJuego2();
    }
  }
  
  // ========================================
  // NUEVO: CRÉDITOS (pantalla 6)
  // ========================================
  if (pantalla == 6) {
    controlarCreditos();
  }
}

void keyReleased() {
   if (pantalla == 5) {
     j2_keyReleased();
   }    
}

void controlarMusica() {

  // Seguridad básica
  if (musicaMenu == null) return;

  // ==========================
  // 🏠 MENU
  // ==========================
  if (pantalla == 0 || pantalla == 1) {

    if (!musicaMenu.isPlaying()) {
      musicaMenu.loop();
    }
    if(musicaNivel1 != null && musicaNivel1.isPlaying()){
      musicaNivel1.stop();
    }
    if (sonidoVoz != null && sonidoVoz.isPlaying()){
      sonidoVoz.stop();
    }
    return;
  }
  // ==========================
  // 📖 LORE
  // ==========================
  if (pantalla == 2 && subEstado == 0) {

    if (musicaMenu.isPlaying()){
      musicaMenu.stop();
    }
    if (musicaNivel1.isPlaying()){ 
      musicaNivel1.stop();
    }
    return;
  }

  // ==========================
  // 🎮 GAMEPLAY
  // ==========================
  if (pantalla == 2 && subEstado == 1) {

    if (musicaMenu.isPlaying()){
      musicaMenu.stop();
    }

    if (!musicaNivel1.isPlaying()) {
      musicaNivel1.loop();
    }

    return;
  }

  // ==========================
  // 🔕 OTROS
  // ==========================
  if (musicaMenu.isPlaying()){
    musicaMenu.stop();
  }
  if (musicaNivel1.isPlaying()){
    musicaNivel1.stop();
  }
}
void pararTodasLasMusicas() {
  if (musicaMenu != null && musicaMenu.isPlaying()) musicaMenu.stop();
  if (musicaNivel1 != null && musicaNivel1.isPlaying()) musicaNivel1.stop();
}
