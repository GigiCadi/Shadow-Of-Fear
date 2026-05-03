void pantallaCreditos() {
  pushStyle();
  imageMode(CORNER);
  if (fondoCreditos != null) {
    image(fondoCreditos, 0, 0, width, height);
  } else {
    background(30, 25, 55);
  }
  
  imageMode(CENTER);
  float tamanoVolverX = width * 0.12;
  float tamanoVolverY = tamanoVolverX * 0.4;
  float xVolver = width - 110;
  float yVolver = 60;
  
  if (btnvolver != null) {
    dibujarBotonConSombra(btnvolver, xVolver, yVolver, tamanoVolverX, tamanoVolverY);
  } else {
    fill(101, 70, 155);
    noStroke();
    rectMode(CENTER);
    rect(xVolver, yVolver, tamanoVolverX, tamanoVolverY, 15);
    fill(245, 235, 255);
    textSize(width * 0.02);
    textAlign(CENTER, CENTER);
    text("VOLVER", xVolver, yVolver);
  }
  if (mostrarPopup) {
    fill(0, 180);
    noStroke();
    rect(0, 0, width, height);
    
    imageMode(CENTER);
    float anchoPopup = width * 0.7;
    float altoPopup = height * 0.7;
    
    if (popupActual == 0 && popupRuth != null) {
      image(popupRuth, width/2, height/2, anchoPopup, altoPopup);
    } else if (popupActual == 1 && popupGilarys != null) {
      image(popupGilarys, width/2, height/2, anchoPopup, altoPopup);
    } else if (popupActual == 2 && popupNashed != null) {
      image(popupNashed, width/2, height/2, anchoPopup, altoPopup);
    }
  }
  float anchoBoton = width * 0.28;
  float altoBoton  = height * 0.55;

  float xRuth    = width * 0.48;
  float yRuth    = height * 0.50;

  float xGilarys = width * 0.155;
  float yGilarys = height * 0.50;

  float xNashed  = width * 0.815;
  float yNashed  = height * 0.50;

// detectar hover
boolean hoverRuth = mouseX > xRuth - anchoBoton/2 && mouseX < xRuth + anchoBoton/2 &&
                    mouseY > yRuth - altoBoton/2 && mouseY < yRuth + altoBoton/2;

boolean hoverGilarys = mouseX > xGilarys - anchoBoton/2 && mouseX < xGilarys + anchoBoton/2 &&
                       mouseY > yGilarys - altoBoton/2 && mouseY < yGilarys + altoBoton/2;

boolean hoverNashed = mouseX > xNashed - anchoBoton/2 && mouseX < xNashed + anchoBoton/2 &&
                      mouseY > yNashed - altoBoton/2 && mouseY < yNashed + altoBoton/2;
  
// mostrar flechas centradas sobre cada personaje
if (!mostrarPopup) {
  if (hoverRuth)    dibujarFlecha(xRuth,    yRuth    - altoBoton/2 - 20);
  if (hoverGilarys) dibujarFlecha(xGilarys, yGilarys - altoBoton/2 - 20);
  if (hoverNashed)  dibujarFlecha(xNashed,  yNashed  - altoBoton/2 - 20);
}  
  popStyle();
}

// ========================================
// CONTROL CON MOUSE
// ========================================
void controlarCreditos() {
  float xVolver = width - 110;
  float yVolver = 60;
  float tamanoVolverX = width * 0.12;
  float tamanoVolverY = tamanoVolverX * 0.4;
  
  // Botón volver
  if (mouseX > xVolver - tamanoVolverX/2 && mouseX < xVolver + tamanoVolverX/2 &&
      mouseY > yVolver - tamanoVolverY/2 && mouseY < yVolver + tamanoVolverY/2) {
    if (mostrarPopup) {
      mostrarPopup = false;
    } else {
      pantalla = 1;
    }
    return;
  }
  
  if (mostrarPopup) {
    mostrarPopup = false;
    return;
  }
  
  float anchoBoton = width * 0.28;
  float altoBoton  = height * 0.55;

  float xRuth    = width * 0.48;
  float yRuth    = height * 0.50;

  float xGilarys = width * 0.155;
  float yGilarys = height * 0.50;

  float xNashed  = width * 0.815;
  float yNashed  = height * 0.50;

  // Ruth
  if (mouseX > xRuth - anchoBoton/2 && mouseX < xRuth + anchoBoton/2 &&
      mouseY > yRuth - altoBoton/2  && mouseY < yRuth + altoBoton/2) {
    mostrarPopup = true;
    popupActual  = 0;  // popup de Ruth
    return;
  }
  // Gilarys
  if (mouseX > xGilarys - anchoBoton/2 && mouseX < xGilarys + anchoBoton/2 &&
      mouseY > yGilarys - altoBoton/2  && mouseY < yGilarys + altoBoton/2) {
    mostrarPopup = true;
    popupActual  = 1;  // popup de Gilarys
    return;
  }
  // Nashed
  if (mouseX > xNashed - anchoBoton/2 && mouseX < xNashed + anchoBoton/2 &&
      mouseY > yNashed - altoBoton/2  && mouseY < yNashed + altoBoton/2) {
    mostrarPopup = true;
    popupActual  = 2;  // popup de Nashed
    return;
  }
}

// ========================================
// CONTROL CON TECLADO
// ========================================
void controlarCreditosTeclado() {
  if (keyCode == ESC) {
    if (mostrarPopup) {
      mostrarPopup = false;  // Cerrar popup
    } else {
      pantalla = 1;  // Volver al menú
    }
  }
}

void dibujarFlecha(float x, float y) {
  stroke(255);
  strokeWeight(3);
  fill(180, 120, 255);

  float w = 30;
  float h = 40;

  triangle(
    x, y,
    x - w, y - h,
    x + w, y - h
  );

  noStroke();
}
