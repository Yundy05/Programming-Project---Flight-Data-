class Histogram
{
  int x, y;
  int gphH, gphW;
  int[] frequency;
  int max;
  int numOfBins, binWidth;
  int gap;
  int range;

  Histogram(int x, int y,int gphH,int gphW, int[] data, int numOfBins, int gap , int range)
  {   
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    this.max = max(data);
    this.numOfBins = numOfBins;
    this.binWidth = this.gphW/ this.numOfBins;
    this.frequency = data;
    this.gap = gap;
    this.range = range;
  }

  void drawHistogram()
  {
    fill(0);
    line(x,y, x, y+gphH); // x axis
    line(x,y+ gphH, x + gphW, y+gphH); // y axis
    fill(100);
    for(int i=0; i<frequency.length; i++)
    {
      int binHeight = (int)map(frequency[i],0, max, 0, gphH);
      stroke(3);
      rect(x+ gap +binWidth *i, y+gphH -binHeight, binWidth, binHeight);
      textAlign(CENTER);
      textSize(20);
      text((range/numOfBins) *i +"~" + (range/numOfBins) *(i+1), x+ gap +binWidth *i +binWidth/2,y+gphH +20);
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
  PieChart(int x, int y, int radius, int[]data, String[] labels)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;
    //this.numOfSlices = numOfSlices;
    this.data = data;
    this.labels = labels;
    this.radians = radians();
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
    float lastRadian = 0;
    for(int i=0; i<data.length; i++)
    {
      colorMode(HSB, 255);
      int col = (int)map(i, 0, data.length, 0, 10);
      fill(col *25, 105, 250);
      arc(x, y, radius *2, radius *2, lastRadian,lastRadian + radians[i],PIE);
      // show rects with text
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
