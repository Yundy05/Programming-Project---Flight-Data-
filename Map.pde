HashMap<String, double[]> stateCoord ;
HashMap<String, double[]> stateLabelCoord ;
class USMap
{
  boolean wasPressed;//test
  PShape origin;
  PShape dest;
  float scale;
  double originX;
  double originY;
  double[] originCoord,originLabelCoord;
  double destX;
  double destY;
  double[] destCoord, destLabelCoord;
  int x;
  int y;
  String originState;
  String destState;
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
    scale=(float)displayWidth/1920.0;
    if (stateCoord!=null&&stateCoord.get(originState)!=null)
    {
      originCoord=stateCoord.get(originState);
      originLabelCoord=stateLabelCoord.get(originState);
      originX=originCoord[0];
      originY=originCoord[1];
    }
    if (stateCoord!=null&&stateCoord.get(destState)!=null)
    {
      destCoord=stateCoord.get(destState);
      destLabelCoord=stateLabelCoord.get(destState);
      destX=destCoord[0];
      destY=destCoord[1];
    }
  }
  void draw()
  {
    scale(scale);
    usa.disableStyle();
    fill(#9BFFEA, 50);
    stroke(#9BFFEA, 80);
    strokeWeight(2);
    //if(mousePressed) println(mouseX,mouseY);
    //fill(255,255,255,50);

    shape(usa, 0, 0);
    // Disable the colors found in the SVG file
    if (origin!=null)
    {
      origin.disableStyle();
      // Set our own coloring


      stroke(255);
      //fill(0, 51, 102);
      fill(255, 50);
      //fill(#8080ff,80);
      // Draw a single state
      shape(origin, 0, 0); // Wolverines!
      textSize(30);
      fill(255);
      text(originState, (float)originLabelCoord[0], (float)originLabelCoord[1]);
    }
    if (dest!=null)
    {
      // Disable the colors found in the SVG file
      dest.disableStyle();
      // Set our own coloring
      // fill(153, 0, 0);
      // fill(#8080ff,80);
      //   stroke(255);
      // Draw a single state
      fill(255, 50);
      shape(dest, 0, 0);  // Buckeyes!
      fill(255);
      text(destState, (float)destLabelCoord[0], (float)destLabelCoord[1]);
    }
    scale(1/scale);
    stroke(0);
    strokeWeight(6);
    if (mousePressed)
    {
      //println(mouseX, mouseY);
    }
  }
}
