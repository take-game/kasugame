/* @pjs preload="kasuga.png"; */
PImage img;

void setup(){
  size(500,400);
  noLoop();
  fill(10);
  img = loadImage("kasuga.png");
}

void draw(){
    text("test",10,100);
    image(img,0,0);
}
