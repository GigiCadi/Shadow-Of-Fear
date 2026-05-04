
// ========================================
// ACTUALIZAR TEXTO (EFECTO ESCRITURA)
// ========================================
void actualizarTexto() {
  if (indiceTexto < textoCompleto.length()) {
    contadorTexto++;
    
    if (contadorTexto >= velocidadTexto) {
      textoVisible += textoCompleto.charAt(indiceTexto);
      indiceTexto++;
      contadorTexto = 0;

      delayVoz++;

      if (delayVoz >= intervaloVoz && sonidoVoz != null) {
        sonidoVoz.play();
        delayVoz = 0;
      }
    }
  }
}
