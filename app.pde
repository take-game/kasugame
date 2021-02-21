/* @pjs preload="dekkatyan.jpeg,kasuga.jpeg,matyamatya.jpeg,jouro.png,kawa.jpeg,pool.png,cosmo.jpg"; */

PImage img;
PImage img1;
PImage img2;
PImage img3;
PImage pkey;
PImage back;
PImage back1;
PImage back2;
PImage back3;
int gseq;
int mcnt;
int i_w;
int i_h;
int i_x;
int i_y;
float i_speed =4.5;
int e_x;
int e_y;
float e_diameter =10.5;
int e_ex; //1=on,0=off
int count;
int count2;
int G;
int p_x;
int p_y;
int p_w = 150;
int p_h = 150;
int HP;
int v_x[]= new int [10];
int v_y[]= new int [10];
float v_diameter =10.5;
int v_ex[] = new int [10]; //1=on,0=off
int von;//1 =on,0=off
float vP;
float vv;
float sv_x[]= new float [10];
int sv_y[]= new int [10];
int sv_diameter =150;
int sv_ex[] = new int [10]; //1=on,0=off

void setup(){
  size(900,900);
  noStroke();
  
  img1 = loadImage("dekkatyan.jpeg");
  img2 = loadImage("kasuga.jpeg");
  img3 = loadImage("matyamatya.jpeg");
  pkey = loadImage("jouro.png");
  back1 = loadImage("kawa.jpeg");
  back2 = loadImage("pool.png");
  back3 = loadImage("cosmo.jpg");

  gameInit();
}
void draw(){
  background(0);
  if( gseq == 0){
    gameTitle();
  }else if( gseq == 1){
    gamePlay();
  }else if ( gseq == 2){
    gameOver();
  }else if ( gseq == 3){
    gameClear();
  }
}
void gameInit(){
  gseq= 0;
  mcnt = 0;
  count = 0;
  count2 = 0;
  i_x =width/2 - i_w/2;
  i_y =height - i_h ;
  i_w =200;
  i_h =200;
  G = 6;
  HP = 10;
  von =0;
  vP =10;
  vv =0;
  for(int i=0;i<10;i++){
  vClear(i);
  }
  for(int i=0;i<10;i++){
  svClear(i);
  }
}
void gamePlay(){
  bDisp();
  iDisp();
  iMove();
  pDisp();
  eDisp();
  eMove();
  vDisp();
  hitCheck();
  scoreDisp();
  if(HP<0){
    gseq = 2;
  }
  smooth();
}
void gameOver(){
  textSize(80);
  fill(255,255,0);
  text("GAME OVER",width/2-250,height/2-50);
  mcnt++;
  if((mcnt%60) <40){
    textSize(40);
    fill(255);
    text("Click to retry!",width/2-150,height/2+150);
  }
}
void gameTitle(){
  iDisp();
  bDisp();
  mcnt++;
  if((mcnt%60) < 40){
    textSize(80);
    fill(255,255,0);
    text("Click to start",width/2-250,height/2-50);
  }
}
void gameClear(){
  iDisp();
  mcnt++;
  if((mcnt%60) < 40){
    textSize(80);
    fill(255,255,0);
    text("Game Clear!!",width/2-250,height/2-50);
  }
}
void mousePressed(){
  if( gseq == 0 ){
    gseq = 1;
  }
  if( gseq == 2){
    gameInit();
  }
  if( gseq == 3 ){
    gameInit();
  }
}
void iDisp(){
  Shinka();
  image(img,i_x,i_y,i_w,i_h);
}
void iMove(){
  gravity();
  i_x+=  4*random(-i_speed, i_speed);
  i_y += 4*random(-i_speed, i_speed);
  i_x = constrain(i_x, i_w, width-i_w);
  i_y = constrain(i_y, i_h, height-i_h);
}
void bDisp(){
  image(back,0,0,height,width);
  strokeWeight(0);
  stroke(255);
  line(0,height/2,width,height/2);
}
void gravity(){
  i_y = i_y+G;
  if(e_ex==1){
  e_y = e_y+G;
  }
}
void eDisp(){
  if(e_ex==0)
  if(mousePressed == true) {
      if(mouseY < height/2){
      e_x=mouseX;
      e_y=mouseY;
      e_ex=1;
    }
  }  
  if(e_ex==1){
    strokeWeight(0);
    fill(255);
    ellipse(e_x, e_y, e_diameter,e_diameter);
  }
}
void eMove(){
  gravity();
  if(e_y+e_diameter > height){
  eClear();
  }
}
void eClear(){
    e_ex=0;
    e_x=0;
    e_y=0;
}
void vClear(int no){
    v_ex[no]=0;
    v_x[no]=i_x;
    v_y[no]=i_y;
}
void svClear(int no){
    sv_ex[no]=0;
    sv_x[no]=i_x;
    sv_y[no]=i_y;
}
void hitCheck(){
  if((i_x< (e_x+e_diameter)) &&((i_x+i_w) >e_x)
    &&(i_y <(e_y+e_diameter)) && ((i_y+i_h) > e_y)){
      eClear();
      count++;
    }
  for(int i=0;i<10;i++){
  if((mouseX< (v_x[i]+v_diameter)) &&((mouseX+p_w) >v_x[i])
    &&(mouseY <(v_y[i]+v_diameter)) && ((mouseY+p_h) > v_y[i])){
      HP--;
      vClear(i);
    }
  }
}

