/* @pjs preload="umi.jpg,kasuga.jpeg,sora.jpg"; */

import ddf.minim.*;
Minim minim;
AudioPlayer sound;
AudioPlayer exp1; 
AudioPlayer exp2;

int number = 30;
PImage imgBack;
PImage imgPlayer;
PImage imgEnemy1[] = new PImage[10];
PImage imgEnemyS;
PImage imgEnemyB;
int gseq;
int mcnt;
int HP;
int time1;
int time2;
int time3;
int time4;
int screenPx;
int scroll = 3;
int back_w=1564;
int window_w=1024;
int w_HEIGHT=768;
int px = 100;
int py;
int pw = 100;
int ph = 100;
int gh;
int G;
int pbx[]= new int [number];
int pby[]= new int [number];
float pb_diameter =10.5;
int pb_ex[] = new int [number]; //1=on,0=off
int pbi;
int count;
int e1x[]= new int [10];
int e1y[]= new int [10];
int e1_ex[] = new int [10]; //1=on,0=off
int e1HP[] = new int [10];
int E1HP;
int e1_diameter;
int e1number;
int e1_speed;
int e1AttackD;
int eBx;
int eBy;
int eB_ex; //1=on,0=off
int eBHP;
int EBHP;
int eB_diameter;
int eB_speed;
int eBAttackD;
int count_B;
int Maxcount_B;
void EnemySet(){
  e1_diameter = 50;
  e1number = 0;
  e1_speed = 7;
  E1HP = 5;
  e1AttackD = 1;
  
  eB_diameter = 200;
  eB_speed = 2;
  EBHP = 1000;
  eBAttackD = 3;
  count_B = 0;
  Maxcount_B = 3;
}

void setup(){
  size(1024,768);
  noStroke();
  imgBack = loadImage("umi.jpg");
  imgPlayer = loadImage("kasuga.jpeg");
  for(int i=0;i<10;i++)
    imgEnemy1[i] = loadImage("sora.jpg");
  imgEnemyS = loadImage("umi.jpg");
  imgEnemyB = loadImage("sora.jpg");
  minim = new Minim(this);  
  exp1 = minim.loadFile("exp1.mp3");
  exp2 = minim.loadFile("exp2.mp3");
  gameInit();
}
void draw(){
  if( gseq == 0){
    background(0);
    gameTitle1();
  }else if( gseq == 1){
    background(0);
    gameTitle2();
  }else if ( gseq == 2){
    image(imgBack,1024,0,window_w,w_HEIGHT);
    gamePlay();
  }else if ( gseq == 3){
    background(0);
    gameOver();
  }else if ( gseq == 4){
    background(0);
    gameClear();
  }
}
void gameInit(){
  gseq= 0;
  mcnt = 0;
  HP = 10;
  screenPx=1024;
  gh= 530;
  py = gh;
  G = 2;
  pbi =0;
  EnemySet();
  for(int i=0;i<number;i++){
    pbClear(i);
  }
  for(int i=0;i<10;i++){
    e1Clear(i);
  }
  eBClear();
}
void gamePlay(){
  backDisp();
  pDisp();
  pbDisp();
  eBDisp();
  e1Disp();
  ScoreDisp();
  if(HP < 1)
    gseq = 3 ;
  noLoop();
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
void gameTitle1(){
  mcnt++;
  if((mcnt%60) < 40){
    textSize(80);
    fill(255,255,0);
    text("Click to start",width/2-250,height/2-50);
  }
}
void gameTitle2(){
  mcnt++;
  if((mcnt%60) < 40){
    textSize(80);
    fill(255,255,0);
    text("HEllO",width/2-250,height/2-50);
  }
}
void gameClear(){
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
    time1=millis();
  }
  if( gseq == 1){
    if(1000<millis()-time1)
    gseq = 2;
  }
  if( gseq == 3 ){
    gameInit();
  }
  if( gseq == 4 ){
    gameInit();
  }
}
void backDisp(){
  screenPx += scroll;
  
  if(screenPx > window_w){
    if(screenPx > back_w+window_w){
      screenPx = window_w;
    }
    else{
      copy(imgBack,screenPx,0,back_w-screenPx,w_HEIGHT,0,0,back_w-screenPx,w_HEIGHT);
      copy(imgBack,0,0,window_w-(back_w-window_w-screenPx),w_HEIGHT,back_w-screenPx,0,window_w-(back_w-window_w-screenPx),w_HEIGHT);
    }
  }
  else{
    copy(imgBack,screenPx,0,window_w,w_HEIGHT,0,0,window_w,w_HEIGHT);
  }
  image(imgBack,screenPx,0,window_w,w_HEIGHT);
}

