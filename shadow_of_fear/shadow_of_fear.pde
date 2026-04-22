PImage logo, fondo1, fondo2, fondo3, pc, web;
PFont fuente;

float tiempo = 0;

// 🔥 Control de pantallas
int pantalla = 0;

// 🔒 Progreso del juego
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
    nivel1(); // 👈 ya está bien conectado
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
