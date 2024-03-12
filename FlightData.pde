import java.util.Scanner;
import java.io.*;
import java.util.HashMap;
ArrayList <DataPoint> dataPoints[];
BufferedReader reader;
String line;
HashMap<String, String> hashMap;
void setup() {
  read_in_the_file();
  
    
  
    
  
}
 
void draw() {

  
} 
boolean isInteger(String s)
{
  try 
  {
  Integer.parseInt(s);
  return true;
  } 
  catch (Exception e) 
  {
   return false;
  }
}
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
void read_in_the_file()
{
  ArrayList <DataPoint> dataPoints = new ArrayList <DataPoint> ();
  reader = createReader("flights_full.csv");    //change the file here
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
    if (isInteger(dayMonthYear[0]))
        day=Integer.parseInt(dayMonthYear[0]);
    if (isInteger(dayMonthYear[1]))
        month=Integer.parseInt(dayMonthYear[1]);
    if (isInteger(dayMonthYear[2]))     
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
    
    
    if (isInteger(parts[2]))
      flightNumber=Integer.parseInt(parts[2]);
    if (isInteger(parts[7]))
      originWac = Integer.parseInt(parts[7]);
    if (isInteger(parts[12]))
      destWac = Integer.parseInt(parts[12]);
    if (isInteger(parts[13]))
      CRSDepTime=Integer.parseInt(parts[13]);
    if (isInteger(parts[14]))
      depTime=Integer.parseInt(parts[14]);
    if (isInteger(parts[15]))
      CRSArrTime=Integer.parseInt(parts[15]);
    if (isInteger(parts[16]))
      arrTime=Integer.parseInt(parts[16]);
    boolean cancelled= true;
    if(isDouble(parts[17]))  
    cancelled=(Double.parseDouble(parts[17])==1)?true:false;
    boolean diverted= true;
    if(isDouble(parts[18]))
    diverted= (Double.parseDouble(parts[18])==1)?true:false;
    if (isDouble(parts[19]))
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
