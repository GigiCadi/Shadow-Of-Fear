PImage logo, fondo1, fondo2, fondo3, fondoJuego2, pc, web, btneliminar, btnreemplazar, emotionbar,
      wordbank, btnext, btnback, btnvolver, fondoniveles, platano, reptor, protamareada, fondoVictoria,
      fondoDerrota, juego3, btnskip;
PImage[] emojis = new PImage[5];
PImage[] bars = new PImage[4];
PImage[] btnpause = new PImage[2];
PImage[] manual = new PImage[3];
PImage[] btnjuegos = new PImage[3];

// imágenes juego 3
PImage[] bully = new PImage[3];
PImage[] prota = new PImage[7];
PFont fuente;
PImage bullyParado;      
PImage aliEspaldas;      
// Fondos para finales del juego 3
PImage fondoFinalBueno;
PImage fondoFinalMedio;
PImage fondoFinalMalo;
// Pantalla de créditos
PImage fondoCreditos;
PImage popupRuth, popupGilarys, popupNashed;
boolean mostrarPopup = false;
int popupActual = 0; // 0=ruth, 1=gilarys, 2=nashed

//codigo 
PImage fondoCodigo;
PImage personajeRuth;
PImage personajeRuth2;
PImage personajeGigi;
PImage personajeGigi2;
PImage personajeNashed;
PImage personajeNashedCreditos;

// vectores animaciones
PImage[] protaup = new PImage[3];
PImage[] protadown = new PImage[3];
PImage[] protaleft = new PImage[3];
PImage[] protaright = new PImage[3];
PImage[] bullyup = new PImage[2];
PImage[] bullydown = new PImage[2];
PImage[] bullyleft = new PImage[2];
PImage[] bullyright = new PImage[2];

float tiempo = 0;

// Control de pantallas
int pantalla = 0;
int pantallaDestino = 0;
int dificultadNivel1 = 1;
int pantallaOrigen = 0;
int tipoPausa = 0; // 0=juego1, 1=juego2, 2=juego3

// Transición
boolean enTransicion = false;
boolean mitadTransicion = false;
float alphaTransicion = 0;
float velocidadTransicion = 12;

// Estados UI
int estadoPausa = 0;
int opcionPausa = 0;
int estadoFinal = 0;
int opcionFinal = 0;

