int delayVoz = 0;
int intervaloVoz = 3; 

// Sonido
import processing.sound.*;
SoundFile musicaMenu;
SoundFile musicaNivel1;
SoundFile sonidoVoz;
SoundFile click;
SoundFile victoria;
SoundFile derrota;
SoundFile musicaNivel2;
SoundFile caida;
// ============================================================
// Música (automática, sin control del usuario)
// ============================================================
void controlarMusica() {
    if (musicaMenu == null) return;

  // 🚨 BLOQUE TOTAL SI HAY FINAL
  if (estadoFinal != 0 || j2_estado != 0) {

    // apagar TODAS las músicas de fondo
    if (musicaMenu != null && musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1 != null && musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (musicaNivel2 != null && musicaNivel2.isPlaying()) musicaNivel2.stop();

    return; // 🔥 CLAVE: no seguir ejecutando
  }

  // Pantalla de inicio o menú principal
  if (pantalla == 0 || pantalla == 1 || pantalla == 3) {
    if (!musicaMenu.isPlaying()) musicaMenu.loop();
    if (musicaNivel1 != null && musicaNivel1.isPlaying()) 
    musicaNivel1.stop();
    //detener voz
    if (sonidoVoz != null && sonidoVoz.isPlaying()) 
    sonidoVoz.stop();
      if (victoria != null && victoria.isPlaying()) {
    victoria.stop();
    if(musicaNivel2 != null && musicaNivel2.isPlaying()) 
    musicaNivel2.stop();
  }
  if (derrota != null && derrota.isPlaying()) {
    derrota.stop();
  }
  }
  //lore
else if (pantalla == 2 && subEstado == 0) {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
}   
  // Nivel 1 en juego
  else if (pantalla == 2 && subEstado == 1) {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (!musicaNivel1.isPlaying()) musicaNivel1.loop();
    if(musicaNivel2 != null && musicaNivel2.isPlaying()) 
    musicaNivel2.stop();
    //cortar voz siempre
    if (sonidoVoz != null && sonidoVoz.isPlaying())
    sonidoVoz.stop();
  }
else if (pantalla == 5){
  if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying())sonidoVoz.stop();
    if (!musicaNivel2.isPlaying()) musicaNivel2.loop();
}
  // Otros casos
  else {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying()) 
    sonidoVoz.stop();
  }
}

void playClick() {
  if (click != null) {
    click.play();
  }
}

void detenerAudioGeneral() {

  if (musicaNivel1 != null && musicaNivel1.isPlaying()) {
    musicaNivel1.stop();
  }

  if (musicaMenu != null && musicaMenu.isPlaying()) {
    musicaMenu.stop();
  }

  if (sonidoVoz != null && sonidoVoz.isPlaying()) {
    sonidoVoz.stop();
  }
}

void detenerAudiosFinales() {

  if (victoria != null && victoria.isPlaying()) {
    victoria.stop();
  }

  if (derrota != null && derrota.isPlaying()) {
    derrota.stop();
  }
}
