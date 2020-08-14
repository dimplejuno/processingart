float pw = 100;
float ph = 20;

float x,y,vx,vy;
float bs = 20;

int score = 0;
int life = 3;

void setup(){
  size(1280, 720);
  rectMode(CENTER);
  x = width/2;
  y = 0;
  vx = random(-5, 5);
  vy = random(10);
}

void draw(){
  background(0);
  x += vx;
  y += vy;
  
  if(x<0 || x>width){ vx = -vx; }
  if(y<0){ vy = -vy * 1.2; }
  
  if(y > height){
    life--;
    
    if(life == 0) {
      textSize(64);
      textAlign(CENTER, CENTER);
      text("Game Over", width/2, height/2);
      noLoop();
    }
    
    x = width/2;
    y = 0;
    vx = random(-5, 5);
    vy = random(10);
    
    
    
  }
  
  if( mouseX-pw/2 < x && mouseX+pw/2 > x && y > height-20-ph/2-bs/2 && y<height-20-ph/2 ){
    vy = -vy;
    score++;
  }
  
  ellipse(x, y, bs, bs);
  rect(mouseX, height-20, pw, ph); 
  
  textSize(64);
  textAlign(CENTER, CENTER);
  text(score, width/2, 30);
  textSize(32);
  text("Life : " + life, 100, 30);
}
