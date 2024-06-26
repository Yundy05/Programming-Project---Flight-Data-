import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import grafica.*;

/////////////////////////////////////Yaqi: create the histogram, pie chart , bar chart, line graph class (3/17/2024), and the quickLineGraph method(4/4/2024)/////////////////////////////////////////
/////////////////////////////////////Chuan: create the quickBarChart , quickPie, quickHistogram and methods to switch between; receive data from selector ;(Mar 27)//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////Hong: create the heatMap and legendBoxes(2/4/2024)/////////////////////////////////////////////////////////////////////////////////
GPlot plot;

void GraphicsSetUp()
{
  plot = new GPlot(this);
}


public float[] getRelativeFrequency(int[] aList , float interval)        //get relative frequency
{
  float[] f = new float[(int)Math.ceil(max(aList)/interval)];
  //sort(aList);

  for (int i = 0; i<f.length; i++)
  {
    for (int j=0; j<aList.length; j++)
    {
      if (aList[j]>=i*interval && aList[j]<(i+1)*interval)
      {
        f[i]++;
      }
    }
    f[i] /= (float)aList.length;
  }
  return f;
}

public int[] getFrequency(int[] aList, float interval)              //get absolute frequency
{
  int[] f = new int[(int)Math.ceil(max(aList)/interval)];
  //sort(aList);

  for (int i = 0; i<f.length; i++)
  {
    for (int j=0; j<aList.length; j++)
    {
      if (aList[j]>=i*interval && aList[j]<(i+1)*interval)
      {
        f[i]++;
      }
    }
  }
  return f;
}

public int[] getFrequency(int[] aList, float interval, int max)         //get desired frequency from limited classes.
{
  int[] f = new int[max];
  //sort(aList);

  for (int i = 0; i<f.length-1; i++)
  {
    for (int j=0; j<aList.length; j++)
    {
      if (aList[j]>=i*interval && aList[j]<(i+1)*interval)
          {
            f[i]++;
          }
    }
  }
  for(int j : aList)
  {
    if(j>=(max-1)*interval)
    f[f.length-1]++;
  }
  return f;
}

Histogram quickFrequencyHistogram(ArrayList<DataPoint> data, String variable, String datePeriod)   //what do u wish---supporting: Delay , Distance
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  Histogram tempHistogram = new Histogram();
  if (variable.equalsIgnoreCase("Delay"))
  {
    int interval = 10;
    int[] delay = new int[data.size()];
    for (int i=0; i<data.size(); i++)
    {
      delay[i] = data.get(i).getArrDelay()+data.get(i).getDepDelay();
    }
    int max = max(delay);
    while (max%interval!=0)
      max++;
    int bins = max / interval;
    tempHistogram = new RelativeHistogram(int(20*x), int(30*y), int(40*x), int(30*y), getRelativeFrequency(delay, (float)interval), bins, 0, max, "Delay_Frequency_From"+datePeriod, "Delay(min)", "Relative Frequency");
  }
  if (variable.equalsIgnoreCase("Distance"))
  {
    int[] distance = new int[data.size()];
    int max = 5000;
    int interval = 500;
    int bins = max / interval;
    for (int i=0; i<data.size(); i++)
    {
      distance[i] = data.get(i).distance;
    }
    tempHistogram = new RelativeHistogram(int(20*x), int(30*y), int(40*x), int(30*y), getRelativeFrequency(distance, (float)interval), bins, 
              0, max, "Distance_Frequency_From"+datePeriod, "Distance(miles)", "Relative Frequency");
  }
  return tempHistogram;
}

class Histogram
{
  int x, y;
  int gphH, gphW;
  int[] data;
  int[] frequency;
  float max;
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
  Histogram()         //
  {
  }  
  
  Histogram(int x, int y, int gphH, int gphW, float[] data, int numOfBins, int rangeMin,
    int rangeMax, String title, String labelX, String labelY )
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
  //  doubleToIntArray(data);
    this.max = max(this.data)*1.2;
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
  Histogram(int x, int y, int gphH, int gphW, int[] data, int numOfBins, int rangeMin,
    int rangeMax, String title, String labelX, String labelY )
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    this.data=data;
    // doubleToIntArray(data);
    this.max = max(this.data)*1.2;
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
    //    drawHistogram();
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

