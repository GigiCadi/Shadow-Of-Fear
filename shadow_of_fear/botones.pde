void dibujarBotonConSombra(PImage img, float x, float y, float w, float h) {
  pushStyle();

  boolean hover = mouseX > x - w/2 && mouseX < x + w/2 &&
                  mouseY > y - h/2 && mouseY < y + h/2;

  float offset = hover ? 3 : 6; 
  float escala = hover ? 1.05 : 1;

  // sombra
  tint(0, 120);
  image(img, x + offset, y + offset, w * escala, h * escala);

  // botón
  noTint();
  image(img, x, y, w * escala, h * escala);

  popStyle();
}
