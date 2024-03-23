class USMap
{
  PShape origin;
  PShape dest;
  float scale;
  int x; int y; String originState; String destState;
  USMap(int x, int y, String originState, String destState)
  {
    this.x=x;
    this.y=y;
    this.originState=originState;
    this.destState=destState;
    origin = new PShape();
    dest = new PShape();
    origin = usa.getChild(originState);
    dest = usa.getChild(destState);
    scale=displayWidth/1900;
  }
  void draw()
  {
    scale(scale);
    usa.disableStyle();
    fill(#9BFFEA,50);
    stroke(#9BFFEA,80);
    strokeWeight(2);
    
   // fill(255,255,255,50);
 
    shape(usa, 0, 0);
    //scale(0.5);
    // Disable the colors found in the SVG file
    origin.disableStyle();
    // Set our own coloring
 
  
    stroke(255);
    //fill(0, 51, 102);
    fill(255,50);
    //fill(#8080ff,80);
    // Draw a single state
    shape(origin, 0, 0); // Wolverines!
    // Disable the colors found in the SVG file
    dest.disableStyle();
    // Set our own coloring
   // fill(153, 0, 0);
   // fill(#8080ff,80);
    stroke(255);
    // Draw a single state
    shape(dest, 0, 0);  // Buckeyes!
    scale(1/scale);
    stroke(0);
    strokeWeight(6);
  }
}
