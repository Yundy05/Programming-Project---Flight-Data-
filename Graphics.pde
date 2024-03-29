import grafica.*;
GPlot plot;
void GraphicsSetUp()
{
  plot = new GPlot(this);
}
class Histogram
{
    int x, y;
    int gphH, gphW;
    int[] data;
    int[] frequency;
    int max;
    int min;
    int numOfBins, binWidth;
    int gap = 10;
    int rangeMin;
    int rangeMax;
    int scaleOfX = 10;
    int scaleOfY = 5;
    String title;
    String labelX;
    String labelY;
    
    // data array is your data collection, range is your data range, like year 6~`12, 6~12 is the range
    Histogram(int x, int y, int gphH, int gphW, double[] data, int numOfBins, int rangeMin,
    int rangeMax, String title, String labelX, String labelY )
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
        setupGrafica();
        
    }
    Histogram(int x, int y, int gphH, int gphW, int[] data, int numOfBins, int rangeMin,
    int rangeMax, String title, String labelX, String labelY )
    {
        this.x = x;
        this.y = y;
        this.gphH = gphH;
        this.gphW = gphW;
        this.data=data;
       // doubleToIntArray(data);
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
        setupGrafica();
        drawHistogram();
    }   
    void setupGrafica()
    {
      plot.setXLim(rangeMin, rangeMax);
      plot.setYLim(0, max);
      plot.drawBox();
      plot.setMar(100, 90, 90, 70);
      
    }
    
    void drawHistogram()
    {
      plot.setTitleText(title);
      plot.getXAxis().setAxisLabelText(labelX);
      plot.getYAxis().setAxisLabelText(labelY);
       
      plot.defaultDraw();
        //plot.setHistType(GPlot.VERTICAL);
        //plot.setHistVisible(true);
        
        
      plot.setPos(x, y);
      plot.setDim(gphW, gphH);
        // Activate the zooming and panning
        //plot.activatePanning();
        //plot.activateZooming(1.1, CENTER, CENTER);
      fill(#32348E);
        
      for(int i=0; i<frequency.length; i++)
      {
        int binHeight = (int)map(frequency[i],0, max, 0, gphH);
        println(binHeight);
        stroke(3);
        rect(x+90 +binWidth*i, (int)(y+gphH -binHeight +90), binWidth, (int)binHeight);
      }
    }

    void doubleToIntArray(double[] data)
    {
      this.data = new int[data.length];
      for(int i=0; i< data.length; i++)
      {
        this.data[i] =  (int)data[i];
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
float roundPercentage(float n)
{
  return round(n*100)/100.0;
}
  void drawPieChart()
  { 
    rectMode(CORNER);
    noFill();
    stroke(255);
    strokeWeight(5);
    rect(x- 1.5 *radius, y - 1.5*radius, radius *5, radius * 3);
    textAlign(CENTER);
    textSize(displayWidth/60);
    fill(255);
    text(title, x- 1.5 *radius +(radius *5)/2, y - 1.2*radius);
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
      x1 = (x1 + x)/2;
      y1 = (y1 + y)/2;
      textAlign(CENTER);
      fill(255);
      text(labels[i], x1, y1);      
      text(roundPercentage((radians[i]/(2.0*PI))*100)+"%" , x1 , y1 + displayWidth/50);
      lastRadian += radians[i];
    }
  }
 }
 
 class BarChart
{
    int x, y;
    int gphH, gphW;
    int[] data;
    int[] frequency;
    int max;
    int min;
    int numOfBins, binWidth;
    int gap = 10;
    int rangeMin;
    int rangeMax;
    int scaleOfX = 10;
    int scaleOfY = 5;
    String title;
    String labelX;
    String labelY;
    String[] xCatogories;
    //plot = new GPlot(this);
    // data array is your data collection, xCatogories is your data catagories, like color red, blue is the xCatogories
    BarChart(int x, int y, int gphH, int gphW, double[] data, int numOfBins, String[] xCatogories,
    String title, String labelX, String labelY )
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
        this.xCatogories = xCatogories;
        this.title = title;
        this.labelX = labelX; // label for x axis
        this.labelY = labelY;
        setupGrafica();
        
    }
    BarChart(int x, int y, int gphH, int gphW, int[] data, int numOfBins, String[] xCatogories,
    String title, String labelX, String labelY )
    {
        this.x = x;
        this.y = y;
        this.gphH = gphH;
        this.gphW = gphW;
        //doubleToIntArray(data);
        this.max = max(this.data);
        this.min = min(this.data);
        this.numOfBins = numOfBins;
        this.binWidth = this.gphW/ this.numOfBins;
        this.frequency = this.data;
        this.xCatogories = xCatogories;
        this.title = title;
        this.labelX = labelX; // label for x axis
        this.labelY = labelY;
        setupGrafica();
        
    }
    void setupGrafica()
    {
      plot.setXLim(0, xCatogories.length *10 );
      plot.setYLim(0, max);
      //plot.drawBox();
      plot.setMar(100, 90, 90, 70);
      
    }
    void drawBarChartt()
    {
      fill(#32348E);
      for(int i=0; i<frequency.length; i++)
      {
        int binHeight = (int)map(frequency[i],0, max, 0, gphH);
        println(binHeight);
        stroke(3);
        rect(x+90 +binWidth*i, (int)(y+gphH -binHeight +90), binWidth, (int)binHeight);
      }
    }
    
    void drawBarChart()
    {
        plot.setTitleText(title);
        plot.getXAxis().setAxisLabelText(labelX);
        plot.getYAxis().setAxisLabelText(labelY);
        textAlign(CENTER);
        //text(labelX, x+0.5*gphW, y + gphH +50);

      
        plot.defaultDraw();
        //plot.setHistType(GPlot.VERTICAL);
        //plot.setHistVisible(true);
        
        
        plot.setPos(x, y);
        plot.setDim(gphW, gphH);
        // Activate the zooming and panning
        //plot.activatePanning();
        //plot.activateZooming(1.1, CENTER, CENTER);
        fill(255);
        noStroke();
        rect(x+70, (int)(y+gphH+100), gphW +90, 25);
        fill(0);
        for(int i =0 ; i<xCatogories.length ; i++)
      {
        //text("uu",x+90 +binWidth*i+i*(gphW/numOfBins), y + gphH+90);
        text(xCatogories[i],x+90 +binWidth*(i+0.5), y + gphH+120);
      }
    
    
    }

    void doubleToIntArray(double[] data)
    {
      this.data = new int[data.length];
      for(int i=0; i< data.length; i++)
      {
        this.data[i] =  (int)data[i];
      }
    }
  
}
class LineGraph
{
  GPointsArray points = new GPointsArray(0);
  int x, y;
  int gphH, gphW;
  int[] dataX; // data in Y axis
  int[] dataY; // data shown in Y axis
  int[] frequency;
  int max;
  int min;
  int numOfPoints;
  int rangeMin;
  int rangeMax;
  String title;
  String labelX;
  String labelY;
  LineGraph(int x, int y, int gphH, int gphW, double[] dataX, double[] dataY, int numOfPoints,
    String title, String labelX, String labelY )
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    this.dataX = doubleToIntArray(dataX);
    this.dataY = doubleToIntArray(dataY);
    this.max = max(this.dataY);
    this.min = min(this.dataY);
    this.max = 8;
    this.min = 9;
    this.numOfPoints = numOfPoints;
    this.frequency = this.dataY;
    this.rangeMin = min(this.dataX);
    this.rangeMax = max(this.dataX);
    this.title = title;
    this.labelX = labelX; // label for x axis
    this.labelY = labelY;
    setupGrafica();
  }

  void setupGrafica()
  {
    plot.setXLim(rangeMin, rangeMax);
    plot.setYLim(0, max);
    plot.drawBox();
    plot.setMar(100, 90, 90, 70);
    pointArray();
    plot.setPoints(points);
    
  }

  void pointArray()
  {
    points = new GPointsArray(0);
    for(int i =0 ; i< dataX.length; i++)
    {
      points.add(dataX[i], dataY[i]);
    }
  }

  void drawLineGraph()
  {
    plot.setTitleText(title);
    plot.getXAxis().setAxisLabelText(labelX);
    plot.getYAxis().setAxisLabelText(labelY);
     
    plot.defaultDraw();
      //plot.setHistType(GPlot.VERTICAL);
      //plot.setHistVisible(true);
      
      
    plot.setPos(x, y);
    plot.setDim(gphW, gphH);
      // Activate the zooming and panning
    plot.activatePanning();
    plot.activateZooming(1.1, CENTER, CENTER);
    fill(#32348E);
  
    
    }

  int[] doubleToIntArray(double[] data)
  {
    int[] a =new int[data.length];
    for(int i=0; i< data.length; i++)
    {
      a[i] =  (int)data[i];
    }
    return a;
  }

}
 
 
