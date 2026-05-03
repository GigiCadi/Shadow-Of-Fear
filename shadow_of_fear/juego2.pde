// ================================================================
// JUEGO 2: HALLWAYS OF SILENCE
// ================================================================

boolean DEBUG_MODE = false;

// ================================================================

int j2_estado = 0;
boolean j2_iniciado = false;

boolean j2_kUp    = false;
boolean j2_kDown  = false;
boolean j2_kLeft  = false;
boolean j2_kRight = false;

// ----- Jugador -----
float j2_x, j2_y;
int   j2_dir    = 0;
boolean j2_mov  = false;
int j2_frameA   = 0;
int j2_timerA   = 0;
final int   J2_VEL_ANIM = 8;
final float J2_SPD      = 3.7;
final int   J2_SW       = 52;
final int   J2_SH       = 68;

// ----- Congelamiento -----
boolean j2_cong      = false;
int     j2_timerCong = 0;
final int J2_CONG_MAX = 300;

// ----- Bully -----
float b2_x, b2_y;
int   b2_dir    = 3;
int   b2_frameA = 0;
int   b2_timerA = 0;
final int   B2_VEL_ANIM = 12;
final float B2_SPD      = 2.5;
final int   B2_SW       = 52;
final int   B2_SH       = 68;
int       b2_wp  = 0;
float[][] b2_wps;

// ----- Plátanos -----
final int   J2_N_PLAT = 12;
float[]     j2_px  = new float[J2_N_PLAT];
float[]     j2_py  = new float[J2_N_PLAT];
boolean[]   j2_pOn = new boolean[J2_N_PLAT];
int[]       j2_pTimer = new int[J2_N_PLAT]; 
final int   J2_PLAT_RESPAWN = 600;         
final float J2_PLAT_R = 24;

// ----- Rector -----
float j2_rx, j2_ry;
float rectorOfficeX, rectorOfficeY;
final float rectorOfficeW = 230;
final float rectorOfficeH = 200;
final float J2_RECT_R = 28;
final float RECTOR_OFFICE_X = width - 500;
final float RECTOR_OFFICE_Y = height - 250;


// ================================================================
// PAREDES — coordenadas absolutas en píxeles (de vercolisiones)
// ================================================================
final float[][] J2_WALL_ABS = {
  {300,  20,  970,  90},
  {300, 110,  140, 100},
  {495,  20,   10, 190},
  {440, 185,   15,  25},
  {505, 180,   32,  30},
  {310, 210,   10,  65},
  {292, 270,   70,  35},
  {292, 305,   10, 315},
  {280, 615,  130,  35},
  {280, 650,   10, 150},
  {290, 650,   38,  60},
  {280, 800,  990,  30},
  {300, 350,   60,  55},
  {300, 400,   50, 215},
  {1260, 110,  12, 690},
  {690, 110,   10,  75},
  {655, 178,   50,  35},
  {740, 180,  270,  30},
  {745, 110,  180,  70},
  {1065, 110,  10,  85},
  {1043, 180,  48,  50},
  {1125, 190, 135,  38},
  {455, 265,   10, 300},
  {465, 265,   43,  55},
  {534, 264,   68,  57},
  {640, 264,   52,  57},
  {725, 264,  280,  57},
  {465, 345,  220,  40},
  {670, 385,   15, 165},
  {455, 550,  105,  35},
  {610, 550,   75,  35},
  {725, 370,   14, 165},
  {725, 530,  167,  55},
  {960, 530,   45,  55},
  {798, 358,   40,  45},
  {830, 416,   30,  58},
  {896, 348,   30, 142},
  {964, 348,   30, 142},
  {995, 320,   10, 220},
  {454, 615,  120,  40},
  {450, 654,  100,  50},
  {572, 615,   10, 185},
  {640, 615,  165, 145},
  {330, 745,  210,  55},
  {852, 635,  180, 126},
  {1030, 616,  10, 190},
  {1075, 616, 195,  90},
  {1072, 552, 100,  30},
  {1072, 527,  35,  25},
  {1220, 552,  40,  30},
  {1075, 444,  18,  34},
  {1075, 270,  12, 180},
  {1087, 270, 180,  80},
  {1127, 350, 140, 130},
  {1135, 705,  80,  60},
  {1235, 760,  20,  25},
  {1055, 780,  30,  20},
  {1105, 125,  60,  50},
  {1165, 125,  60,  20},
  {1235, 165,  20,  20},
  {520,  428,  86,  92},
  {778,  788,  40,  12},
};

