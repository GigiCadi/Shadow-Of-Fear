// ==========================
// NIVEL 1 - CIBERBULLYING
// ==========================

// Mensajes ofensivos
String[] mensajes = {
  "Eres raro",
  "Nadie te quiere",
  "No encajas",
  "Eres inutil"
};

// Respuestas correctas
String[] respuestas = {
  "Todos somos diferentes",
  "Merezco respeto",
  "Si encajo",
  "Soy valioso"
};

int indiceMensaje = 0;
String mensajeActual = "";

boolean nivel1Terminado = false;

// ==========================
// DIBUJAR NIVEL 1
// ==========================
void nivel1() {
  imageMode(CORNER);
  image(fondo3, 0, 0, width, height);
  image(pc, 372, 164, 793, 476);
  image(web, 412, 194, 693, 376);

  // Estilo terminal retro
  fill(64, 53, 106);
  textAlign(LEFT);
  textSize(15);

  // Mostrar mensaje ofensivo
  mensajeActual = mensajes[indiceMensaje];
  text("> " + mensajeActual, 620, 350);

  // Opciones
  imageMode(CENTER);
  image(btneliminar, width/3, height - 70, 470, 94);
  image(btnreemplazar, width - width/3, height - 70, 470, 94);
  image(emotionbar, 100, height/2, 139, 642);
  
//UI botones
  imageMdde(LEFT);
  image(btnmenu, width - 300, 80, 100, 100);
  image(btnmusic[k], width - 200, 80, 100, 100);
  image(btnmenu, width - 100, 80, 100, 100);

// ==========================
// CONTROL NIVEL 1
// ==========================
void controlarNivel1() {

  // Opción 1: eliminar
  if (key == '1') {
    indiceMensaje++;
  }

  // Opción 2: responder bien
  if (key == '2') {
    indiceMensaje++;
  }

  // Validar final
  if (indiceMensaje >= mensajes.length) {
    nivel1Terminado = true;
    nivel1Completado = true; // 🔓 desbloquea menú
    pantalla = 1; // volver al menú
  }
}
