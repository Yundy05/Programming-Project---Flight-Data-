import java.util.Arrays;
import ddf.minim.*;

Minim minim;
AudioSample sound;
AudioSample background;
AudioSample gameOver;
AudioSample levelClear;
boolean switching;

final int A_FORWARD = 0;
final int A_BACKWARD = 1;
final int A_DOWN = 2;
final int SCREENX = 480;
final int SCREENY = 720;
final int MARGIN = 100; //<>//
final int INTERVAL = 1000;


boolean fired ;
boolean gameover;
boolean win;
int count;
int powerUpCount;
int shootTime;
int powerUpTime;
PImage alienImage;
PImage explodedImage;
PImage eliteImage;
PImage laserGunImage;
PImage bombImage;
PImage bombExploded;
PFont font;
Alien aliens[];
Elites elites[];
ArrayList<Bullet> bullets;
PowerUp powerUps[];
Shield shields[][];

Player thePlayer;
/* Declare an Alien */

void setup(){
  minim = new Minim(this);
  
  // Load the sound file (you need to replace "your_sound_file.wav" with the path to your sound file)
  sound = minim.loadSample("blaster.mp3", 512);
  background = minim.loadSample("Earth.mp3",256);
  gameOver = minim.loadSample("gameover.mp3",512);
  levelClear = minim.loadSample("LevelClear.mp3",512);
  
  alienImage = loadImage("invader(1).GIF");
  eliteImage = loadImage("Space+Invader+logo.jpg");
  explodedImage = loadImage("exploding.GIF");
  laserGunImage = loadImage("player.jpg");
  bombImage = loadImage("bomb.jpg");
  bombExploded = loadImage("bomb_explode.jpg");
  fired = false;
  count = 0;
  powerUpCount = 0;
  thePlayer = new Player(SCREENX/2,SCREENY-MARGIN,laserGunImage);
  aliens = new Alien[10];
  elites = new Elites[5];
  bullets = new ArrayList();
  powerUps = new PowerUp[1];
  shields = new Shield[5][2];
  ini_Aliens(aliens);
  ini_Elites(elites);
  ini_Shields(shields);
   size(480,720);
   background(255);
   
   shootTime = millis();
   powerUpTime = millis();
   
   font = loadFont("Algerian-48.vlw");
   gameover = false;
//  font = createFont("ArtifaktElement-HeavyItalic.vlw",48);
  textFont(font);
  switching = false;
}
 /* create a new alien object */ 
void ini_Aliens(Alien aliens[])
{
  for(int i = 0; i< aliens.length ; i++)
  {
    aliens[i] = new Alien(30+(i%5)*80, 50+int(i/5)*50,alienImage,explodedImage);
  }
}
void ini_Elites(Elites elites[])
{
  for(int i =0 ; i< elites.length ; i++)
  {
    elites[i] =  new Elites(int(random(1,SCREENX-50)),50,eliteImage,explodedImage);
  }
}

void ini_Shields(Shield shields[][])
{
  for(int i =0 ; i< shields.length ; i++)
  {
    for(int j=0 ;j<shields[i].length;j++)
    {
      shields[i][j] = new Shield(i*50,500+j*50);
    }
  }
}

void drawShields(Shield shields[][])
{
  for(int i =0 ; i< shields.length ; i++)
  {
    for(int j=0 ;j<shields[i].length;j++)
    {
      shields[i][j].draw();
    }
  }
}



void moveMultiple(Alien aliens[], Shield shields[][])
{
  for(int i=0;i<aliens.length;i++)
  {
    aliens[i].move();
    Bomb theBomb = aliens[i].getBomb();
   if(theBomb!=null)
   {
          theBomb.collide(thePlayer);            //also hurt shields
          for(int j=0; j<shields.length;j++)
            {
              for(int k=0; k<shields[j].length;k++)
              {
                shields[j][k].protect(theBomb);
              }
            }
          if(theBomb.collided)
        {
          gameover = true;
        }
   }
  }
}
void check(Alien aliens[], Alien elites[])
{  
  win = true;
  for(int i=0;i<aliens.length;i++)
  { 
    if(!aliens[i].triggerExplosion)
        win = false;
  }
  for(int i=0;i<elites.length;i++)
  {
    if(!elites[i].triggerExplosion)
        win = false;
  }
}