// Límites del área jugable en píxeles absolutos
final float MAP_ABS_X0 = 280;
final float MAP_ABS_X1 = 1272;
final float MAP_ABS_Y0 = 20;
final float MAP_ABS_Y1 = 830;

// Estas funciones se mantienen para compatibilidad con waypoints y posiciones iniciales
final float MAP_X0 = 0.198f;
final float MAP_X1 = 0.824f;
final float MAP_Y0 = 0.020f;
final float MAP_Y1 = 0.950f;

float mx(float f) { return MAP_X0 * width  + f * (MAP_X1 - MAP_X0) * width;  }
float my(float f) { return MAP_Y0 * height + f * (MAP_Y1 - MAP_Y0) * height; }


final float MARGEN_PARED = 18;        // Distancia mínima a las paredes
final float RADIO_SEPARACION = 40;    // Distancia mínima entre plátanos
final float RADIO_EXCLUIR_RECTOR = 50; // Evitar zona del rector
final float RADIO_EXCLUIR_SPAWN = 55;  // Evitar zona de inicio del jugador
// ================================================================
// INICIALIZAR
// ================================================================
void iniciarJuego2() {
  detenerAudiosFinales();
  j2_estado    = 0;
  j2_iniciado  = true;
  j2_cong      = false;
  j2_timerCong = 0;
  j2_kUp = j2_kDown = j2_kLeft = j2_kRight = false;

  // Jugador: pasillo izquierdo, zona media
  j2_x = 395;
  j2_y = 470;
  j2_dir    = 3;
  j2_mov    = false;
  j2_frameA = 1;
  j2_timerA = 0;

  // Rector: oficina de orientación (abajo derecha del mapa)
  j2_rx = 1130;
  j2_ry = 680;

  // Bully: empieza en pasillo superior
  b2_x      = 394;
  b2_y      = 217;
  b2_dir    = 3;
  b2_frameA = 0;
  b2_timerA = 0;
  b2_wp     = 0;

  // Waypoints del bully - coordenadas de PIES (centro sprite = pie_y - 27)
  b2_wps = new float[][] {
    {394,  217},   // WP0  esquina sup-izq
    {710,  217},   // WP1  pasillo sup centro
    {1040, 217},   // WP2  esquina sup-der
    {1040, 395},   // WP3  pasillo der alto
    {1040, 573},   // WP4  esquina inf-der
    {834,  573},   // WP5  pasillo inf der
    {614,  573},   // WP6  pasillo inf centro
    {394,  573},   // WP7  esquina inf-izq
    {394,  395},   // WP8  pasillo izq medio
    {394,  217},   // WP9  cierra loop
  };

int intentosMaximos = 500; // Para evitar bucles infinitos
for (int i = 0; i < J2_N_PLAT; i++) {
  boolean encontrado = false;
  int intentos = 0;
  while (!encontrado && intentos < intentosMaximos) {
    float randX = random(MAP_ABS_X0 + MARGEN_PARED, MAP_ABS_X1 - MARGEN_PARED);
    float randY = random(MAP_ABS_Y0 + MARGEN_PARED, MAP_ABS_Y1 - MARGEN_PARED);
    
    // Comprobar si el punto es válido (paredes, rector, spawn)
    if (puntoValidoBanana(randX, randY)) {
      // Comprobar distancia a los plátanos ya colocados
      boolean cercaOtro = false;
      for (int j = 0; j < i; j++) {
        float dx = randX - j2_px[j];
        float dy = randY - j2_py[j];
        if (sqrt(dx*dx + dy*dy) < RADIO_SEPARACION) {
          cercaOtro = true;
          break;
        }
      }
      if (!cercaOtro) {
        j2_px[i] = randX;
        j2_py[i] = randY;
        j2_pOn[i] = true;
        j2_pTimer[i] = 0;
        encontrado = true;
      }
    }
    intentos++;
  }
  if (!encontrado) {
    j2_px[i] = 500 + (i * 50);
    j2_py[i] = 217;
    j2_pOn[i] = true;
  }
}

  estadoPausa = 0;
  estadoFinal = 0;
  pantalla    = 5;
}

