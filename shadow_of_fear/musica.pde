int delayVoz = 0;
int intervaloVoz = 3; 

// Sonido
import processing.sound.*;
SoundFile musicaMenu;
SoundFile musicaNivel1;
SoundFile musicaNivel2;
SoundFile musicaNivel3;
SoundFile extra;
SoundFile sonidoVoz;
SoundFile click;
SoundFile victoria;
SoundFile derrota;
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
    if (musicaNivel3 != null && musicaNivel3.isPlaying()) musicaNivel3.stop();
    if (extra != null && extra.isPlaying()) extra.stop();

    return; // 🔥 CLAVE: no seguir ejecutando
  }

  // Pantalla de inicio o menú principal
  if (pantalla == 0 || pantalla == 1 || pantalla == 3) {
    if (!musicaMenu.isPlaying()) musicaMenu.loop();
    if (musicaNivel1 != null && musicaNivel1.isPlaying()) musicaNivel1.stop();
    //detener voz
    if (sonidoVoz != null && sonidoVoz.isPlaying()) sonidoVoz.stop();
      if (victoria != null && victoria.isPlaying()) victoria.stop();
    if(musicaNivel2 != null && musicaNivel2.isPlaying()) musicaNivel2.stop();
  if(musicaNivel3 != null && musicaNivel3.isPlaying()) musicaNivel3.stop();
  if (derrota != null && derrota.isPlaying()) derrota.stop();
  if (extra.isPlaying()) extra.stop();
  }

  //lore
else if (pantalla == 2 && subEstado == 0) {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if(musicaNivel2 != null && musicaNivel2.isPlaying()) 
    musicaNivel2.stop();
    if (extra.isPlaying()) extra.stop();
    if(musicaNivel3 != null && musicaNivel3.isPlaying()) 
    musicaNivel3.stop();
} 
  // Nivel 1 en juego
  else if (pantalla == 2 && subEstado == 1) {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (!musicaNivel1.isPlaying()) musicaNivel1.loop();
    if(musicaNivel2 != null && musicaNivel2.isPlaying()) 
    musicaNivel2.stop();
    if(musicaNivel3 != null && musicaNivel3.isPlaying()) 
    musicaNivel3.stop();
    //cortar voz siempre
    if (sonidoVoz != null && sonidoVoz.isPlaying())
    sonidoVoz.stop();
    if (extra.isPlaying()) extra.stop();
  }
  //Nivel 2
else if (pantalla == 5){
  if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying())sonidoVoz.stop();
    if (!musicaNivel2.isPlaying()) musicaNivel2.loop();
    if (extra.isPlaying()) extra.stop();
    if (musicaNivel3.isPlaying()) musicaNivel3.stop();
    if (click.isPlaying()) click.stop();
}
//extra
else if (pantalla == 4 || pantalla == 6 || pantalla == 8){
  if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying())sonidoVoz.stop();
    if (musicaNivel2.isPlaying()) musicaNivel2.stop();
    if (!extra.isPlaying()) extra.loop();
    if (musicaNivel3.isPlaying()) musicaNivel3.stop();
}
//nivel 3
else if (pantalla == 7){
  if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying())sonidoVoz.stop();
    if (musicaNivel2.isPlaying()) musicaNivel2.stop();
    if (extra.isPlaying()) extra.stop();
    if (!musicaNivel3.isPlaying()) musicaNivel3.loop();
}
  // Otros casos
  else {
    if (musicaMenu.isPlaying()) musicaMenu.stop();
    if (musicaNivel1.isPlaying()) musicaNivel1.stop();
    if (sonidoVoz != null && sonidoVoz.isPlaying()) 
    sonidoVoz.stop();
    if (musicaNivel2.isPlaying()) musicaNivel2.stop();
    if (extra.isPlaying()) extra.loop();
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

void detenerTodaMusica() {
  if (musicaMenu != null) musicaMenu.stop();
  if (musicaNivel1 != null) musicaNivel1.stop();
  if (musicaNivel2 != null) musicaNivel2.stop();
}