void pDisp(){
  if(keyPressed && (key == CODED)) {
      if(keyCode == LEFT) {
        px=px-3;
        count++;
      }
      else if(keyCode == RIGHT) {
        px=px+3;
        count++;
      }
    }
  if(py == gh-ph){
    if(keyPressed && (key == 'z') && !(((keyCode == RIGHT)) ||(keyCode == LEFT))){
      py=py-200;
    }
  }
  
  gravity();
  px = constrain(px, -2*pw, width-pw);
  py = constrain(py, 0, gh-ph );
  image(imgPlayer,px,py,pw,ph);
  pAtta();
  pbMove();
}
void gravity(){
  if(py != gh-ph)
    py = py + G;
}
void pAtta(){
  if(keyPressed && (key == 'x') && !(keyPressed && ((keyCode == RIGHT)) ||(keyCode == LEFT))){
    if(pb_ex[pbi]==0){
    pbx[pbi]=px+pw/2;
    pby[pbi]=py+ph/2;
    pb_ex[pbi] =1;
    pbi++;
    count++;
      if(pbi>number-1){
        pbi=0;
      }
    }
  }
}
void pbDisp(){
  for(int i=0;i<number;i++){
    if(pb_ex[i]==1){
      strokeWeight(0);
      fill(255);
      ellipse(pbx[i], pby[i], pb_diameter,pb_diameter);
      if(pbx[i]+pb_diameter > window_w || pbx[i]+pb_diameter < -2*pw){
        pbClear(i);
      }
    }
  }
}
void pbClear(int no){
    pb_ex[no]=0;
    pbx[no]=0;
    pby[no]=0;
}
void pbMove(){
  for(int i=0;i<number;i++){
    if(pb_ex[i]==1){
        pbx[i] = pbx[i] + 5;
    }
  }
}
void e1Disp(){
  if(0.75<random(-1,1))
    count++;
  if(count>300){
    e1_ex[e1number]=1;
    e1number++;
    count=0;
    e1x[e1number] = window_w;
    e1y[e1number] = gh - int(random(10,500)) ;
    if(e1number == 9)
      e1number = 0;
  }
    for(int i=0;i<10;i++){
    if(e1_ex[i]==1){
      e1HitCheck(i);
      e1_pbHitCheck(i);
      e1Move(i);
      if(e1HP[i] < E1HP+1){
        image(imgEnemy1[i],e1x[i], e1y[i], e1_diameter,e1_diameter);
      }else
        image(imgEnemyS,e1x[i], e1y[i], e1_diameter,e1_diameter);
    }
  }
}
void e1Clear(int no){
    e1_ex[no]= 0;
    e1x[no]=window_w ;
    e1y[no]=0;
    if(int(random(0,6))==5){
      e1HP[no]=10000;
    }else{
      e1HP[no]=E1HP;
    }
}
void e1Move(int no){
      e1x[no]-=e1_speed;
      if(e1y[no]!=gh-e1_diameter)
        e1y[no]+=G*3;
      e1y[no] = constrain(e1y[no], 0, gh-e1_diameter );
      if(e1x[no] > window_w || e1x[no]+e1_diameter < -2*pw){
            e1Clear(no);
          }
      if(e1HP[no]<0){
        e1Clear(no);
        if(sound != exp1)
          sound = exp1;
        sound.rewind();
        sound.play();
        if(eB_ex == 0)
          count_B++;
      }
}
void e1HitCheck(int no){
  if((px< (e1x[no]+e1_diameter)) &&((px+pw) >e1x[no])
    &&(py <(e1y[no]+e1_diameter)) && ((py+ph) > e1y[no])){
      e1Clear(no);
      HP-=e1AttackD;
    }
}
void e1_pbHitCheck(int no){
  for(int i=0;i<number;i++){
    if((pbx[i]< (e1x[no]+e1_diameter)) &&((pbx[i]+pb_diameter) >e1x[no])
      &&(pby[i] <(e1y[no]+e1_diameter)) && ((pby[i]+pb_diameter) > e1y[no])){
        e1HP[no]-=1;
        pbClear(i);
    }
  }
}
void ScoreDisp(){
  textSize(50);
  fill(255,0,0);
  text("count:"+count,600,40);
  text("HP:"+HP,0,40);
}
void eBDisp(){
  if(Maxcount_B == count_B){
    eB_ex= 1;
    eBx = window_w+eB_diameter;
    eBy = gh - int(random(10,500)) ;
    count_B=0;
  }
    if(eB_ex==1){
        eBHitCheck();
        pb_eBHitCheck();
        eBMove();
        image(imgEnemyB,eBx, eBy, eB_diameter,eB_diameter);
    }
}
void eBClear(){
    eB_ex = 0;
    eBx=window_w ;
    eBy=0;
    eBHP=EBHP;
}
void eBMove(){
      if(eBHP%100 == 78){
        eBy-= eB_diameter*int(random(0,3));
        eBy = constrain(eBy, 0, gh-eB_diameter);
        eBx+=eB_diameter*int(random(-3,3));
        eBx = constrain(eBx, eB_diameter, window_w);
        eBHP--;
      }
      if(eBx > 2*eB_diameter){
        eBx-=eB_speed;
      }else if(eBx < 2*eB_diameter){
        eBx+=eB_speed;
      }
      eBx = constrain(eBx, eB_diameter, window_w);
      
      if(eBy!=gh-eB_diameter)
        eBy+=G;
        
      eBy = constrain(eBy, 0, gh-eB_diameter);
      if(eBx> window_w+eB_diameter || eBx+eB_diameter < -2*pw){
            eBClear();
          }
      if(eBHP<0){
        eBClear();
        sound = exp2;
        sound.rewind();
        sound.play();
      }
}
void eBHitCheck(){
  if((px< (eBx+eB_diameter)) &&((px+pw) >eBx)
    &&(py <(eBy+eB_diameter)) && ((py+ph) > eBy)){
      HP-=eBAttackD;
      px = 0;
      py = 0;
    }
}
void pb_eBHitCheck(){
  for(int i=0;i<number;i++){
  if(eB_ex == 1){
      if((pbx[i]< (eBx+eB_diameter)) &&((pbx[i]+pb_diameter) >eBx)
        &&(pby[i] <(eBy+eB_diameter)) && ((pby[i]+pb_diameter) > eBy)){
          eBHP -= 1;
          pbClear(i);
        }
    }
  }
}
void stop(){
  sound.close();
  minim.stop();
  super.stop();
}