void drawMultiple(Alien aliens[])
{
  for(int i=0;i<aliens.length;i++)
  {
    aliens[i].draw();
    //aliens[i].explode();
  }
}
void drawBullets(ArrayList bullets)
{
  for(int i =0; i<bullets.size();i++)
  {
    Bullet theBullet = (Bullet)bullets.get(i);
     theBullet.draw();  
  }
}
void moveBullets(ArrayList bullets, Shield shields[][])    //also hurt shields;
{
  for(int i=0; i<bullets.size();i++)
  {
      Bullet theBullet = (Bullet)bullets.get(i);
      theBullet.move();
      if(theBullet.y>SCREENY)
        bullets.remove(i);
      for(int j=0; j<shields.length;j++)
      {
        for(int k=0; k<shields[j].length;k++)
        {
          shields[j][k].block(theBullet);
        }
      }
  }
}
void collisions(ArrayList bullets)
{
   for(int j = 0; j<bullets.size();j++)
 {
   for(int i = 0; i<aliens.length;i++)
   {
     Bullet theBullet = (Bullet)bullets.get(j);
     theBullet.collide(aliens[i]);
   }
   for(int i = 0; i<elites.length;i++)
   {
     Bullet theBullet = (Bullet)bullets.get(j);
     theBullet.collide(elites[i]);
   }
 }
}
void drawPowerUps(PowerUp powerUps[])
{
   for(int i=0;i<powerUps.length-1;i++)
   powerUps[i].draw(thePlayer);
}
void movePowerUps(PowerUp powerUps[])
{
   for(int i=0;i<powerUps.length-1;i++)
   powerUps[i].move();
}
void getPowerUps(PowerUp powerUps[])
{
   for(int i=0;i<powerUps.length-1;i++)
   thePlayer.powerUp(powerUps[i]);
}



void draw(){
  background(0);
  /* clear the screen */
  if(!gameover&&!win)
{
  drawShields(shields);
  thePlayer.move();
  thePlayer.draw();
  if(thePlayer.upgrade==2)
  rect(thePlayer.x + thePlayer.w/2, 1, 2, SCREENY-thePlayer.h-MARGIN);
  
  if(fired)
  {
  drawBullets(bullets);
  moveBullets(bullets,shields);
  collisions(bullets);
  }
  if(powerUps[0]!=null)
  {
    drawPowerUps(powerUps);
    movePowerUps(powerUps);
    getPowerUps(powerUps);
    losePowerUp(thePlayer);
  }
  
  moveMultiple(aliens,shields);
//  println(aliens[0].y);
  moveMultiple(elites,shields);
  /* move the alien */
  drawMultiple(aliens);
  drawMultiple(elites);
    //fill(255,0,0);
   // textSize(32);
    //text("SPEED UP!!!" , SCREENX/2-100, SCREENY/2);
    //int textStartTime = millis();
   // if(millis()-textStartTime>2000)
    // speedUp=false;
  /* draw the alien */
   check(aliens,elites);
  }
  else if(win)
  {
    fill(250,165,0);
    text("GOT'em ALL BITCH",120,300);
  }
  else if(!win&&gameover)
  {
  fill(255,0,0);
  text("GAME OVER",120,300);
  }
  
  if(!gameover&&!win&&!switching)
  {
    background.trigger();
    switching = true;
  }
  else if(win && switching)
  {
    background.stop();
    levelClear.trigger();
    switching = false;
  }
  else if(gameover && switching)
  {
    background.stop();
    gameOver.trigger();
    switching = false;
  }
  
}

void mousePressed()
{
  if(millis()-shootTime >= INTERVAL || (thePlayer.upgrade==0 && millis()-shootTime>INTERVAL/3))
  {
        bullets.add(new Bullet(thePlayer.x + thePlayer.w/2, thePlayer.y, thePlayer));
        fired = true;
        sound.trigger();
        if(thePlayer.upgrade==0)
        {
            bullets.add(new Bullet(thePlayer.x + thePlayer.w/2 +thePlayer.w/4, thePlayer.y, thePlayer));
        }
        shootTime = millis();
  }
} 
void dropPowerUp(Alien deadAlien)
{
    powerUps[powerUpCount] = new PowerUp(deadAlien.x,deadAlien.y);
    powerUpCount++;
    PowerUp[] newArray = Arrays.copyOf(powerUps , powerUpCount+1);
    powerUps = newArray;
}
void losePowerUp(Player tPlayer)
{
    if(tPlayer.upgrade!=-1)
    {
      if(millis()-powerUpTime > 3*INTERVAL)
      {
        tPlayer.upgrade = -1;
      }
    }
}
