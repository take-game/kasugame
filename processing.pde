/* @pjs preload="kasuga.png"; */
PImage img;

void setup(){
  size(1200,1200);
  noLoop();
  fill(10);
  img = loadImage("kasuga.png");
}

void draw(){
    image(img,0,0);
    text("test",10,100);
}