    for (int i=0; i<frequency.length; i++)
    {
      int binHeight = (int)map(frequency[i], 0, max, 0, gphH);
      //println(binHeight);
      stroke(3);
      rect(x+90 +binWidth*i, (int)(y+gphH -binHeight +90), binWidth, (int)binHeight);
    }
  }

  void doubleToIntArray(double[] data)
  {
    this.data = new int[data.length];
    for (int i=0; i< data.length; i++)
    {
      this.data[i] =  (int)data[i];
    }
  }
}
class RelativeHistogram extends Histogram
  {
    float[] data;
    RelativeHistogram(int x, int y, int gphH, int gphW, float[] data, int numOfBins, int rangeMin,
    int rangeMax, String title, String labelX, String labelY )
    {
      this.x = x;
      this.y = y;
      this.gphH = gphH;
      this.gphW = gphW;
      this.max = max(data)*1.2;
      this.min = 0;
      this.numOfBins = numOfBins;
      this.binWidth = this.gphW/ this.numOfBins;
      this.rangeMin = rangeMin;
      this.rangeMax = rangeMax;
      this.title = title;
      this.labelX = labelX; // label for x axis
      this.labelY = labelY;
      this.data = data;
      setupGrafica();
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

    for (int i=0; i<data.length; i++)
    {
      float binHeight = map(data[i], 0, max, 0, gphH);
      //println(binHeight);
      stroke(3);
      rect(x+90 +binWidth*i, (y+gphH -binHeight +90), binWidth, binHeight);
    }
  }
 }
PieChart quickFrequencyPie(ArrayList<DataPoint> data , String variable , String datePeriod)   //what do u wish---supporting: Delay , Distance
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  PieChart tempPie = new PieChart();
  if(variable.equalsIgnoreCase("Delay"))
  {
    int interval = 30;
    int[] delay = new int[data.size()];
    for(int i=0 ; i<data.size() ; i++)
    {
      delay[i] = data.get(i).getArrDelay()+data.get(i).getDepDelay();
//      print(delay[i]+" ");
    }
   // int max = max(delay);
   // while(max%interval!=0)
    //max++;
    //0.2991299 0.10711071 0.07850785 0.05260526 0.03770377 0.02980298 0.018801881 0.01480148 0.01220122 0.4149415
    int[] f = getFrequency(delay,(float)interval,7);
    String[] labels = new String[f.length];
    labels[0] = "D <="+interval+"min";
    for(int i=1 ; i<f.length-1 ;i++)
    {
      labels[i] = interval*i + "< D <=" + interval*(i+1)+"min";
    }
     labels[f.length-1] = interval*(f.length-1) + "< D min";
     
      tempPie = new PieChart(int(30*x) , int (50*y) , int(20*x) , f, labels, "Delay_Frequency_From " + datePeriod);
  }
   if(variable.equalsIgnoreCase("Distance"))
   {
     int[] distance = new int[data.size()];
     int interval = 500;
     for(int i=0 ; i<data.size() ; i++)
     {
       distance[i] = data.get(i).distance;
     }
     int[] f = getFrequency(distance,(float)interval,7);
     String[] labels = new String[f.length];
     if(f.length>1)
     {
     labels[0] = "D <="+interval+"miles";
      for(int i=1 ; i<f.length-1 ;i++)
    {
      labels[i] = interval*i + "< D <=" + interval*(i+1)+"miles";
    }
       labels[f.length-1] = interval*(f.length-1) + "< D miles";
     }
     else if(f.length==1)
     labels[0] = f[0]+"miles";
     tempPie = new PieChart(int(30*x) , int (50*y) , int(20*x) , f, labels, "Distance_Frequency_From " + datePeriod);
   }
   if(variable.equalsIgnoreCase("Status"))
   {
     String[] labels = {"normal", "cancel", "delay", "divert"};
     tempPie = new PieChart(int(30*x) , int (50*y) , int(20*x) , countCancelDelayDivert(data), labels, "Status_Frequency_From " + datePeriod);
   }
  return tempPie;
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
  PieChart(){}
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
    float sum =0;
    float[] radians = new float[data.length];
    for (int i = 0; i<data.length; i++)
    {
      if(data[i]==0)
      continue;
      
      sum += data[i];
      //print(sum);
    }
    //print(sum);
    for (int i = 0; i<data.length; i++)
    {
      if(data[i] == 0)
      continue;
      radians[i] = map(data[i], 0, sum, 0, 2*PI);
      //print(radians[i]);
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
    for (int i=0; i<data.length; i++)
    {
          if(radians[i]==0)
          continue;
      colorMode(HSB, 255);
      int col = (int)map(i, 0, data.length, 0, 10);
      strokeWeight(1);
      stroke(0);
      fill(col *25, 105, 250);
      arc(x, y, radius *2, radius *2, lastRadian, lastRadian + radians[i], PIE);
      // show rects with text
      rectMode(CORNER);
      rect(x + 2 *radius, y-radius + 30 *i, 20, 20);
      textAlign(LEFT);
      textSize(32);
      text(labels[i], x + 2 *radius +30, y-radius +16 + 30*i);
      text(roundPercentage((radians[i]/(2.0*PI))*100)+"%", x+1.2*radius, y-radius +16 + 30*i);
      float halfAngle = radians[i]/2;
      pushMatrix();
      translate(x,y);
      float x1 =radius * cos(lastRadian + halfAngle);
      float y1 =radius * sin(lastRadian + halfAngle);
      textAlign(CENTER,CENTER);
      fill(0);
      //text(labels[i], x1, y1);
      text(roundPercentage((radians[i]/(2.0*PI))*100)+"%", x1/1.5, y1/1.5);
      translate(0,0);
      popMatrix();
      lastRadian += radians[i];
    }
  }
}

