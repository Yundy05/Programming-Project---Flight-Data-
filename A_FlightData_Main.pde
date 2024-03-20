import java.util.Scanner; //<>//
import java.io.*;
import java.util.HashMap;
import java.util.Map;
//screen and UI settings::
final int MARGIN = 10;
final int OUTLINE_WIDTH = 7;
final int EVENT_BUTTON_NULL = -1;
final int EVENT_BUTTON_HOME = 0;
final int EVENT_BUTTON_FLIGHT = 1;
final int EVENT_BUTTON_TOGRAPH = 2;
final int EVENT_BUTTON_INDIVIDUAL_FLIGHT = 3;
final int EVENT_BUTTON_ORIGIN = 4;
final int EVENT_BUTTON_DESTINATION = 5;
final int EVENT_BUTTON_DEPARTURE = 6;
final int EVENT_BUTTON_ARRIVAL = 7;

final int EVENT_BUTTON_SHOWPIECHART = 11;
final int EVENT_BUTTON_SHOWHISTOGRAM = 12;
final int EVENT_GETFLIGHT = 13;

final int SCREEN_HOME = 0;  //Screen sequences
final int SCREEN_FLIGHT = 1;
final int SCREEN_GRAPH = 2;
final int SCREEN_INDIVIDUAL_FLIGHT = 3;

float adapter;
int currentScreen = 3;

boolean fly;
boolean prepare;
PImage pinImg, planeImg;

//screnn and UI ends//

//events related settings//
int currentEvent;
final int EVENT_PRINT_DATA_FLIGHTSCREEN = 1;   // keep listing according to SCREEN order
int flightNum = -1;       // the index for showing a flight in Individual flight screen
//events ends//
ShowingData showingData;
int count;

ArrayList <DataPoint> dataPoints;
ArrayList <DataPoint> nonCancelledFlights;
ArrayList <DataPoint> nonDivertedFlights;
BufferedReader reader;
String line;
//HashMap<String, String> hashMap;
HashTable tableOfDates = new HashTable();
HashMap <Integer, Integer> arrDelayFreq;
PieChart pieChartOfDates; Histogram histogramOfDates;
//HashTable tableOfDates;
//int listSize = dataPoints[0].size();
int graphOption = -1;
int lineHeight = 20;

void settings() //REPLACED SCREENX WITH (displayWidth/2) & SCREENY WITH (displayHeight - 100)
{
    size(displayWidth/2,displayHeight*9/10, P2D);
}
void setup() 
{
  pinImg = loadImage("pin.png");
  planeImg = loadImage("plane.png");
  setupPins();
  setupScreen();
  setupBtn();
  
  showingData = new ShowingData(20, 20, displayWidth/2, displayHeight - 100);  
  
//  scrollbarHeight = height * height / contentHeight;
  arrDelayFreq = new HashMap <Integer, Integer>();

//data setup::
  dataPoints = new ArrayList<DataPoint>(); // 初始化全局的dataPoints列表
  read_in_the_file();
  createHashMaps();
  GraphicsSetUp();
  createCharts();
//data setup ends//

//  setupDropDown();
  
}


void draw() {
  background(#DB6868);
//  currentEvent = getCurrentEvent();
 
switch(currentScreen)
{
    case SCREEN_HOME :
 {
   homeScreen.draw();
//   drawDropdown();
   currentEvent = homeScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_FLIGHT)
   currentScreen = SCREEN_FLIGHT;
   else if(currentEvent == EVENT_BUTTON_TOGRAPH)
   currentScreen = SCREEN_GRAPH;
   else if(currentEvent == EVENT_BUTTON_INDIVIDUAL_FLIGHT)
   currentScreen = SCREEN_INDIVIDUAL_FLIGHT;
   
   if(prepare) //Andy Yu
  {
    pinOrigin.draw();
  }
  if(fly)
  {
    pinOrigin.draw();
    pinArrival.draw();
    airChina.fly();
  }
  
  
 }   break;
 
 case SCREEN_FLIGHT :
 {
   flightScreen.draw();
   currentEvent = flightScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_HOME)
   currentScreen = SCREEN_HOME;
 
 //  printFlightData();  
  printSortedFlightData();
 } break;
 
 case SCREEN_GRAPH :
   graphScreen.draw();
   currentEvent = graphScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_HOME)
   currentScreen = SCREEN_HOME;
   else if(currentEvent == EVENT_BUTTON_SHOWPIECHART)
   {
    graphOption = 1 ;
   }
   else if(currentEvent == EVENT_BUTTON_SHOWHISTOGRAM)
     graphOption = 2;
     
  if(graphOption == 1)
     pieChartOfDates.drawPieChart();
     else if(graphOption == 2)
     histogramOfDates.drawHistogram();
   break;
   
 case SCREEN_INDIVIDUAL_FLIGHT:
    fill(255);
    rect(0,displayHeight/2,displayWidth/2,displayHeight/2);
   individualFlightScreen.draw();
   currentEvent = individualFlightScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_HOME)
   currentScreen = SCREEN_HOME;
   if(currentEvent == EVENT_GETFLIGHT)
   {
     flightNum = (int)random(0,1000);
     currentEvent = EVENT_BUTTON_NULL;
   }
   if(flightNum!=-1)
   printIndividualData(dataPoints.get(flightNum));

   break;
   default:
   break;

}
}


