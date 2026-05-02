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
  textosLore[0][0] = "Encendí mi computador como cualquier otro día...\n" +
  "Era una rutina... algo simple, casi automático.\n"+ 
  "\n"+
  "Solo quería entrar a mi web, revisar lo de siempre y luego ir a dormir.";
  
  textosLore[0][1] = "Al principio todo parecía normal.\n"+
"Notificaciones nuevas, algunos comentarios... nada fuera de lo común.\n"+
"Pensé que sería otro día tranquilo frente a la pantalla.";

  textosLore[0][2] = "Pero algo empezó a sentirse extraño...\n"+
"Empezaron a llegar mensajes raros.\n"+
"\n"+
"Había algo diferente… algo que no se sentía bien.";
  
  textosLore[0][3] = "Dejé de ver opiniones y empecé a leer ataques.\n"+
"Palabras que no buscaban ayudar, solo herir...\n"+
"Y aun así… no podía dejar de mirar la pantalla.\n"+
"\n"+
"...........";
}
void mostrarLore() {

  imageMode(CORNER);
  image(lores[juegoActual][paginaLore], 0, 0, width, height);

  actualizarTexto();

  fill(255);
  textAlign(LEFT, TOP);
  textSize(22);
  text(textoVisible, 100, height - 250, width - 200, 200);
}

void actualizarTexto() {

  if (indiceTexto < textoCompleto.length()) {

    contadorTexto++;

    if (contadorTexto >= velocidadTexto) {
      textoVisible += textoCompleto.charAt(indiceTexto);
      indiceTexto++;
      contadorTexto = 0;

      // sonido voz
      if (!sonidoVoz.isPlaying()) {
        sonidoVoz.play();
      }
    }
  }
}



void cargarTextoLore() {
  textoCompleto = textosLore[juegoActual][paginaLore];
  textoVisible = "";
  indiceTexto = 0;
}

void iniciarLoreJuego1() {
  subEstado = 0;
  paginaLore = 0;
  cargarTextoLore();
}