BarChart quickBar(ArrayList<DataPoint> data , String iv ,String dv, String datePeriod)   //what do u wish---supporting: Route/Distance , Airport/Flights
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  BarChart templeBar = new BarChart();          //temple BAR GET DRUNK HAHAHAHA
  int bins = 5;
  if(dv.equalsIgnoreCase("Distance"))
  {
    ArrayList<DataPoint> temp = new ArrayList<DataPoint>();
    for(int i=0 ; i<data.size() ; i++)
    {
      temp.add(data.get(i));
    }
    String[] labels = new String[bins];
    int[] dis = new int[bins];
    for(int i=0 ; i<bins ; i++)
    {
      int max = 0;
      for(int j=0 ; j<temp.size();j++)
      {
         if(temp.get(max).distance< temp.get(j).distance)
          max = j;
      }
      dis[i] = temp.get(max).distance;
      labels[i] = temp.get(max).origin + "->"+ temp.get(max).dest;
      for(int j=0 ; j<temp.size();j++)
      {
         if(dis[i] == temp.get(j).distance)
         temp.remove(j);
      }

    }
  //    print(dis[0]);
        templeBar = new BarChart(int(20*x) , int(30*y) , int(40*x) , int(30*y) , dis , bins , labels ,"TOP_" +bins+"_Longest_Routes_From"+datePeriod , "Routes" , "Distance");
  }
 /* else if(dv.equalsIgnoreCase("Airport"))
  {
      // do nothing, use Vivian's graph, u can find that around bottom of main
  }*/
  return templeBar;
}

class BarChart
{
  int x, y;
  int gphH, gphW;
  int[] data;
  int[] dependent;
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
  BarChart(){}
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
    this.dependent = this.data;
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
    //this.max = max(data);
    this.max = (int)(max(data)*1.05);
    this.min = min(data);
    this.numOfBins = numOfBins;
    this.binWidth = this.gphW/ this.numOfBins-gap;
   