//int getCurrentEvent()
//{
//  if(homeScreen.returnEvent()!=-1)
//    currentEvent = homeScreen.returnEvent();
//  else if(flightScreen.returnEvent()!=-1)
//    currentEvent = flightScreen.returnEvent();
    
    
//  return currentEvent;
//}



//void printFlightData()
//{
//showingData.display(); 
// if(count!=dataPoints.size())
// {
 //for(int i = 0; i < dataPoints.size(); i++)
 //{
 //   showingData.addFlight(dataPoints.get(i).getData());
//    count++;
//  }
//} //<>//
//}

void printSortedFlightData()
{
//    float length = (adapter);
//    float totalLength = 2000 + dataPoints.size()*20; //adapter + dataPoints.size()*20;
//    float translateY = ((myScrollbar.scrollPos+myScrollbar.barHeight)/height)*totalLength;   // translating coordinate
//    float y =20+(myScrollbar.barHeight/float(height))*totalLength;  // correct start y coordinate;
//    float firstVisibleText = max(0, translateY / lineHeight); //checks the current first visible text correct position
//    translate(0, -translateY);
    
    //jhy implimented a better working printing text that
    //only prints the values within the screen and not all from very top to the scrollbar
    
    showingData.display(); 
    if(count!=dataPoints.size())
    {
     for (int i = 0; i < tableOfDates.size; i++) 
    {
      LinkedList<DataPoint> temp = tableOfDates.getDataByIndex(i);
      for(int j= 0 ; j<temp.size();j++)
      {
         showingData.addFlight(temp.get(j).getData());
         count++;
      }
    }
    }
}
     
     
     
//    translate(0, translateY);
//    myScrollbar.display();
//    myScrollbar.update();


//void mouseWheel(MouseEvent event) {
//  scrollY += event.getCount() * lineHeight;
//  scrollY = constrain(scrollY, 0, dataPoints.size() * lineHeight - height);
//}


void mousePressed() {
  showingData.mousePressed(); // Delegate mousePressed event to the scrollbar.
  //dropdown menu:
//  mousePressedDropdown();
}
void mouseWheel(MouseEvent event){
  if (showingData != null) {
    showingData.mouseWheel(event);
//    myScrollbar.mouseWheel(event);
  }
}
void mouseReleased() {
  showingData.mouseReleased();
    //  myScrollbar.mouseReleased(); // Delegate mouseReleased event to the scrollbar.
}

void mouseClicked() //Flight For Plane AND Pins
{
  if(pinOrigin.isDropped() && pinArrival.isDropped())
    {
      pinOrigin.pickPin(); pinArrival.pickPin();
      pinOrigin = new PlanePins(-1,-1,pinImg);
      pinArrival = new PlanePins(-1,-1,pinImg);
      fly = false;
    }
  if(pinOrigin.isDropped()&&!pinArrival.isDropped())
    {
      pinArrival.change(mouseX,mouseY);
      pinArrival.dropPin();
      airChina = new PlaneAnimate(pinOrigin.getX(),pinOrigin.getY(),pinArrival.getX(),pinArrival.getY(),planeImg);
      fly = true;
    }
    if(!pinOrigin.isDropped())
    {
    pinOrigin.change(mouseX,mouseY);
    pinOrigin.dropPin();
    prepare = true;
    }
}

