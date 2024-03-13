import java.util.Scanner;
import java.io.*;
import java.util.HashMap;

ScreenScrolling myScrollbar;
int contentHeight = 1000;
int viewHeight = 400;
int scrollbarHeight = 0;
ArrayList <DataPoint> dataPoints;
BufferedReader reader;
String line;
HashMap<String, String> hashMap;
PFont font;

void setup() {
  size(600,800);
  read_in_the_file();
  font = loadFont("BodoniMTCondensed-Bold-48.vlw");
  textFont(font);
  
  myScrollbar = new ScreenScrolling(20,100);
  scrollbarHeight = height * height / contentHeight;
}
 
void draw() {
    background(0);
    translate(0, -myScrollbar.scrollPos);
    for (int i = 0; i < contentHeight / 10; i++) {
    stroke(0);
    text("word",48,240); //remember to remove 
    line(0, i * 10, width, i * 10);
  }
  translate(0, myScrollbar.scrollPos);
  
  myScrollbar.display();
  myScrollbar.update();

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



void mousePressed() {
  myScrollbar.mousePressed(); // Delegate mousePressed event to the scrollbar.
}

void mouseReleased() {
  myScrollbar.mouseReleased(); // Delegate mouseReleased event to the scrollbar.
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
  while(line!="null")
  {
    try {
      line = reader.readLine();
    } 
    catch (IOException e) 
    {
      e.printStackTrace();
      line = null;
    }
    if(line==null) break;
    String[] parts = split(line, ',');
    hashMap.put(parts[1],parts[0]);
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
     if(isDouble(parts[17]))  
     cancelled=(Double.parseDouble(parts[17])==1)?true:false;
    boolean diverted= true;
    if(isDouble(parts[18]))
    diverted= (Double.parseDouble(parts[18])==1)?true:false;
//    if (isDouble(parts[19]))
      distance=(int)Double.parseDouble(parts[19]);

    DataPoint point = new DataPoint(year, month, day, code, flightNumber,origin,
      originCity,  originState,  originWac,  dest, destCity,  destState,
      destWac,  CRSDepTime, depTime,  CRSArrTime,  arrTime, cancelled,
      diverted,  distance); 
    dataPoints.add(point);
    }
  for(int index=0;index<dataPoints.size();index++)
  {
    dataPoints.get(index).printData();
  }
}
