//Andy Yu
PlaneAnimate airChina;
int totalFrames = 120;
int frameCount = 0;
class PlaneAnimate 
{
  int x; int y; int arrX; int arrY; 
  PImage plane; boolean arrive;
  PlaneAnimate(int x, int y, int arrX, int arrY, PImage plane)
  {
    this.x = x; this.y = y; this.arrX = arrX; this.arrY = arrY;
    this.plane = plane; 
    plane.resize(60,60);
  }
  
  
void move()
{
  // Calculate current position based on frame count
  float progress = (float)frameCount / totalFrames;
  x = (int)lerp(pinOrigin.getX(), arrX, progress);
  y = (int)lerp(pinOrigin.getY(), arrY, progress);
  
  // Increment frame count
  frameCount++;
  
  // Reset frame count and position when the plane arrives
  if (frameCount >= totalFrames) {
    frameCount = 0;
    x = arrX;
    y = arrY;
  }
}

void arrived()
{
  if(x == arrX && y == arrY)
  {
    arrive = true;
  }
}

void draw()
{
  image(plane,x,y);
}

void fly()
{
  if(!arrive)
  {
    move();
    draw();
  }
}

}
