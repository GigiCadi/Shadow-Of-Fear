// ==========================
// PANTALLA DE CRÉDITOS
// ==========================

void pantallaCreditos() {
  pushStyle();
  
  // ========================================
  // 1. FONDO PRINCIPAL (popup_creditos.png)
  // ========================================
  imageMode(CORNER);
  if (fondoCreditos != null) {
    image(fondoCreditos, 0, 0, width, height);
  } else {
    background(30, 25, 55);
  }
  
  // ========================================
  // 2. BOTÓN VOLVER
  // ========================================
  imageMode(CENTER);
  float tamanoVolverX = width * 0.12;
  float tamanoVolverY = tamanoVolverX * 0.4;
  float xVolver = width - 70;
  float yVolver = 60;
  
  if (btnvolver != null) {
    image(btnvolver, xVolver, yVolver, tamanoVolverX, tamanoVolverY);
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
  
  // ========================================
  // 3. SI HAY POPUP ABIERTO, OSCURECER FONDO Y MOSTRAR POPUP
  // ========================================
  if (mostrarPopup) {
    // Capa oscura semitransparente encima del fondo
    fill(0, 180);
    noStroke();
    rect(0, 0, width, height);
    
    // Mostrar el popup correspondiente
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
  
  popStyle();
}

// ========================================
// CONTROL CON MOUSE
// ========================================
void controlarCreditos() {
  float xVolver = width - 70;
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
  
  float anchoBoton = width * 0.15;
  float altoBoton = anchoBoton * 0.35;
  
  float xRuth = width * 0.25;
  float yRuth = height * 0.7;
  
  float xGilarys = width * 0.5;
  float yGilarys = height * 0.7;
  
  float xNashed = width * 0.75;
  float yNashed = height * 0.7;
  
  // ========================================
  // INTERCAMBIADO: Ruth muestra popup de Gilarys
  // ========================================
  // Ruth (muestra popup de Gilarys)
  if (mouseX > xRuth - anchoBoton/2 && mouseX < xRuth + anchoBoton/2 &&
      mouseY > yRuth - altoBoton/2 && mouseY < yRuth + altoBoton/2) {
    println("Click en RUTH - muestra popup de GILARYS");
    mostrarPopup = true;
    popupActual = 1;  // Ahora 1 = Gilarys
  }
  // Gilarys (muestra popup de Ruth)
  else if (mouseX > xGilarys - anchoBoton/2 && mouseX < xGilarys + anchoBoton/2 &&
           mouseY > yGilarys - altoBoton/2 && mouseY < yGilarys + altoBoton/2) {
    println("Click en GILARYS - muestra popup de RUTH");
    mostrarPopup = true;
    popupActual = 0;  // Ahora 0 = Ruth
  }
  // Nashed (sin cambios)
  else if (mouseX > xNashed - anchoBoton/2 && mouseX < xNashed + anchoBoton/2 &&
           mouseY > yNashed - altoBoton/2 && mouseY < yNashed + altoBoton/2) {
    println("Click en NASHED");
    mostrarPopup = true;
    popupActual = 2;
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
