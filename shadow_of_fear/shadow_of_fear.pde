PImage logo, fondo1, fondo2, fondo3, pc, web, btneliminar, btnreemplazar, emotionbar, wordbank;
PImage[] emojis = new PImage[4];
PImage[] bars = new PImage[4];
PImage[] btnmusic = new PImage[2];
PImage[] btnpause = new PImage[2];
PFont fuente;

float tiempo = 0;

//  Control de pantallas
int pantalla = 0;

// Progreso del juego
boolean nivel1Completado = false;

//estados UI
  int estadoMusica = 0;
  int estadoPausa = 0;
  int opcionPausa = 0;

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
}

void draw() {

  if (pantalla == 0) {
    pantallaInicio();
  }
  else if (pantalla == 1) {
    menuPrincipal();
  }
  else if (pantalla == 2) {

    nivel1(); // dibuja el nivel SIEMPRE

    // ENCIMA del nivel
    if (estadoPausa == 1) {
      dibujarPause();
    }
  }
}

// ==========================
// CONTROL GLOBAL
// ==========================
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
        println("configuración");
      }

      else if (opcionPausa == 3) { // salir
        pantalla = 1;
        estadoPausa = 0;
      }
    }

    return; //  BLOQUEA TODO LO DEMÁS
  }

  //  Flujo normal del juego
  if (pantalla == 0) {
    pantalla = 1;
  }
  else if (pantalla == 1) {
    controlarMenu();
  }
  else if (pantalla == 2) {
    controlarNivel1();
  }
}


void mousePressed() {

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
