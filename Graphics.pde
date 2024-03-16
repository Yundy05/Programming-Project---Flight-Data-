class Histogram
{
  int x, y;
  int gphH, gphW;
  int[] frequency;
  int max;
  int numOfBins, binWidth;

  Histogram(int x, int y,int gphH,int gphW, int[] data, int numOfBins )
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    this.max = max(data);
    this.numOfBins = numOfBins;
    binWidth = this.gphW/ this.numOfBins;
    int[] frequency = data;
  }

  int getMax(int[] data)
  {
    int maximum = 0;
    for(int i = 0; i < data.length; i++)
    {
      maximum = data[i];
      for(int t = i; t < data.length; t++)
      {
        if(data[i] < data[t])
        {
          maximum = data[t];
          i = t;
          t = t +1;
        }
      }
    }
    return maximum;
  }

  void draw()
  {
    fill(0);
    rect(x,y, gphW, gphH);
    fill(100);
    for(int i=0; i<frequency.length; i++)
    {
      //int binHeight = map(frequency[i], 0, max, 0, gphH);
      int binHeight =frequency[i]/max * gphH;
      rect(x+ i*2*binWidth, y+gphH, binWidth, binHeight);
    }
  }

}
