class Histogram
{
  int x, y;
  int gphH, gphW;
  int[]  data;
  int[] frequency;
  int max;
  int min;
  int numOfBins, binWidth;
  int gap = 10;
  int rangeMin;
  int rangeMax;
  int sacleOfX = 10;
  int scaleOfY = 5;
  String title;
  String labelX;
  String labelY;
  // data array is your data collection, range is your data range, like year 6~12, 6~12 is the range
  Histogram(int x, int y,int gphH,int gphW, double[] data, int numOfBins, 
          int rangeMin, int rangeMax, String title, String labelX, String labelY)
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    doubleToIntArray(data);
    this.max = max(this.data);
    this.min = min(this.data);
    this.numOfBins = numOfBins;
    this.binWidth = this.gphW/ this.numOfBins;
    this.frequency = this.data;
    this.rangeMin = rangeMin;
    this.rangeMax = rangeMax;
    this.title = title;
    this.labelX = labelX; // label for x axis
    this.labelY = labelY;
  }

  void drawHistogram()
  {
  
    fill(255);
    rect(x-0.3 *gphW, y-0.3*gphH, 1.5 *gphW ,1.5 *gphH );
    fill(0);
    line(x,y, x, y+gphH); // y axis
    line(x,y+ gphH, x + gphW, y+gphH); // x axis
    fill(#32348E);
    for(int i=0; i<frequency.length; i++)
    {
      int binHeight = (int)map(frequency[i],0, max, 0, gphH);
      stroke(3);
      rect(x+ gap +binWidth *i, (int)(y+gphH -binHeight), binWidth, (int)binHeight);
      textAlign(CENTER);
      textSize(20);
      text(((max-min)/numOfBins) *i +"~" + ((max-min)/numOfBins) *(i+1), x+ gap +binWidth *i +binWidth/2,y+gphH +20);
    }
    textAlign(CENTER);
    textSize(50);
    text(title, x-0.3 *gphW + 0.5*(1.5 *gphW ), y-0.3*gphH + 50);
    // draw x axis
    textAlign(CENTER);
    text(labelX, x+0.5*gphW, y + gphH +50);

    for(int i = 1; i<=sacleOfX ; i++)
    {
      line(x+i*(gphW/numOfBins), y + gphH, x+i*(gphW/numOfBins),y + gphH+10);
      
    }
    // draw y axis
    textAlign(CENTER);
    textSize(50);
    drawVerticalAlognedText(labelY, x- 50, y);
    //text(labelY, x+0.5*gphW, y + gphH +50);
    for(int i = scaleOfY; i>=0 ; i--)
    {
      line(x, y+i*(gphH/scaleOfY), x-10, y+i*(gphH/scaleOfY));
      textAlign(CORNER);
      textSize(20);
      text(min+(max-min)/10 *(scaleOfY-i),x -30, y+i*(gphH/scaleOfY));
    }
    textSize(32);
  }
  
  void doubleToIntArray(double[] data)
  {
    this.data = new int[data.length];
    for(int i=0; i< data.length; i++)
    {
      this.data[i] =  (int)data[i];
    }
  }

  void drawVerticalAlognedText(String text, float x, int y)
  {
    for(int i = 0; i < text.length(); i++)
    {
      char c = text.charAt(i);
      text(c, x, y + ((textAscent()+ textDescent())*i));
    }
  }

}

 class PieChart
 {
  int x, y;
  int radius;
  //int numOfSlices;
  int data[];
  float radians[];
  String labels[];
  String title;
  PieChart(int x, int y, int radius, int[]data, String[] labels, String title)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    //this.numOfSlices = numOfSlices;
    this.data = data;
    this.labels = labels;
    this.radians = radians();
    this. title = title;
  }

  float[] radians()
  {
    int sum =0;
    float[] radians = new float[data.length];
    for(int i = 0; i<data.length; i++)
    {
      sum += data[i];
      //print(sum);
    }
    print(sum);
    for(int i = 0; i<data.length; i++)
    {
      radians[i] = map(data[i], 0, sum, 0, 2*PI);
      print(radians[i]);
    }
     return radians;

  }

  void drawPieChart()
  { 
    rectMode(CORNER);
    noFill();
    stroke(255);
    strokeWeight(5);
    rect(x- 1.5 *radius, y - 1.5*radius, radius *5, radius * 3);
    textAlign(CENTER);
    textSize(50);
    text(title, x- 1.5 *radius +(radius *5)/2, y - 1.5*radius+30);
    float lastRadian = 0;
    for(int i=0; i<data.length; i++)
    {
      colorMode(HSB, 255);
      int col = (int)map(i, 0, data.length, 0, 10);
      noStroke();
      fill(col *25, 105, 250);
      arc(x, y, radius *2, radius *2, lastRadian,lastRadian + radians[i],PIE);
      // show rects with text
      rectMode(CORNER);
      rect(x + 2 *radius, y-radius + 30 *i, 20, 20);
      textAlign(LEFT);
      textSize(32);
      text(labels[i], x + 2 *radius +30, y-radius +16 + 30*i);
      float halfAngle = radians[i]/2;
      float x1 = x + radius * cos(lastRadian + halfAngle);
      float y1 = y + radius * sin(lastRadian + halfAngle);
      textAlign(CENTER);
      fill(255);
      text(labels[i], x1, y1);
      
      lastRadian += radians[i];
    }
  }
 }
