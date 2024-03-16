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
