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
  text("[1] Eliminar mensaje", 100, 350);
  text("[2] Responder positivamente", 100, 400);

  // Indicador
  text("Mensaje " + (indiceMensaje + 1) + " de " + mensajes.length, 100, 500);
}

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
