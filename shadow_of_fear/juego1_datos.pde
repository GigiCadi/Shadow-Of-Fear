// ==========================
// DATOS DEL JUEGO 1 POR MODO
// ==========================

// ==========================
// MODO FÁCIL
// ==========================
String[] mensajesFacil = {
  "Eres raro",
  "Nadie te quiere",
  "No encajas",
  "Eres inutil",
  "Eres feo",
  "Eres tonto",
  "No vales",
  "Eres debil"
};

String[] respuestasFacil = {
  "Eres unico",
  "Todos te quieren",
  "Encajas",
  "Eres capaz",
  "Eres especial",
  "Eres inteligente",
  "Vales",
  "Eres fuerte"
};

String[] bancoPalabrasFacil = {
  "unico",
  "todos",
  "capaz",
  "especial",
  "inteligente",
  "fuerte",
  "vales"
};

// 1 = eliminar, 2 = reemplazar
int[] accionCorrectaFacil = {
  2, 2, 1, 2, 2, 2, 1, 2
};

// índice de la palabra ofensiva correcta dentro del mensaje
int[] palabraCorrectaFacil = {
  1, 0, 0, 1, 1, 1, 0, 1
};

// ==========================
// MODO NORMAL
// ==========================
String[] mensajesNormal = {
  "No mereces respeto",
  "Eres incapaz de aprender",
  "No puedes mejorar",
  "Eres debil ante los problemas",
  "No tienes derecho a opinar",
  "Nadie aprecia tu esfuerzo",
  "No deberias expresar tus ideas",
  "Eres inutil resolviendo esto",
  "Nadie valora lo que haces",
  "No puedes lograrlo"
};

String[] respuestasNormal = {
  "Mereces respeto",
  "Eres capaz de aprender",
  "Puedes mejorar",
  "Eres fuerte ante los problemas",
  "Tienes derecho a opinar",
  "Todos aprecian tu esfuerzo",
  "Deberias expresar tus ideas",
  "Eres capaz resolviendo esto",
  "Todos valoran lo que haces",
  "Puedes lograrlo"
};

String[] bancoPalabrasNormal = {
  "capaz",
  "fuerte",
  "todos",
  "valioso",
  "importante",
  "respetan",
  "puedes"
};

// 1 = eliminar, 2 = reemplazar
int[] accionCorrectaNormal = {
  1, 2, 1, 2, 1, 2, 1, 2, 2, 1
};

int[] palabraCorrectaNormal = {
  0, 1, 0, 1, 0, 0, 0, 1, 0, 0
};

// ==========================
// MODO DIFÍCIL
// ==========================
String[] mensajesDificil = {
  "No deberias expresar tus ideas",
  "Eres incapaz de resolver problemas complejos",
  "No mereces participar en el grupo",
  "Nadie valora tu esfuerzo constante",
  "No puedes aprender cosas nuevas",
  "Eres debil frente a la presion",
  "No tienes nada valioso que aportar",
  "Nadie reconoce lo mucho que te esfuerzas"
};

String[] respuestasDificil = {
  "Deberias expresar tus ideas",
  "Eres capaz de resolver problemas complejos",
  "Mereces participar en el grupo",
  "Todos valoran tu esfuerzo constante",
  "Puedes aprender cosas nuevas",
  "Eres fuerte frente a la presion",
  "Tienes algo valioso que aportar",
  "Todos reconocen lo mucho que te esfuerzas"
};

String[] bancoPalabrasDificil = {
  "capaz",
  "todos",
  "fuerte",
  "algo",
  "valioso",
  "importante",
  "reconocen"
};

// 1 = eliminar, 2 = reemplazar
int[] accionCorrectaDificil = {
  1, 2, 1, 2, 1, 2, 2, 2
};

int[] palabraCorrectaDificil = {
  0, 1, 0, 0, 0, 1, 2, 0
};

// ==========================
// CARGAR DATOS SEGÚN MODO
// ==========================
void cargarDatosModoJuego1(int modo) {
  if (modo == MODO_FACIL) {
    mensajes = copiarStringArray(mensajesFacil);
    respuestas = copiarStringArray(respuestasFacil);
    bancoPalabras = copiarStringArray(bancoPalabrasFacil);
    accionCorrecta = copiarIntArray(accionCorrectaFacil);
    palabraCorrecta = copiarIntArray(palabraCorrectaFacil);
  }

  else if (modo == MODO_NORMAL) {
    mensajes = copiarStringArray(mensajesNormal);
    respuestas = copiarStringArray(respuestasNormal);
    bancoPalabras = copiarStringArray(bancoPalabrasNormal);
    accionCorrecta = copiarIntArray(accionCorrectaNormal);
    palabraCorrecta = copiarIntArray(palabraCorrectaNormal);
  }

  else if (modo == MODO_DIFICIL) {
    mensajes = copiarStringArray(mensajesDificil);
    respuestas = copiarStringArray(respuestasDificil);
    bancoPalabras = copiarStringArray(bancoPalabrasDificil);
    accionCorrecta = copiarIntArray(accionCorrectaDificil);
    palabraCorrecta = copiarIntArray(palabraCorrectaDificil);
  }
}

// ==========================
// COPIAR ARRAYS
// Esto evita que mezclarMensajes() dañe los datos originales.
// ==========================
String[] copiarStringArray(String[] original) {
  String[] copia = new String[original.length];

  for (int i = 0; i < original.length; i++) {
    copia[i] = original[i];
  }

  return copia;
}

int[] copiarIntArray(int[] original) {
  int[] copia = new int[original.length];

  for (int i = 0; i < original.length; i++) {
    copia[i] = original[i];
  }

  return copia;
}
