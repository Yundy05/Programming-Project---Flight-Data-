//Andy Yu - March 19th 2024 - Created PlaneAnimate Class to be used in flight screen 
//Chuan - March 19th - Improved plane animation so that the plane flies in an eliplse route
//Chuan - 
PlaneAnimate airChina;
int totalFrames = 160;
int frameCount = 0;
class PlaneAnimate
{
  float x;
  float y;
  float arrX;
  float arrY;
  PImage plane;
  boolean arrive;
  boolean east;
  PlaneAnimate(float x, float y, float arrX, float arrY, PImage plane)
  {
    this.x = x + plane.width/2;
    this.y = y + plane.height/2;
    this.arrX = arrX;
    this.arrY = arrY;
    this.plane = plane;
    this.east = x > arrX ? false : true ;
    plane.resize(60, 60);
  }


  void move()
  {
    // Calculate current position based on frame count
    float progress = (float)frameCount / totalFrames;
    //x = (int)lerp(pinOrigin.getX(), arrX, progress);
    //y = (int)lerp(pinOrigin.getY(), arrY, progress);
    float oX = (arrX+pinOrigin.getX())/2;
    float oY = (arrY + pinOrigin.getY())/2;
    float a = arrX - pinOrigin.getX();
    float b = arrY - pinOrigin.getY();
    pushMatrix();
    translate(oX, oY);
    //  if(abs(atan(b/a))<1)

    rotate(atan(b/a));
    a  /= cos(atan(b/a));
    x = lerp(-a/2, a/2, progress);
    y = -sqrt(((a/2)*(a/2)-x*x)/10);
    //  line(-a/2 , 0 , a/2,0);
    //  y = (int)lerp(0,-(1/1.414)*a ,(-x/sqrt(2*((a/2)*(a/2) - x*x)))*progress);             //
    draw();

    //  else
    //  {
    //  rotate(atan(b/a)-PI/2);
    //  x = lerp(-a/2,a/2,progress);
    //  y = -sqrt(((a/2)*(a/2)-x*x)/10);
    //    line(0 , -a/2 , 0, a/2);
    ////  y = (int)lerp(0,-(1/1.414)*a ,(-x/sqrt(2*((a/2)*(a/2) - x*x)))*progress);             //
    //  draw();
    //  }
    translate(0, 0);
    popMatrix();
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
    if (x == arrX && y == arrY)
    {
      arrive = true;
    }
  }

  void draw()
  {

    //  if(!east)
    //  {
    //  pushMatrix(); // Save the current transformation matrix
    //  translate(x, y); // Move to the right edge of the original image
    //  rotate(atan(float(arrY-pinOrigin.getY() )/ float(arrX - pinOrigin.getX())));
    //  scale(-1, 1); // Scale the image horizontally by -1 (revert horizontally)
    //  image(plane, -plane.width/2, -plane.height/2); // Draw the reverted image
    //  popMatrix(); // Restore the previous transformation matrix
    //  }else
    //  {
    //    pushMatrix(); // Save the current transformation matrix
    //  translate(x, y); // Move to the right edge of the original image
    //  rotate(atan(float(arrY-pinOrigin.getY() )/ float(arrX - pinOrigin.getX())));
    ////  scale(-1, 1); // Scale the image horizontally by -1 (revert horizontally)
    //  image(plane, -plane.width/2, -plane.height/2); // Draw the reverted image
    //  popMatrix(); // Restore the previous transformation matrix
    //  }
    if (!east)
    {
      pushMatrix(); // Save the current transformation matrix
      translate(x, y); // Move to the right edge of the original image
      scale(-1, 1); // Scale the image horizontally by -1 (revert horizontally)
      image(plane, -plane.width/2, -plane.height/2); // Draw the reverted image
      popMatrix(); // Restore the previous transformation matrix
    } else
      image(plane, x-plane.width/2, y-plane.height/2);
  }
  void fly()
  {
    if (!arrive)
    {
      move();
      //    draw();
    }
  }
}

int loadingRadian = 0;
void loadingAnimation(float r)
{
  loadingRadian = frameCount;
  pushMatrix();
  translate(displayWidth/4 , displayHeight/3);        //Center
  float x = r;
  float y = r;
  imageMode(CENTER);
  image(icon,0,0,icon.width/2,icon.height/2);
  rotate(radians(loadingRadian));
  
  pushMatrix();
  translate(x,y);
  rotate(PI/1.5);
  image(planeImg,0,0,planeImg.width/4,planeImg.height/4);
  translate(displayWidth/4 , displayHeight/3);
  popMatrix();
  
  translate(0,0);
  popMatrix();
  frameCount+=2;
}