// ================================================================
// PANTALLA PRINCIPAL
// ================================================================
void nivelJuego2() {
  imageMode(CORNER);
  image(fondoJuego2, 0, 0, width, height);

  if (!j2_iniciado) return;

  if (j2_estado == 0) actualizarJuego2();

  dibujarElementosJ2();
  dibujarUIJuego2();

  if (j2_estado != 0) dibujarFinalJuego2();
  
}

// ================================================================
// ACTUALIZAR
// ================================================================
void actualizarJuego2() {
  if (!j2_cong) {
    moverJugadorJ2();
  } else {
    j2_timerCong--;
    if (j2_timerCong <= 0) { j2_cong = false; j2_timerCong = 0; }
    j2_mov    = false;
    j2_frameA = 1;
  }
  moverBullyJ2();
  verificarColisionesJ2();
  animarJugadorJ2();
  animarBullyJ2();
}

// ================================================================
// MOVIMIENTO DEL JUGADOR — límites absolutos
// ================================================================
void moverJugadorJ2() {
  float dx = 0, dy = 0;
  if (j2_kUp)    { dy = -J2_SPD; j2_dir = 1; }
  if (j2_kDown)  { dy =  J2_SPD; j2_dir = 0; }
  if (j2_kLeft)  { dx = -J2_SPD; j2_dir = 2; }
  if (j2_kRight) { dx =  J2_SPD; j2_dir = 3; }

  j2_mov = (dx != 0 || dy != 0);
  if (!j2_mov) return;

  // Límites del área jugable en píxeles absolutos
  float minX = MAP_ABS_X0 + J2_SW * 0.32;
  float maxX = MAP_ABS_X1 - J2_SW * 0.32;
  float minY = MAP_ABS_Y0 + J2_SH * 0.27;
  float maxY = MAP_ABS_Y1 - J2_SH * 0.49;

  float nx = constrain(j2_x + dx, minX, maxX);
  float ny = constrain(j2_y + dy, minY, maxY);

  if (!colisionaParedJ2(nx, j2_y)) j2_x = nx;
  if (!colisionaParedJ2(j2_x, ny)) j2_y = ny;
}

// ================================================================
// AABB — usa coordenadas absolutas directamente
// ================================================================
boolean colisionaParedJ2(float px, float py) {
  float hw  = J2_SW * 0.18;
  float top = py + J2_SH * 0.32;
  float bot = py + J2_SH * 0.45;
  float lft = px - hw;
  float rgt = px + hw;

  for (float[] w : J2_WALL_ABS) {
    if (lft < w[0] + w[2] && rgt > w[0] &&
        top < w[1] + w[3] && bot > w[1]) {
      return true;
    }
  }
  return false;
}

// Comprueba si un punto (x,y) está dentro de alguna pared
boolean puntoEnPared(float x, float y) {
  for (float[] w : J2_WALL_ABS) {
    // w = [x, y, ancho, alto]
    if (x >= w[0] && x <= w[0] + w[2] &&
        y >= w[1] && y <= w[1] + w[3]) {
      return true;
    }
  }
  return false;
}

boolean puntoValidoBanana(float x, float y) {
  //Límites del mapa con margen
  if (x < MAP_ABS_X0 + MARGEN_PARED || x > MAP_ABS_X1 - MARGEN_PARED ||
      y < MAP_ABS_Y0 + MARGEN_PARED || y > MAP_ABS_Y1 - MARGEN_PARED) {
    return false;
  }
  
  //Distancia a paredes (no estar dentro ni cerca)
  for (float[] w : J2_WALL_ABS) {
    float left = w[0] - MARGEN_PARED;
    float right = w[0] + w[2] + MARGEN_PARED;
    float top = w[1] - MARGEN_PARED;
    float bottom = w[1] + w[3] + MARGEN_PARED;
    if (x > left && x < right && y > top && y < bottom) {
      return false;
    }
  }
  
  //Excluir sala del rector (rectángulo)
  if (x > width - 500 && x < width - 500 + 230 &&
      y > height - 250 && y < height - 250 + 200) {
    return false;
  }
  
  //Excluir zona de inicio del jugador (círculo alrededor de 395, 470)
  float dxS = x - 395;
  float dyS = y - 470;
  if (sqrt(dxS*dxS + dyS*dyS) < RADIO_EXCLUIR_SPAWN) {
    return false;
  }
  
  return true;
}
// ================================================================
// MOVIMIENTO DEL BULLY
// ================================================================
void moverBullyJ2() {
  float tx = b2_wps[b2_wp][0];
  float ty = b2_wps[b2_wp][1];
  float dx = tx - b2_x;
  float dy = ty - b2_y;
  float d  = sqrt(dx*dx + dy*dy);

  if (d < B2_SPD + 1) {
    b2_x  = tx; b2_y = ty;
    b2_wp = (b2_wp + 1) % b2_wps.length;
  } else {
    float vx = dx/d * B2_SPD;
    float vy = dy/d * B2_SPD;
    b2_x += vx; b2_y += vy;
    if (abs(vx) >= abs(vy)) b2_dir = (vx > 0) ? 3 : 2;
    else                    b2_dir = (vy > 0) ? 0 : 1;
  }
}

// ================================================================
// COLISIONES
// ================================================================
void verificarColisionesJ2() {
  if (!j2_cong) {
    for (int i = 0; i < J2_N_PLAT; i++) {
      if (j2_pOn[i] && dist(j2_x, j2_y, j2_px[i], j2_py[i]) < J2_PLAT_R + 8) {
        j2_cong = true; 
        j2_timerCong = J2_CONG_MAX; 
        j2_pOn[i] = false;
        j2_pTimer[i] = J2_PLAT_RESPAWN;  // iniciar timer de reaparición
        if (caida != null) {
    caida.stop();   // evita solapamiento
    caida.play();
  }
  break;
      }
    }
  }
  
  // actualizar timers de reaparición
  for (int i = 0; i < J2_N_PLAT; i++) {
    if (!j2_pOn[i] && j2_pTimer[i] > 0) {
      j2_pTimer[i]--;
      if (j2_pTimer[i] <= 0) {
        j2_pOn[i] = true;
      }
    }
  }
  //derrota
  if (dist(j2_x, j2_y, b2_x, b2_y) < 46 && j2_estado == 0) { 
  j2_estado = 1;
  detenerAudioGeneral();
  if (musicaNivel2 != null && musicaNivel2.isPlaying()) {
    musicaNivel2.stop();
  }
  if (musicaMenu != null && musicaMenu.isPlaying()) {
    musicaMenu.stop();
  }
  if (sonidoVoz != null && sonidoVoz.isPlaying()) {
    sonidoVoz.stop();
  }
  if (derrota != null){
    derrota.stop();
    derrota.play();
  }
  
return; 
}
  if (dist(j2_x, j2_y, j2_rx, j2_ry) < J2_RECT_R + 20 && j2_estado == 0) {
    j2_estado = 2;
    detenerAudioGeneral();
    if (musicaNivel2 != null && musicaNivel2.isPlaying()) {
    musicaNivel2.stop();
  }
  if (musicaMenu != null && musicaMenu.isPlaying()) {
    musicaMenu.stop();
  }
  if (sonidoVoz != null && sonidoVoz.isPlaying()) {
    sonidoVoz.stop();
  }
    if (victoria != null){
      victoria.stop();
      victoria.play();
    }
}
}
// ================================================================
// ANIMACIONES
// ================================================================
void animarJugadorJ2() {
  if (j2_mov && !j2_cong) {
    j2_timerA++;
    if (j2_timerA >= J2_VEL_ANIM) { j2_timerA = 0; j2_frameA = (j2_frameA+1)%3; }
  } else { j2_frameA = 1; j2_timerA = 0; }
}

