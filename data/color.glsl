#ifdef GL_ES
precision mediump float;
#endif

//Variables uniformes
uniform vec2 resolution; // Dimeniones lienzo (width,height)
uniform float time;      // Segundos desde carga

uniform vec2 color; 

void main() {
  
  vec2 mouse = color/resolution;
  gl_FragColor = vec4(mouse.x,mouse.y,abs(sin(mouse.y)),1.0);
}