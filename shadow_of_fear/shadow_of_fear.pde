PImage logo, fondo1, fondo2, fondo3, pc, web, btneliminar, btnreemplazar, emotionbar, wordbank;
PImage[] emojis = new PImage[5];
PImage[] bars = new PImage[4];
PImage[] btnmusic = new PImage[2];
PImage[] btnpause = new PImage[2];
PFont fuente;

float tiempo = 0;

//  Control de pantallas
//int pantalla = 0;
//PRUEBA PANTALLAS---------------------------------
final int PANTALLA_NIVEL2 = 3;
final int PANTALLA_NIVEL3 = 4;
final int PANTALLA_CONFIG = 5;

int pantalla = 0;
int pantallaDestino = 0;
int dificultadNivel1 = 1;
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

  logo = loadImage("imagenes/Titulos/titulo.png");
  fondo1 = loadImage("imagenes/fondo/fondoprincipal2.2.png");
  fondo2 = loadImage("imagenes/fondo/fondoprincipal2.0.png");
  fondo3 = loadImage("imagenes/fondo/fondogame1.jpg");
  pc = loadImage("imagenes/fondo/pc2.png");
  web = loadImage("imagenes/fondo/web.png");
  fuente = createFont("fuentes/PressStart2P-Regular.ttf", 24);
  btneliminar = loadImage("imagenes/UI/ELIMINAR.png");
  btnreemplazar = loadImage("imagenes/UI/reemplazar.png");
  emotionbar = loadImage("imagenes/UI/emotionbar.png");
  wordbank = loadImage("imagenes/UI/wordbank.png");
  //Estados emojis
  emojis[0] = loadImage("imagenes/UI/happy.png");
  emojis[1] = loadImage("imagenes/UI/good.png");
  emojis[2] = loadImage("imagenes/UI/mal.png");
  emojis[3] = loadImage("imagenes/UI/triste.png");
  emojis[4] = loadImage("imagenes/UI/lose.png");
  // Estados Boton de Música
  btnmusic[0]= loadImage("imagenes/UI/musicon.png");
  btnmusic[1] = loadImage("imagenes/UI/musicoff.png");
  // Estados Botón de pausa
  btnpause[0] = loadImage("imagenes/UI/unpause.png");
  btnpause[1] = loadImage("imagenes/UI/pause.png");
  
  // Barras de colores emocionales
  bars[0] = loadImage("imagenes/UI/green.png");
  bars[1] = loadImage("imagenes/UI/yellow.png");
  bars[2] = loadImage("imagenes/UI/orange.png");
  bars[3] = loadImage("imagenes/UI/red.png");


  textFont(fuente);
  textSize(18);
  fill(255);
  textAlign(CENTER);
  
  //---------------------------------------
    // --------------------------
  // SLIDERS CONFIG
  // --------------------------
  sliderW = 400;
  sliderX = width/2 - sliderW/2;
  sliderVolY = height/2 - 40;
  sliderBriY = height/2 + 80;
  //----------------------------------------
}

void draw() {
  background(0);

  if (pantalla == 0) {
    pantallaInicio();
  }
  else if (pantalla == 1) {
    menuPrincipal();
  }
if (pantalla == 2) {

  nivel1();

  if (estadoPausa == 1) {
    dibujarPause();
  }

  if (estadoFinal != 0) {
    dibujarFinal();
  }
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

  // PRIMERO: controlar pausa
  if (estadoPausa == 1) {

    if (keyCode == UP) {
      opcionPausa--;
      if (opcionPausa < 0) opcionPausa = 3;
    }

    if (keyCode == DOWN) {
      opcionPausa++;
      if (opcionPausa > 3) opcionPausa = 0;
    }

    if (keyCode == ' ') {

      if (opcionPausa == 0) { // continuar
        estadoPausa = 0;
      }

      else if (opcionPausa == 1) { // reiniciar
        reiniciarNivel1();
        estadoPausa = 0;
      }

      else if (opcionPausa == 2) { // configuración
        //println("configuración");
        //AQUI
        estadoPausa = 0;
        iniciarTransicion(PANTALLA_CONFIG);
      }

      else if (opcionPausa == 3) { // salir
        pantalla = 1;
        estadoPausa = 0;
      }
    }

    return; //  BLOQUEA TODO LO DEMÁS
  }
  
    // POPUP FINAL
  if (estadoFinal != 0) {

    if (keyCode == UP || keyCode == DOWN) {
      opcionFinal = 1 - opcionFinal;
    }

    if (key == ' ') {

      if (opcionFinal == 0) {

        if (estadoFinal == 1) { // derrota
          estadoFinal = 0;
          estadoPausa = 0;
          dificultadNivel1 = 1;
          reiniciarNivel1();
        }
        else if (estadoFinal == 2) { // victoria
          estadoFinal = 0;
          estadoPausa = 0;
          dificultadNivel1++;
          iniciarNivel1Dificil();
        }
      }

      else if (opcionFinal == 1) {
        estadoFinal = 0;
        estadoPausa = 0;
        pantalla = 1;
      }
    }

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
  else if (pantalla == PANTALLA_CONFIG) {
    if (keyCode == ESC) {
      key = 0;
      iniciarTransicion(1);
    }
  }
}


void mousePressed() {
//AQUI
if (enTransicion) return;

  // ==========================
  // POPUP FINAL
  // ==========================
  if (estadoFinal != 0) {

    int ancho = 250;
    int alto = 50;
    int xCentro = width/2;

    int y1 = height/2 - 10;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y1 - alto/2 && mouseY < y1 + alto/2) {

      if (estadoFinal == 1) { // derrota
        estadoFinal = 0;
        estadoPausa = 0;
        dificultadNivel1 = 1;
        reiniciarNivel1();
      }
      else if (estadoFinal == 2) { // victoria
        estadoFinal = 0;
        estadoPausa = 0;
        dificultadNivel1++;
        iniciarNivel1Dificil();
      }

      return;
    }

    int y2 = height/2 + 50;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y2 - alto/2 && mouseY < y2 + alto/2) {
      estadoFinal = 0;
      estadoPausa = 0;
      pantalla = 1;
      return;
    }

    return;
  }
  
  // ==========================
  // PAUSA ACTIVA
  // ==========================
  if (estadoPausa == 1) {

    int ancho = 250;
    int alto = 50;
    int xCentro = width/2;

    int y1 = height/2 - 40;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y1 - alto/2 && mouseY < y1 + alto/2) {
      estadoPausa = 0;
    }

    int y2 = height/2 + 10;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y2 - alto/2 && mouseY < y2 + alto/2) {
      reiniciarNivel1();
      estadoPausa = 0;
    }

    int y3 = height/2 + 60;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y3 - alto/2 && mouseY < y3 + alto/2) {
      println("Configuración");
    }

    int y4 = height/2 + 110;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y4 - alto/2 && mouseY < y4 + alto/2) {
      pantalla = 1;
      estadoPausa = 0;
    }

    return;
  }

  // ==========================
  // BOTÓN PAUSA (PRIMERO)
  // ==========================
  int tamaño = 100;
  int espacio = 20;
  int y = 80;

  int x = width - (tamaño * 3) - 10;
  int xPause = x + (tamaño + espacio) * 2;

  int radio = tamaño / 2;

  if (dist(mouseX, mouseY, xPause, y) < radio) {
    estadoPausa = 1;
    opcionPausa = 0;
    return; // 🔥 IMPORTANTE
  }

  // ==========================
  // NIVEL
  // ==========================
  if (pantalla == 2) {
    mouseNivel1();
  }
}