void animarBullyJ2() {
  b2_timerA++;
  if (b2_timerA >= B2_VEL_ANIM) { b2_timerA = 0; b2_frameA = (b2_frameA+1)%2; }
}

// ================================================================
// SPRITES
// ================================================================
PImage spriteJugadorJ2() {
  // Si está mareado, mostrar sprite de mareo
  if (j2_cong) {
    return protamareada;  // Usar la imagen de mareo cargada
  }
  
  // Comportamiento normal
  switch (j2_dir) {
    case 0: return protadown[j2_frameA];
    case 1: return protaup[j2_frameA];
    case 2: return protaleft[j2_frameA];
    case 3: return protaright[min(j2_frameA,1)];
    default: return protadown[1];
  }
}

PImage spriteBullyJ2() {
  switch (b2_dir) {
    case 0: return bullydown[b2_frameA];
    case 1: return bullyup[b2_frameA];
    case 2: return bullyleft[b2_frameA];
    case 3: return bullyright[b2_frameA];
    default: return bullydown[0];
  }
}

// ================================================================
// DIBUJAR ELEMENTOS
// ================================================================
void dibujarElementosJ2() {
  imageMode(CENTER);

  for (int i = 0; i < J2_N_PLAT; i++) {
    if (j2_pOn[i]) image(platano, j2_px[i], j2_py[i], 34, 34);
  }

  image(reptor, j2_rx, j2_ry, J2_SW, J2_SH);
  image(spriteBullyJ2(), b2_x, b2_y, B2_SW, B2_SH);
  
  // Dibujar jugador con tamaño según estado
  if (j2_cong) {
    image(spriteJugadorJ2(), j2_x, j2_y, J2_SW + 10, J2_SH + 8);  
  } else {
    image(spriteJugadorJ2(), j2_x, j2_y, J2_SW, J2_SH);
  }

  if (j2_cong) {
    pushStyle();
    
    // Círculos de vértigo alrededor de la cabeza
    noFill();
    for (int i = 0; i < 3; i++) {
      float radio = 30 + i * 6 + sin(frameCount * 0.15) * 5;
      stroke(255, 200, 80, 120 - i * 30);
      strokeWeight(2);
      ellipse(j2_x, j2_y + J2_SH*0.15, radio, radio);
    }
    
    // Líneas de mareo (espirales)
    stroke(255, 180, 60, 180);
    strokeWeight(2);
    for (int i = 0; i < 6; i++) {
      float angle = frameCount * 0.1 + i * PI / 3;
      float x1 = j2_x + cos(angle) * 28;
      float y1 = j2_y - 15 + sin(angle * 2) * 5;
      float x2 = j2_x + cos(angle + 0.3) * 38;
      float y2 = j2_y - 20 + sin(angle * 2 + 1) * 5;
      line(x1, y1, x2, y2);
    }
    
    // Estrellitas/espirales pequeñas alrededor
    noStroke();
    for (int i = 0; i < 4; i++) {
      float angle = frameCount * 0.2 + i * PI / 2;
      float radius = 40 + sin(frameCount * 0.1) * 5;
      float xOff = cos(angle) * radius;
      float yOff = sin(angle) * radius;
      
      fill(255, 220, 100, 150);
      ellipse(j2_x + xOff, j2_y + J2_SH*0.15 - 10 + yOff, 6, 6);
      fill(255, 180, 60, 120);
      ellipse(j2_x + xOff - 2, j2_y + J2_SH*0.15 - 8 + yOff, 3, 3);
    }
    
    // Texto de tiempo mareado
    noStroke();
    fill(53, 31, 64, 230);
    textFont(fuente); 
    textSize(12); 
    textAlign(CENTER, CENTER);
    
    float segundos = j2_timerCong / 60.0;
    String tiempoTexto = nf(segundos, 1, 1) + "s";
    
    // Fondo del texto
    fill(72, 50, 118, 200);
    rect(j2_x - textWidth(tiempoTexto)/2 - 10, j2_y - J2_SH*0.5 - 20, textWidth(tiempoTexto) + 20, 22, 8);
    
    fill(147, 150, 201);
    text(tiempoTexto, j2_x, j2_y - J2_SH*0.5 - 10);
    
    // Texto "¡RESBALASTE!" que aparece al inicio y se desvanece
    if (j2_timerCong > 240) {
      fill(51, 29, 62, 200 - j2_timerCong);
      textSize(10);
      text("¡RESBALASTE!", j2_x, j2_y - J2_SH*0.5 - 32);
    }
    
    popStyle();
  }
}

