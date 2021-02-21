/* @pjs preload="kasuga.png,umi.jpg"; */
PImage img;
PImage img1;

void setup(){
  size(1200,1200);
  noLoop();
  fill(10);
  img = loadImage("kasuga.png");
  img1 = loadImage("kasuga.png");
}

void draw(){
    image(img,0,0);
    image(img1,600,0);
    text("test",10,100);
}