// ============================================================
// setup
// ============================================================
void setup() {
  fullScreen();
  pixelDensity(1);
  noSmooth();

  // CARGAR IMÁGENES PRINCIPALES
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

  // Emojis
  emojis[0] = loadImage("imagenes/UI/happy.png");
  emojis[1] = loadImage("imagenes/UI/good.png");
  emojis[2] = loadImage("imagenes/UI/mal.png");
  emojis[3] = loadImage("imagenes/UI/triste.png");
  emojis[4] = loadImage("imagenes/UI/lose.png");

  // Botón pausa
  btnpause[0] = loadImage("imagenes/UI/unpause.png");
  btnpause[1] = loadImage("imagenes/UI/pause.png");

  // Barras emocionales
  bars[0] = loadImage("imagenes/UI/green.png");
  bars[1] = loadImage("imagenes/UI/yellow.png");
  bars[2] = loadImage("imagenes/UI/orange.png");
  bars[3] = loadImage("imagenes/UI/red.png");

  // Manual
  manual[0] = loadImage("imagenes/UI/juego1.png");
  manual[1] = loadImage("imagenes/UI/juego2.png");
  manual[2] = loadImage("imagenes/UI/juego3.png");
  btnext = loadImage("imagenes/UI/siguiente.png");
  btnback = loadImage("imagenes/UI/anterior.png");
  btnskip = loadImage("imagenes/UI/skip.png");
  btnvolver = loadImage("imagenes/UI/volver.png");

  // Botones niveles
  btnjuegos[0] = loadImage("imagenes/UI/wordreset.png");
  btnjuegos[1] = loadImage("imagenes/UI/HallwaysofSilence.png");
  btnjuegos[2] = loadImage("imagenes/UI/mortalHit.png");
  fondoniveles = loadImage("imagenes/fondo/niveles.png");

  // Fondos victoria/derrota juego2
  fondoVictoria = loadImage("imagenes/fondo/victoria.jpeg");
  fondoDerrota = loadImage("imagenes/fondo/derrota.jpeg");

  // Créditos
  fondoCreditos = loadImage("imagenes/fondo/popup_creditos.png");
  popupRuth = loadImage("imagenes/fondo/popup_ruth.png");
  popupGilarys = loadImage("imagenes/fondo/popup_gigi.png");
  popupNashed = loadImage("imagenes/fondo/popup_nashed.png");
  personajeRuth2 = loadImage("imagenes/personajes/ruth_codigo2.png");
  personajeGigi = loadImage("imagenes/personajes/gigi_codigo.png");
  personajeGigi2 = loadImage("imagenes/personajes/gigi_codigo3.png");
  personajeNashed = loadImage("imagenes/personajes/nashed_codigo2.png");
  personajeNashedCreditos = loadImage("imagenes/personajes/nashed_creditos1.png");

  // Sprites protagonista
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

  // Sprites bully
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

  // Juego 3
  bully[0] = loadImage("imagenes/personajes/bullyHabla.png");
  bully[1] = loadImage("imagenes/personajes/bullyHablaCreido.png");
  bully[2] = loadImage("imagenes/personajes/bullyHablaEnojado.png");
  prota[0] = loadImage("imagenes/personajes/protaAliviada.png");
  prota[1] = loadImage("imagenes/personajes/protaArrodillada.png");
  prota[2] = loadImage("imagenes/personajes/protaAsustada.png");
  prota[3] = loadImage("imagenes/personajes/protacorre.png");
  prota[4] = loadImage("imagenes/personajes/protaDepresiva.png");
  prota[5] = loadImage("imagenes/personajes/protaLlora.png");
  prota[6] = loadImage("imagenes/personajes/protaIra.png");  
  juego3 = loadImage("imagenes/fondo/juego3.png");
  bullyParado = loadImage("imagenes/personajes/bully_paradouu.png");
  aliEspaldas = loadImage("imagenes/personajes/protacaminadoarriba1.png");
  // Fondos para finales del juego 3
fondoFinalBueno = loadImage("imagenes/fondo/final_bueno.jpeg");
fondoFinalMedio = loadImage("imagenes/fondo/final_medio.jpeg");
fondoFinalMalo = loadImage("imagenes/fondo/final_malo.jpeg");
 
  
  //codigo
  fondoCodigo = loadImage("imagenes/fondo/fondo_codigo.jpeg");
  personajeRuth = loadImage("imagenes/personajes/ruth_codigo.png");

  // Texto
  textFont(fuente);
  textSize(18);
  fill(255);
  textAlign(CENTER);

  // Inicializar progreso y lore
  inicializarProgresoJuego1();
  imagenes();
  cargarTextoLore();

  // Música
  musicaMenu = new SoundFile(this, "musica/menu.mp3");
  musicaNivel1 = new SoundFile(this, "musica/nivel1.mp3");
  sonidoVoz = new SoundFile(this, "musica/voz.mp3");
  click = new SoundFile(this, "musica/click.mp3");
  victoria = new SoundFile(this, "musica/victoria.mp3");
  derrota  = new SoundFile(this, "musica/derrota.mp3");
  musicaNivel2 = new SoundFile(this, "musica/nivel2.mp3");
  caida = new SoundFile(this, "musica/caida.mp3");
  extra = new SoundFile(this, "musica/extra.mp3");
  musicaNivel3 = new SoundFile(this, "musica/nivel3.mp3");
}

// ============================================================
// draw
// ============================================================
void draw() {
  background(0);
  controlarMusica();

  if (pantalla == 0) {
    pantallaInicio();
  } else if (pantalla == 1) {
    menuPrincipal();
  } else if (pantalla == 2) {
    if (subEstado == 0) mostrarLore();
    else nivel1();
  } else if (pantalla == 3) {
    pantallaNiveles();
  } else if (pantalla == 4) {
    pantallaManual();
  } else if (pantalla == 5) {
    nivelJuego2();
  } else if (pantalla == 6) {
    pantallaCreditos();
  } else if (pantalla == 7) {
    nivelJuego3();
  } else if (pantalla == 8) {  // ← NUEVA PANTALLA
    pantallaCodigo();
  }

  if (estadoPausa == 1) dibujarPause();
  if (estadoFinal != 0) dibujarFinal();
  actualizarTransicion();
}
// ============================================================
// Transición
// ============================================================
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

