  import ddf.minim.*;
  
PImage dog1,dog2;
PShader shade,toon;
boolean flag;
PShape esfera;
int alturaBola,bajar;
  Minim sonido;
  AudioPlayer sound;
void setup() {
  size(640, 480, P3D);
  sonido = new Minim(this);
  sound= sonido.loadFile("caramel.mp3",1000);
  dog1 = loadImage("dog1.jpg");
  dog2 = loadImage("dog2.jpg");
  shade = loadShader("hue.glsl");
  esfera = createShape(SPHERE, 100);
  frameRate(10);
  alturaBola=-110;
  bajar=0;
  sound.skip(50000);
}


void draw() {
  background(0);
  
  
  
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
  bolaDisco();
  menu();
if ( sound.position() == sound.length() )sound.rewind();
}


void keyPressed() {

  if (keyCode == ENTER)flag=!flag;
}



void bolaDisco(){
  
  if(flag){
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
  }else{
  if((alturaBola-bajar)>-110)bajar+=3;
    pushMatrix();
    translate(width/2,alturaBola-bajar);
    shape(esfera);
    esfera.rotateY(0.1);
    popMatrix();
    
  }
  

}


void menu(){
  resetShader();
  textSize(16);
  text("ENTER: Para iniciar/pausar\nla fiesta",10,15);
}