//boolean isInteger(String s)
//{
//  try
//  {
//  Integer.parseInt(s);
//  return true;
//  }
//  catch (Exception e)
//  {
//   return false;
//  }
//}

boolean isDouble(String s)
{
  try
  {
    Double.parseDouble(s);
    return true;
  }
  catch (Exception e)
  {
    return false;
  }
}

void createHashMaps()            //!!! Use this function to create ALL the HashMaps we need for furthur data support!!!       By Chuan:)
{

    for (int i=0; i<dataPoints.size(); i++)
  {
    DataPoint data = dataPoints.get(i);
     tableOfDates.putDates(data.day, data);
     int arrDelay = (int)(data.getArrDelay())/60;
     arrDelayFreq.put(arrDelay, arrDelayFreq.getOrDefault(arrDelay, 0) + 1);
        
  }
}
void createCharts()              //!!! Use this to create ALL the charts we need!!!               By chuan:)
{
  int[] numberOfFlightsByDay = new int[tableOfDates.size];
  ArrayList<Integer> numOfFlightsByArrDelay = new ArrayList<Integer>();
  String[] lables = new String[tableOfDates.size];
  for(int i=0 ; i<tableOfDates.size; i++)
  {
      numberOfFlightsByDay[i]=tableOfDates.getDataByIndex(i).size();
      lables[i] = "January "+(i+1);
  }
  for (Map.Entry<Integer, Integer> entry : arrDelayFreq.entrySet()) 
  {
       numOfFlightsByArrDelay.add( entry.getValue());
  }
  int[] arrDelayFreqArray = new int[numOfFlightsByArrDelay.size()];
  for (int i = 0; i < numOfFlightsByArrDelay.size(); i++) 
  {
       arrDelayFreqArray[i] = numOfFlightsByArrDelay.get(i);
  }
  //pieChartOfDates = new PieChart(displayWidth/7,displayHeight/2, displayWidth/10,numberOfFlightsByDay,lables);
 // histogramOfDates = new Histogram(displayWidth/7, displayHeight/2 , displayHeight/10 , displayWidth/8, numberOfFlightsByDay, tableOfDates.size, 10, 10);
 histogramOfDates = new Histogram(displayWidth/7, displayHeight/7 , displayHeight/2 , displayWidth/4, arrDelayFreqArray, arrDelayFreqArray.length,0,20,
  "Frequencies of arrival delay", "Arrival delay (h)", "Frequency");
 //histogramOfDates = new Histogram(displayWidth/7, displayHeight/7 , displayHeight/2 , displayWidth/4, arrDelayFreqArray, arrDelayFreqArray.length, 20, 5);// bug: seems that the text doesnot represent the actual values
}

ArrayList <DataPoint> getNonCancelledFlights (ArrayList <DataPoint> data)
{
   ArrayList<DataPoint> filteredDataPoints = data.stream().filter(DataPoint -> DataPoint.cancelled ==false).collect(Collectors.toCollection(ArrayList::new));
   return filteredDataPoints;
}

ArrayList <DataPoint> getNonDivertedFlights (ArrayList <DataPoint> data)
{
   ArrayList<DataPoint> filteredDataPoints = data.stream().filter(DataPoint ->(  DataPoint.diverted ==false)).collect(Collectors.toCollection(ArrayList::new));
   return filteredDataPoints;
}

void sortDataByArrDelay (ArrayList <DataPoint> data)
{
    Collections.sort(data, new ArrDelayComparator());
}

void sortDataByDepDelay (ArrayList <DataPoint> data)
{
    Collections.sort(data, new DepDelayComparator());
}  