// ================================================================
// UI
// ================================================================
void dibujarUIJuego2() {
  dibujarUI();
  if (j2_cong && j2_estado == 0) {
    noStroke();
    fill(72, 50, 118);
    rect(width/2-240, 16, 480, 46, 8);
    fill(147, 150, 201);
    textFont(fuente); textSize(12); textAlign(CENTER, CENTER);
    text("¡RESBALASTE CON UN PLÁTANO!   "+nf(j2_timerCong/60.0,1,1)+"s", width/2, 39);
    ;
  }
}

// ================================================================
// PANTALLA FINAL
// ================================================================
int opcionFinalJuego2 = 0;
String[] opcionesFinalJuego2 = {"Volver a intentar", "Volver al menú"};

void dibujarFinalJuego2() {
  pushStyle();
  
  // ============================================================
  // 1. IMAGEN DE FONDO (victoria o derrota)
  // ============================================================
  imageMode(CORNER);
  
  if (j2_estado == 2 && fondoVictoria != null) {
    // Imagen de victoria
    tint(255, 240);
    image(fondoVictoria, 0, 0, width, height);
    noTint();
  } 
  else if (j2_estado == 1 && fondoDerrota != null) {
    // Imagen de derrota
    tint(255, 240);
    image(fondoDerrota, 0, 0, width, height);
    noTint();
  }
  
  // ============================================================
  // 2. CAPA OSCURA SEMITRANSPARENTE
  // ============================================================
  fill(0, 180);
  noStroke();
  rect(0, 0, width, height);
  
  // ============================================================
  // 3. TEXTO Y OPCIONES
  // ============================================================
  textFont(fuente);
  textAlign(CENTER, CENTER);

  if (j2_estado == 2) {
    fill(190, 165, 255);
    textSize(26);
    text("¡LLEGASTE A LA OFICINA!", width/2, height/2-110);
    fill(230, 245, 230);
    textSize(13);
    text("Encontraste ayuda. Eres más valiente de lo que crees.", width/2, height/2-58);
  } else if (j2_estado == 1) {
    fill(255, 80, 80);
    textSize(26);
    text("EL BULLY TE ATRAPÓ", width/2, height/2-110);
    fill(245, 220, 220);
    textSize(13);
    text("Busca otro camino. No te rindas.", width/2, height/2-58);
  }

  int yBase = height/2 - 10;
  int espacioY = 55;
  
  for (int i = 0; i < opcionesFinalJuego2.length; i++) {
    int yOpc = yBase + i * espacioY;
    
    if (i == opcionFinalJuego2) {
      fill(190, 165, 255);
      text("> " + opcionesFinalJuego2[i], width/2, yOpc);
    } else {
      fill(245, 235, 255);
      text(opcionesFinalJuego2[i], width/2, yOpc);
    }
  }
  
  popStyle();
}

void clicFinalJuego2() {
  int yBase = height/2 - 10;
  int espacioY = 55;
  
  // Opción 1: Volver a intentar
  if (mouseX > width/2 - 220 && mouseX < width/2 + 220 &&
      mouseY > yBase - 22 && mouseY < yBase + 22) {
    iniciarJuego2();
    return;
  }
  // Opción 2: Volver al menú
  int yMenu = yBase + espacioY;
  if (mouseX > width/2 - 220 && mouseX < width/2 + 220 &&
      mouseY > yMenu - 22 && mouseY < yMenu + 22) {
    j2_estado = 0;
    j2_iniciado = false;
    estadoPausa = 0;
    if (victoria != null && victoria.isPlaying()) {
  victoria.stop();
}
if (derrota != null && derrota.isPlaying()) {
  derrota.stop();
}
detenerTodaMusica();
detenerAudiosFinales();
    pantalla = 1;
  }
}