// ============================================================
// Teclado y ratón
// ============================================================
void keyPressed() {
  boolean escPresionado = (keyCode == ESC);
  if (keyCode == ESC) key = 0;
    if (keyCode == UP || keyCode == DOWN || keyCode == ' ' || keyCode == ENTER || keyCode == ESC || keyCode == LEFT || keyCode == RIGHT) {
  playClick();
}
   // 🎮 CONTROL LORE CON TECLADO
  if (pantalla == 2 && subEstado == 0) {

    if (keyCode == RIGHT || keyCode == ENTER || keyCode == RETURN || key == ' ') {

      // Si el texto no ha terminado → mostrarlo completo
      if (indiceTexto < textoCompleto.length()) {
        textoVisible = textoCompleto;
        indiceTexto = textoCompleto.length();
      } 
      else {
        // avanzar a la siguiente página
        avanzarLore();
      }
      playClick(); 
    }
    return; 
  }

  if (estadoPausa == 1) {
    if (tipoPausa == 0) controlarPausaJuego1Teclado();
    else if (tipoPausa == 1) controlarPausaJuego2Teclado();
    else if (tipoPausa == 2) controlarPausaJuego3Teclado();
    return;
  }
  if (estadoFinal != 0 && pantalla == 2) {
    controlarMenuFinalJuego1Teclado();
    return;
  }
  if (j2_estado != 0 && pantalla == 5) {
    controlarFinalJuego2Teclado();
    return;
  }

  if (pantalla == 0) iniciarTransicion(1);
  else if (pantalla == 1) controlarMenu();
  else if (pantalla == 2) controlarNivel1();
  else if (pantalla == 3) { if (escPresionado) pantalla = 1; }
  else if (pantalla == 4) controlarManualTeclado();
  else if (pantalla == 5) j2_keyPressed();
  else if (pantalla == 6) controlarCreditosTeclado();
  else if (pantalla == 7) controlarJuego3Teclado();
  else if (pantalla == 8) controlarCodigoTeclado();  // ← NUEVO
}

void mousePressed() {
  playClick();
  if (enTransicion) return;

  if (estadoFinal != 0) {
    controlarMenuFinalJuego1Mouse();
    return;
  }
  if (estadoPausa == 1) {
    if (tipoPausa == 0) controlarPausaJuego1Mouse();
    else if (tipoPausa == 1) controlarPausaJuego2Mouse();
    else if (tipoPausa == 2) controlarPausaJuego3Mouse();
    return;
  }

  // Botón pausa en pantalla 2 (juego 1) — solo si NO estamos en lore
  if (pantalla == 2) {
    if (subEstado == 1) {  // solo en el juego, no en el lore
      int tamaño = 100, espacio = 20, y = 80;
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
    }

// Lore
if (pantalla == 2 && subEstado == 0) {
    // SKIP LORE
  if (hoverSkip) {

    // saltar directo al juego
    subEstado = 1;
    paginaLore = 0;

    if (sonidoVoz != null && sonidoVoz.isPlaying()) {
      sonidoVoz.stop();
    }

    playClick();
    return;
  }

  // SOLO si hace click en el botón
  if (hoverBtn) {

    if (indiceTexto < textoCompleto.length()) {
      textoVisible = textoCompleto;
      indiceTexto = textoCompleto.length();
    } else {
      avanzarLore();
    }

    playClick();
  }

  return;
}
    // Juego
    if (subEstado == 1) mouseNivel1();
    return;
  }

  if (pantalla == 3) {
    controlarNiveles();
    return;
  }
  
  if (pantalla == 4) {
    controlarManual();
    return;
  }
  
  if (pantalla == 5) {
    int sz = 100, esp = 15, yUI = 80;
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
    if (j2_estado != 0) clicFinalJuego2();
    return;
  }
  
  if (pantalla == 6) {
    controlarCreditos();
    return;
  }
  
  if (pantalla == 7) {
    int sz = 100, esp = 15, yUI = 80;
    int xBase = width - (sz * 3);
    int xPause = xBase + (sz + esp) * 2;
    if (dist(mouseX, mouseY, xPause, yUI) < sz/2) {
      if (j3_estado == 0) {
        pantallaOrigen = 7;
        estadoPausa = 1;
        opcionPausa = 0;
        tipoPausa = 2;
      }
      return;
    }
    mouseJuego3();
    return;
  }
  
  // ← NUEVA PANTALLA 8 (CÓDIGO) - CORRECTA, FUERA DEL if (pantalla == 7)
  if (pantalla == 8) {
    controlarCodigo();
    return;
  }
  

}

void keyReleased() {
  if (pantalla == 5) j2_keyReleased();
}