    this.dependent = data;
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
    for (int i=0; i<dependent.length; i++)
    {
      //int binHeight = (int)map(dependent[i], 0, this.max, 0, this.gphH);
      int binHeight = (int)(map(dependent[i],0, max, 0, gphH)/1.05);
     // println(binHeight);
      stroke(3);
      textAlign(CENTER);
      text(dependent[i], x+90 +binWidth*(i+0.5) + gap*i, (int)(y+gphH -binHeight +90)-10);
      rect(x+90 +binWidth*i + gap*i, (int)(y+gphH -binHeight +90), binWidth, (int)binHeight);
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
    for (int i =0; i<xCatogories.length; i++)
    {
      //text("uu",x+90 +binWidth*i+i*(gphW/numOfBins), y + gphH+90);
      textSize(TS/3);
      text(xCatogories[i], x+90 +(binWidth+gap)*(i+0.5), y + gphH+120);
    }
  }

  void doubleToIntArray(double[] data)
  {
    this.data = new int[data.length];
    for (int i=0; i< data.length; i++)
    {
      this.data[i] =  (int)data[i];
    }
  }
}
int intervalDayGraph =100;
int[] dateGraph;
int[] delayFrequencyGraph;
LineGraph quickLine(ArrayList<DataPoint> data , String indicator)
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;
  LineGraph quickLineGraph;
  if(indicator.equals("delay"))
  {
    int xpos = (int)(20*x);
    int ypos = (int)(20*y);
    int gphH =int(50*x);
    int gphW =int(50*y);
    String title = "Number Of Dealyed Flights Per Day :" + data.get(0).day +"/" +
               data.get(0).month + "/" + data.get(0).year + 
               " TO " + data.get(data.size()-1).day + "/" + 
               data.get(data.size()-1).month + "/" + 
               data.get(data.size()-1).year;
    //DataPoint maxDayDataPoint = Collections.max(data, Comparator.comparingInt(item -> item.day));
    //int maxDay = maxDayDataPoint.day;
    int maxDay= Collections.max(data, Comparator.comparingInt(item -> item.day)).day;
    int minDay= Collections.min(data, Comparator.comparingInt(item -> item.day)).day;
    if(intervalDayGraph != (maxDay-minDay+1))
    {
       intervalDayGraph = (maxDay-minDay+1);
        dateGraph = new int[maxDay - minDay+1];
        delayFrequencyGraph = new int[maxDay - minDay+1];
        for(int i=0; i< dateGraph.length-1; i++)
        {
          dateGraph[i] =i +minDay;
          delayFrequencyGraph[i] =0;
        }
        for(DataPoint obj: data)
        {
          if(obj.delayed == true)
          {
            delayFrequencyGraph[obj.day -minDay]++;
          }
          //println("delayFrequency: " +obj.day);
        }
        /*Arrays.parallelSetAll(delayFrequencyGraph, index -> {
          return (int) data.stream()
                           .filter(dp -> dp.day - minDay == index)
                           .count();
        });*/
        /*for(int i=0; i< dateGraph.length-1; i++)
        {
          println("date:" +dateGraph[i]);
          println("delayFrequencyGraph:" +delayFrequencyGraph[i]);
        }*/
        
       
    }
   //println("end");
   /* for(DataPoint obj: data)
    {
      delayFrequency[obj.day -minDay]++;
      //println("delayFrequency: " +obj.day);
    }*/
    

   
    quickLineGraph = new LineGraph(xpos, ypos, gphH, gphW,  dateGraph, delayFrequencyGraph, dateGraph.length,
          title, "date", "delay frequency" );
    return quickLineGraph;
  }
  return new LineGraph();

}
class LineGraph
{
  GPointsArray points = new GPointsArray(0);
  int x, y;
  int gphH, gphW;
  int[] dataX; // data in Y axis
  int[] dataY ; // data shown in Y axis
  int[] frequency;
  int max;
  int min;
  int numOfPoints;
  int rangeMin =0;
  int rangeMax=10;
  String title;
  String labelX;
  String labelY;
  LineGraph()
  {
    
  }
  LineGraph(int x, int y, int gphH, int gphW, int[] dataX, int[] dataY, int numOfPoints,
    String title, String labelX, String labelY )
  {
    this.x = x;
    this.y = y;
    this.gphH = gphH;
    this.gphW = gphW;
    this.dataX = dataX;
    this.dataY = dataY;
    this.max = max(this.dataY);
    this.min = min(this.dataY);
    //this.max = 8;
    //this.min = 9;
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
    for (int i =0; i< dataX.length-1; i++)
    {
      //println("Adding point: (" + dataX[i] + ", " + dataY[i] + ")");
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
    for (int i=0; i< data.length; i++)
    {
      a[i] =  (int)data[i];
    }
    return a;
  }
}
import java.util.Set;
class HeatMap extends USMap 
{
  HashMap<String,Integer> numOfFlightsPerState;
  LegendBox[] boxes = new LegendBox[5];
  int[] numbers;
  String label;
  HeatMap (int x, int y, HashMap<String, Integer> numOfFlightsPerState)
  {
    super (x, y, null, null);
    this.numOfFlightsPerState=numOfFlightsPerState;
  }
  //@ override
  void draw()
  {
    colorMode(RGB,255);
    scale(scale);
    usa.disableStyle();
    fill(#9BFFEA, 50);
    stroke(#9BFFEA, 80);
    strokeWeight(2);
    shape(usa, x, y);
    Set<String> keys = numOfFlightsPerState.keySet();
    numbers=new int[keys.size()];
    int index=0;
    for (String key : keys) {
      int number = numOfFlightsPerState.get(key);
              numbers[index]=number;
              index++;
    }
    int max=0;
    int min=0;
    if(numbers.length>0)
    {
     max = max(numbers);
     min = min(numbers);
    }
    int bin = (max-min)/5;
    for (String key : keys) {
            PShape myState = usa.getChild(key);
            if (myState!=null)
            {
              myState.disableStyle();
              double[] coord = stateCoord.get(key);
              int number = numOfFlightsPerState.get(key);
              if(mouseX/scale<coord[0]+x+50&&mouseX/scale>coord[0]+x-50&&mouseY/scale<coord[1]+y+50&&mouseY/scale>coord[1]+y-50)
              {
                stroke(255);

              }
              else 
              {
                stroke(0,0);

              }
              fill(number*255/max+100,90+50,90+50);
              shape(myState,x,y);
              
              
            }
    }
    Set<String> keys2 = stateCoord.keySet();
    for(String key : keys2) {
        fill(255);
        textSize(TS/1.5);        
        label=key;
        double[] coord = stateCoord.get(key);
        double[] labelCoord = stateLabelCoord.get(key);
        if(mouseX/scale<coord[0]+x+50&&mouseX/scale>coord[0]+x-50&&mouseY/scale<coord[1]+y+50&&mouseY/scale>coord[1]+y-50&&numOfFlightsPerState.get(key)!=null)
         {
                label=""+numOfFlightsPerState.get(key);
         }
        text(label, (int)labelCoord[0]+x,(int)labelCoord[1]+y);
       
    }
    LegendBox box0 = new LegendBox(200,800,50," no data ",color(#9BFFEA, 50));
    box0.draw();
    if(max!=0)
    {
    for (int i=0;i<boxes.length;i++)
    {
      LegendBox box = new LegendBox(i*50*2+300,800,50,""+(min+i*bin)+" ~ "+((i==boxes.length-1)?max:(min+(i+1)*bin)),color((min+i*bin)*255/max+100,90+50,90+50));
      box.draw();
    }
    }
    scale(1/scale);
  }
}
class LegendBox
{
  int x;
  int y;
  int size;
  String label;
  color colorRGB;
  LegendBox(int x, int y, int size, String label, color colorRGB)
  {
    this.colorRGB=colorRGB;
    this.x=x; this.y=y;
    this.size=size;
    this.label=label;
    
  }
  void draw()
  {
    stroke(255);
    fill(colorRGB);
    rect(x,y,size,size);
    fill(255);
    textSize(TS/2);
    text(label,x,y+size*1.5);
  }
  
  double[] arrayListToDoubleArray(ArrayList<Double> arrayList) 
  {
    double[] doubleArray = new double[arrayList.size()];
 
    for (int i = 0; i < arrayList.size(); i++) 
    {
      doubleArray[i] = arrayList.get(i); 
    }
    return doubleArray;
  }
  
   

}
