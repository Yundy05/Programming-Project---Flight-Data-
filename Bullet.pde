class Bullet
{
    /* Insert the code for your Bullet class here.
  */
  
//You need: variables to store the position aand appearance of the bullet.
  int x ; int y; int speed ; 
  int bulletWidth;
  int bulletHeight;
  
  boolean valid;
//A constructor
  Bullet( int xpos ,int ypos, Player tPlayer)
  {
    x = xpos;
    y = ypos;
    
    if(tPlayer.upgrade==2)
    speed = 25;
    else
    speed = 5;
    
    if(tPlayer.upgrade==1)
    bulletWidth = 50;
    else
    bulletWidth = 5;
    
    bulletHeight = 10;
    
    valid = true;
  }
  
//A method to move the bullet
  void move()
  {
    y -= speed;
  }
//A method to draw the bullet
  void draw()
  { 
    if(valid)
    rect(x, y , bulletWidth , bulletHeight);
  }
//A method to check for collisions
  void collide( Alien target)
  {
    if(y<=target.y&& y>=target.y - target.h && x+bulletWidth>=target.x && x<= target.x + target.w && valid)
    {
     target.explode();
    }
  }
}
