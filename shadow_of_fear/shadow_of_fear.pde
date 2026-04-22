PImage logo, fondo1, fondo2, fondo3, pc, web, btneliminar, btnreemplazar, emotionbar, wordbank, btnmenu;
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
  btnmenu = loadImage("imagenes/UI/menu.png");
  //Estados emojis
  emojis[0] = loadImage("imagenes/UI/feliz.png");
  emojis[1] = loadImage("imagenes/UI/bien.png");
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
    nivel1();
  }
}

// ==========================
// CONTROL GLOBAL
// ==========================
void keyPressed() {

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