void read_in_the_file()
{
  dataPoints = new ArrayList <DataPoint> ();
  reader = createReader("flights10k.csv");    //change the file here
 // hashMap = new HashMap<>();
  try {
    line = reader.readLine();
  }
  catch (IOException e)
  {
    e.printStackTrace();
    line = null;
  }
  // if (line == null) {
  // Stop reading because of an error or file is empty
  //   noLoop();
  // }
  while (line!="null")
  {
    try {
      line = reader.readLine();
    }
    catch (IOException e)
    {
      e.printStackTrace();
      line = null;
    }
    if (line==null) break;
    String[] parts = split(line, ',');
//    hashMap.put(parts[1], parts[0]);
    String date = parts[0];
    int day=-1;
    int month=-1;
    int year=-1;
    String[] dayMonthYearTime= split(date, ' ');
    String[] dayMonthYear= split(dayMonthYearTime[0], '/');
    //    if (isInteger(dayMonthYear[0]))
    month=Integer.parseInt(dayMonthYear[0]);
    //    if (isInteger(dayMonthYear[1]))
    day=Integer.parseInt(dayMonthYear[1]);
    //    if (isInteger(dayMonthYear[2]))
    year=Integer.parseInt(dayMonthYear[2]);
    int flightNumber=-1;//default and if flight doesn't exist flightNumber is -1
    int originWac=-1;
    int destWac=-1;
    int CRSDepTime=-1;
    int depTime=-1;
    int CRSArrTime=-1;
    int arrTime=-1;
    int distance=-1;
    String code=parts[1];
    //String flightNumber=parts[2];
    String origin=parts[3];
    String originCity=parts[4]+","+parts[5];
    String originState=parts[6];
    // String originWac=parts[7];
    String dest=parts[8];
    String destCity=parts[9]+","+parts[10];
    String destState=parts[11];
    //String destWac=parts[12];


    //    if (isInteger(parts[2]))
    flightNumber=Integer.parseInt(parts[2]);
    //    if (isInteger(parts[7]))
    originWac = Integer.parseInt(parts[7]);
    //    if (isInteger(parts[12]))
    destWac = Integer.parseInt(parts[12]);
    //    if (isInteger(parts[13]))
    CRSDepTime=Integer.parseInt(parts[13]);
    //    if (isInteger(parts[15]))
    CRSArrTime=Integer.parseInt(parts[15]);
    //      boolean cancelled = false;
    if (parts[14].length()!=0)
      depTime=Integer.parseInt(parts[14]);
    //      else
    //      cancelled = true;
    if (parts[16].length()!=0)
      arrTime=Integer.parseInt(parts[16]);
    //      else
    //      cancelled = true;
    boolean cancelled= true;
    if (isDouble(parts[17]))
      cancelled=(Double.parseDouble(parts[17])==1)?true:false;
    boolean diverted= true;
    if (isDouble(parts[18]))
      diverted= (Double.parseDouble(parts[18])==1)?true:false;
    //    if (isDouble(parts[19]))
    distance=(int)Double.parseDouble(parts[19]);

    DataPoint point = new DataPoint(year, month, day, code, flightNumber, origin,
      originCity, originState, originWac, dest, destCity, destState,
      destWac, CRSDepTime, depTime, CRSArrTime, arrTime, cancelled,
      diverted, distance);
    dataPoints.add(point);
  }

  //for (int index=0; index<dataPoints.size(); index++)
  //{
  //  dataPoints.get(index).printData();
  //  //dataPoints.get(index).displayData(5, 100);
  //}

}
void printDataByDepDelay(ArrayList data,boolean reversedOrder)
{
  nonCancelledFlights=getNonCancelledFlights(data);
  if(nonCancelledFlights!=null)
  {
    sortDataByDepDelay(nonCancelledFlights);
    if(!reversedOrder)
    {
      for (int index=0; index<nonCancelledFlights.size(); index++)
      {
        nonCancelledFlights.get(index).printData();
      }
    }
    else
    {
      for (int index=nonCancelledFlights.size()-1; index>=0; index--)
      {
        nonCancelledFlights.get(index).printData();
      }     
    }
  }
}

void printDataByArrDelay(ArrayList data,boolean reversedOrder)
{
  nonDivertedFlights=getNonDivertedFlights(data);
  if(nonDivertedFlights!=null)
  {
    sortDataByArrDelay(nonDivertedFlights);
    if(!reversedOrder)
    {
      for (int index=0; index<nonDivertedFlights.size(); index++)
      {
        nonDivertedFlights.get(index).printData();
      }
    }
    else
    {
      for (int index=nonDivertedFlights.size()-1; index>=0; index--)
      {
        nonDivertedFlights.get(index).printData();
      }           
    }
  }
}