void controlarFinalJuego2Teclado() {
  if (keyCode == UP) {
    opcionFinalJuego2--;
    if (opcionFinalJuego2 < 0) {
      opcionFinalJuego2 = opcionesFinalJuego2.length - 1;
    }
  }
  else if (keyCode == DOWN) {
    opcionFinalJuego2++;
    if (opcionFinalJuego2 >= opcionesFinalJuego2.length) {
      opcionFinalJuego2 = 0;
    }
  }
  else if (key == ' ' || keyCode == ENTER) {
    if (opcionFinalJuego2 == 0) {
      iniciarJuego2();
    } else if (opcionFinalJuego2 == 1) {
      detenerAudiosFinales();
      j2_estado = 0;
      j2_iniciado = false;
      estadoPausa = 0;
      pantalla = 1;
    }
  }
}

// ================================================================
// TECLADO
// ================================================================
void j2_keyPressed() {
  if (keyCode == ESC) {
    if (j2_estado != 0) { j2_estado=0; j2_iniciado=false; pantalla=1; detenerTodaMusica(); }
    else { 
      pantallaOrigen=5;
      estadoPausa=1;
      opcionPausa=0; 
      tipoPausa = 1;
    }
    return;
  }
  if (j2_estado != 0) return;
  if (keyCode==UP    || key=='w' || key=='W') j2_kUp    = true;
  if (keyCode==DOWN  || key=='s' || key=='S') j2_kDown  = true;
  if (keyCode==LEFT  || key=='a' || key=='A') j2_kLeft  = true;
  if (keyCode==RIGHT || key=='d' || key=='D') j2_kRight = true;
}

void j2_keyReleased() {
  if (keyCode==UP    || key=='w' || key=='W') j2_kUp    = false;
  if (keyCode==DOWN  || key=='s' || key=='S') j2_kDown  = false;
  if (keyCode==LEFT  || key=='a' || key=='A') j2_kLeft  = false;
  if (keyCode==RIGHT || key=='d' || key=='D') j2_kRight = false;
}
void controlarPausaJuego2Teclado() {
  String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};
  
  if (keyCode == UP) {
    opcionPausa--;
    if (opcionPausa < 0) opcionPausa = opciones.length - 1;
  }
  else if (keyCode == DOWN) {
    opcionPausa++;
    if (opcionPausa >= opciones.length) opcionPausa = 0;
  }
  else if (key == ' ' || keyCode == ENTER) {
    if (opcionPausa == 0) {
      estadoPausa = 0;
    }
    else if (opcionPausa == 1) {
      estadoPausa = 0;
      iniciarJuego2();
    }
    else if (opcionPausa == 2) {
      estadoPausa = 0;
      detenerTodaMusica(); 
      pantalla = 1;
    }
  }
}

void controlarPausaJuego2Mouse() {
  String[] opciones = {"Continuar", "Reiniciar", "Volver al menú"};
  int ancho = 430;
  int alto = 42;
  int xCentro = width / 2;
  int yInicial = height / 2 - 10;
  int espacioY = 55;

  for (int i = 0; i < opciones.length; i++) {
    int y = yInicial + i * espacioY;
    if (mouseX > xCentro - ancho/2 && mouseX < xCentro + ancho/2 &&
        mouseY > y - alto/2 && mouseY < y + alto/2) {
      opcionPausa = i;
      if (i == 0) estadoPausa = 0;
      else if (i == 1) {
        estadoPausa = 0;
        iniciarJuego2();
      }
      else if (i == 2) {
        estadoPausa = 0;
        pantalla = 1;
      }
      return;
    }
  }
}


void reiniciarJuego2() {
  iniciarJuego2();
}