void scoreDisp(){
  textSize(50);
  fill(255,0,0);
  text("count:"+count,600,40);
  text("count2:"+count2,300,40);
  text("HP:"+HP,0,40);
}
void Shinka(){
  if(count2==1){
    if(count==3){
      count2=count;  
    }
  }else if(count2 == 4){
    if(count==10){
      count2=count;
    }
  }else if(count2 == 11){
    if(count==30){
    count2=count;
    }
  }else if(count2 == 31){
    if(count==40){
      count2=count;
    }
  }else if(count2 == 41){
    if(count>49){
      ClearEf();
    }
  }
  //sita sinka
  if(count2 == 0){
  img=img1;
  back=back1;
  count2 =1;
  }else if(count2 == 3 ){
  i_speed+=0.5;
  img=img2;
  back=back2;
  count2 =4;
  G+= 2;
  von=1;
  vP=9.8;
  vv=10.0;
  }else if(count2 == 10){
  i_speed+=1.0;
  img=img3;
  back=back3;
  count2 = 11;
  G+=10;
  vP=9.65;
  vv=12.0;
  }else if(count2 == 30){
  i_speed+=1.5;
  img=img1;
  count2=31;
  G=10;
  i_w=250;
  i_h=250;
  v_diameter +=4.0;
  vP=9.5;
  vv=14.0;
  }else if(count2 == 40){
  von=2;
  count2 = 41;
  }
}
void pDisp(){
  p_x = mouseX -25;
  p_y = mouseY -p_h/2 -5;
  image(pkey,p_x,p_y,p_w,p_h);
}
void vDisp(){
  for(int i=0;i<10;i++){
    if(v_ex[i]==1){
      strokeWeight(0);
      fill(255);
      ellipse(v_x[i], v_y[i], v_diameter,v_diameter);
      if(v_y[i]+v_diameter < 0){
        vClear(i);
      }
    }
  }
  if(von==1){
    Kougeki();
  }else if(von==2){
    spKougeki();
  }
}
void Kougeki(){
  for(int i=0;i<10;i++){
    if(v_ex[i]==1){
      v_y[i] -= vv;
    }
    if(v_ex[i]==0){
      if(random(-10,10)>vP){
        v_ex[i]=1;
        v_x[i]=i_x+i_w/2;
        v_y[i]=i_y+i_h/2;
      }
    }
  }
}

void spKougeki(){
  Kougeki();
  for(int i=0;i<10;i++){
    if(sv_ex[i]==1){
      image(img,sv_x[i], sv_y[i], sv_diameter,sv_diameter);
      if(sv_y[i]+sv_diameter < 0){
        svClear(i);
      }
    }
    if(sv_ex[i]==0){
      if(random(-10,10)>vP){
        sv_ex[i]=1;
        sv_x[i]=i_x+i_w*random(-1,1);
        sv_y[i]=i_y+i_h/2;
      }
    }
    sv_y[i] -= 15.0;
  }
}
void ClearEf(){
  if(von!=0){
    von = 0;
    for(int i=0;i<10;i++){
    vClear(i);
    }
  }
  if(i_h < height/2){
  i_x = width/2-i_w/2;
  i_y = height/2-i_h/2;
  i_h +=2.0;
  i_w +=2.0;
  }
    if(i_w>width/2 - 30){
    gseq = 3;
  }
}
