# Creando-Interfaces-de-Usuario
## Practica 9 - Shaders
### Autor - Rubén Garcia Quintana

### Introducción.
La práctica consiste en esperimentar el uso de shaders en processing.

![](gif.gif)

### Desarrollo.
 - - Para esta práctica se ha decidido aplicar dos shader, uno a un elemento PShape3D y otro a una imagen. En concreto se modifica una foto de un perro bastante famosa en las redes sociales recientemente por diversas ediciones.
 
 - Para esta práctica se ha utilizado conceptos básicos de processing ya explicados durante la asignatura anteriormente.
 - Además se han incluido dos archivos ".glsl" para la utilización de los shaders.
 - Además se ha trabajado con la libreria AudioPlayer de minim para dar un mejor toque a la version final, al tener más opciones que    AudioSample
 
 #Shader para la Figura 3D:
 
  ```
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
  
```  
  
- Uso en processing:
   
```  
      pushMatrix();
    if((alturaBola-bajar)<-15)alturaBola+=3;
    resetShader();
    
    
  toon = loadShader("color.glsl");
  toon.set("resolution", float(width), float(height));
  toon.set("color", random(0,255), random(0,255));
  toon.set("time", millis() / 100.0);
  
  
    shader(toon);
    
    translate(width/2,alturaBola-bajar);
    shape(esfera);
    esfera.rotateY(0.051);
    popMatrix();
   ```
   
   
   
 #Shader para la imagen:
 
 ```
 #ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

const vec4  kRGBToYPrime = vec4 (0.299, 0.587, 0.114, 0.0);
const vec4  kRGBToI     = vec4 (0.596, -0.275, -0.321, 0.0);
const vec4  kRGBToQ     = vec4 (0.212, -0.523, 0.311, 0.0);

const vec4  kYIQToR   = vec4 (1.0, 0.956, 0.621, 0.0);
const vec4  kYIQToG   = vec4 (1.0, -0.272, -0.647, 0.0);
const vec4  kYIQToB   = vec4 (1.0, -1.107, 1.704, 0.0);

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform float hue;

void main ()
{
    // Sample the input pixel
	vec4 color = texture2D(texture, vertTexCoord.st).rgba;

    // Convert to YIQ
    float   YPrime  = dot (color, kRGBToYPrime);
    float   I      = dot (color, kRGBToI);
    float   Q      = dot (color, kRGBToQ);

    // Calculate the chroma
    float   chroma  = sqrt (I * I + Q * Q);

    // Convert desired hue back to YIQ
    Q = chroma * sin (hue);
    I = chroma * cos (hue);

    // Convert back to RGB
    vec4    yIQ   = vec4 (YPrime, I, Q, 0.0);
    color.r = dot (yIQ, kYIQToR);
    color.g = dot (yIQ, kYIQToG);
    color.b = dot (yIQ, kYIQToB);

    // Save the result
    gl_FragColor    = color;
}
 ```
    
- Uso en processing:
  En caso de pulsar enter la variable "flag" pasa a tener valor TRUE, de modo que se crea y se usa el shader. En caso contrario, lo reseteamos.
```
  if(flag){
  shade.set("hue", map(random(width), 1000, random(height), 1000, TWO_PI));
  shader(shade);
  dog2.resize(width, height);
  sound.play();
  image(dog2, 0, 0);
  
  }else{

  resetShader();
  if(alturaBola<-15)alturaBola+=3;
  dog1.resize(width, height);
  image(dog1, 0, 0);
    sound.pause();
  }
```

    
### Instrucciones de uso.
  - Pulsando ENTER se puede iniciar y pausar la fiesta.
  
  
### Herramientas y Referencias.
  
  - [Conversor de mp4 a GIF] https://convertio.co/es/
  
  - [Referencias shaders] (https://processing.org/tutorials/pshader/)
