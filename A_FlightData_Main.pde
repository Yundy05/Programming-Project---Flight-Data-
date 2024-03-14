import java.util.Scanner;
import java.io.*;
import java.util.HashMap;
//screen and UI settings::
final int SCREENX =   1200;
final int SCREENY = 1400;
final int MARGIN = 10;
final int OUTLINE_WIDTH = 5;
final int EVENT_BUTTON_HOME = 0;
final int EVENT_BUTTON_FLIGHT = 1;
final int EVENT_BUTTON_NULL = -1;

final int SCREEN_HOME = 0;  //Screen sequences
final int SCREEN_FLIGHT = 1;

int currentScreen;

//screnn and UI ends//

//events related settings//
int currentEvent;
final int EVENT_PRINT_DATA_FLIGHTSCREEN = 1;   // keep listing according to SCREEN order

//events ends//
ScreenScrolling myScrollbar;
ArrayList <DataPoint> dataPoints;
BufferedReader reader;
String line;
HashMap<String, String> hashMap;
HashTable tableOfDates;
//int listSize = dataPoints[0].size();


int lineHeight = 20;

void settings()
{
    size(SCREENX,SCREENY);
}
void setup() 
{
  setupScreen();
  setupBtn();
  
  myScrollbar = new ScreenScrolling(20,100,SCREENX-25,1);
//  scrollbarHeight = height * height / contentHeight;


//data setup::
  dataPoints = new ArrayList<DataPoint>(); // 初始化全局的dataPoints列表
  read_in_the_file();
//data setup ends//

  setupDropDown();
  
  createHashMaps();
}


void draw() {
  background(#DB6868);
//  currentEvent = getCurrentEvent();
  if(currentScreen == SCREEN_HOME)
 {
   homeScreen.draw();
   drawDropdown();
   currentEvent = homeScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_FLIGHT)
   currentScreen = SCREEN_FLIGHT;
 }
 else if(currentScreen == SCREEN_FLIGHT)
 {
   flightScreen.draw();
   currentEvent = flightScreen.returnEvent();
   if(currentEvent == EVENT_BUTTON_HOME)
   currentScreen = SCREEN_HOME;
   
   printFlightData();  
    tableOfDates.printHash();
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


void printFlightData()
{
      //for (int i = 0; i < dataPoints.size(); i++) 
    //{
    //  text(dataPoints.get(i).getData(), 50, y);
    //  y += lineHeight;
    //}
   float adapter = (2000 / 5) * 4;  // used to adapt length with slider!! Try until finding an ideal value that makes perfect length!! Need a function to automatically calculate this!!
    float totalLength = adapter + dataPoints.size()*20;
    float translateY = ((myScrollbar.scrollPos+myScrollbar.barHeight)/height)*totalLength;   // translating coordinate
    float y =20+(myScrollbar.barHeight/float(height))*totalLength;  // correct start y coordinate;
    
  translate(0, -translateY);
//    for (int j = 0; j < 800 / 10; j++) 
//    {
//       line(0, j * 10, width, j * 10);
      for (int i = 0; i < dataPoints.size() && y-translateY<=height+20; i++) 
    {
      if(y>=-20)                                //need better performance: one suggestion is figure out a way to directly start the loop that matters i.e. change i as scrolling down.
      {
       textAlign(LEFT);
       textSize(20);
      text(dataPoints.get(i).getData(), 50, y);
      }
      y += lineHeight;
     }
 //   }
  translate(0, translateY);


  myScrollbar.display();
  myScrollbar.update();

}


//void mouseWheel(MouseEvent event) {
//  scrollY += event.getCount() * lineHeight;
//  scrollY = constrain(scrollY, 0, dataPoints.size() * lineHeight - height);
//}


void mousePressed() {
  myScrollbar.mousePressed(); // Delegate mousePressed event to the scrollbar.
  //dropdown menu:
  mousePressedDropdown();
}
void mouseWheel(MouseEvent event){
   myScrollbar.mouseWheel(event);
}
void mouseReleased() {
  myScrollbar.mouseReleased(); // Delegate mouseReleased event to the scrollbar.
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

void createHashMaps()
{
    for (int i=0; i<dataPoints.size(); i++)
  {
     tableOfDates = new HashTable(dataPoints.size());
    tableOfDates.putDates(dataPoints.get(i).year, dataPoints.get(i));
    
  }
}


void read_in_the_file()
{
  dataPoints = new ArrayList <DataPoint> ();
  reader = createReader("flights2k.csv");    //change the file here
  hashMap = new HashMap<>();
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
    hashMap.put(parts[1], parts[0]);
    String date = parts[0];
    int day=-1;
    int month=-1;
    int year=-1;
    String[] dayMonthYearTime= split(date, ' ');
    String[] dayMonthYear= split(dayMonthYearTime[0], '/');
    //    if (isInteger(dayMonthYear[0]))
    day=Integer.parseInt(dayMonthYear[0]);
    //    if (isInteger(dayMonthYear[1]))
    month=Integer.parseInt(dayMonthYear[1]);
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
