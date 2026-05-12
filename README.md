# 🎮 Shadow of Fear: Ali’s Story

**Shadow of Fear: Ali’s Story** es un videojuego narrativo que aborda el bullying y el ciberacoso mediante tres minijuegos interactivos.
Controlas a Ali, una chica que debe enfrentar distintas situaciones de acoso, tomar decisiones y aprender a pedir ayuda.

* Proyecto desarrollado como trabajo final para la asignatura de Programación (Processing).

---

## 📖 Acerca del juego

- **Temática**: Bullying, ciberacoso, salud emocional, toma de decisiones.
- **Plataforma**: Processing 4.4.10 (Java).
- **Género**: Aventura narrativa + minijuegos (puzzle, arcade, diálogos).
- **Idioma**: Español (interfaz, diálogos y textos).

### Los tres niveles

1. **Ciberbullying** – Frente a la pantalla, corrige comentarios ofensivos usando las herramientas “Eliminar” o “Reemplazar”. Cuida tu energía emocional.
2. **Hallways of Silence** – Laberinto en vista cenital. Evita al bully, recolecta objetos y llega a la oficina del rector para pedir ayuda.
3. **Mortal Hit** – Sistema de diálogos con decisiones progresivas. Cada elección acumula moral y desbloquea uno de tres finales.

---

## ⚙️ Requisitos del sistema

| Componente      | Mínimo                                          |
|----------------|-------------------------------------------------|
| **Sistema**     | Windows / macOS / Linux (cualquiera que ejecute Processing) |
| **Procesador**  | 2 GHz                                           |
| **Memoria RAM** | 4 GB                                            |
| **Gráficos**    | Cualquier tarjeta compatible con OpenGL 2.0    |
| **Resolución**  | 1366×768 o superior (se ajusta automáticamente) |
| **Software**    | [Processing 4](https://processing.org/download) |

### Librería necesaria
- **Sound** de Processing (para música y efectos de sonido).  
  Se instala desde el gestor de librerías del IDE: `Sketch → Import Library → Add Library... → Sound`.

---

## 📥 Instalación y ejecución

Sigue estos pasos para ejecutar el juego en tu ordenador:

1. **Descarga el repositorio**  
   - Puedes clonarlo o descargar el ZIP desde GitHub.
   - Si descargas el ZIP, descomprímelo en una carpeta.

2. **Abre el proyecto en Processing**  
   - Abre el IDE de Processing.
   - Ve a `File → Open...` y selecciona el archivo `shadow_of_fear.pde` principal.  
   - Processing cargará automáticamente el resto de archivos `.pde` del proyecto.

3. **Instala la librería de sonido** (si no la tienes)  
   - En el menú: `Sketch → Import Library → Add Library...`
   - Busca `Sound` (de Processing Foundation) e instala.

4. **Verifica las carpetas de recursos**  
   - Asegúrate de que las carpetas `imagenes/`, `musica/` y `fuentes/` estén dentro del mismo directorio que los `.pde`.
   - El juego espera las siguientes subcarpetas:
