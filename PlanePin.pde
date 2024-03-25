//Andy Yu
PlanePins pinOrigin, pinArrival;

void setupPins()
{
  pinOrigin = new PlanePins(-1, -1, pinImg);
  pinArrival = new PlanePins(-1, -1, pinImg);
}

class PlanePins
{
  float x;
  float y;
  PImage pin;
  boolean drop;
  PlanePins(float x, float y, PImage pin)
  {
    this.x = x ;
    this.y = y ;
    this.pin = pin;
    pin.resize(50, 50);
  }

  void dropPin()
  {
    drop = true;
  }

  void pickPin()
  {
    drop = false;
  }

  boolean isDropped()
  {
    return drop;
  }

  float getX()
  {
    return x;
  }

  float getY()
  {
    return y;
  }

  void change(float x, float y)
  {
    this.x = x;
    this.y = y;
  }

  void draw()
  {
    if (drop)
    {
      image(pin, x - pin.width/2, y - pin.width/2);
    }
  }
}
