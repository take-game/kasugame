PImage img;

void setup(){
  size(500,400);
  noLoop();
  fill(10);
  img = loadImage("kasuga.jpeg");
}

void draw(){
    text("test",10,100);
    image(img,0,0);
}
