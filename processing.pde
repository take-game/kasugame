/* @pjs preload="kasuga.png"; */
PImage img;

void setup(){
  size(1200,1200);
  noLoop();
  fill(10);
  img = loadImage("kasuga.png");
}

void draw(){
    text("test",10,100);
    image(img,0,0);
}
