import java.util.Scanner;
ArrayList <DataPoint> dataPoints[];

void setup()
{
  ArrayList <DataPoint> dataPoints = new ArrayList <DataPoint> ();
  String[] data = loadStrings("flights2k(1).csv");
  for (int i=1;i<data.length;i++)
  {
    String[] parts = data[i].split(",");
    Scanner input=new Scanner(parts[0]);
    int day=0;
    int month=0;
    int year=0;
    input.useDelimiter("(\\p{javaWhitespace}|\\/)+");
    if(input.hasNextInt())
      day=input.nextInt();
    else
      input.next();
    if(input.hasNextInt())
      month=input.nextInt();
    else
      input.next();
    if(input.hasNextInt())
      year=input.nextInt();
    else
      input.next();
    String code=parts[1];
    int flightNumber=0;
    input=new Scanner(parts[2]);
    if (input.hasNextInt())
      flightNumber=input.nextInt();
    String origin=parts[3];
    String originCity=parts[4]+","+parts[5];
    String originState=parts[6];
    input=new Scanner(parts[7]);
    int originWac=0;
    if (input.hasNextInt())
       originWac=input.nextInt();
    String dest=parts[8];
    String destCity=parts[9]+","+parts[10];
    String destState=parts[11];
    input=new Scanner(parts[12]);
    int destWac=0;
    if (input.hasNextInt())
      destWac=input.nextInt();
    input=new Scanner(parts[13]);
    int CRSDepTime=0;
    if (input.hasNextInt())
      CRSDepTime=input.nextInt();
    input=new Scanner(parts[14]);
    int depTime=0;
    if (input.hasNextInt())
      depTime=input.nextInt();
    input=new Scanner(parts[15]);
    int CRSArrTime=0;
    if (input.hasNextInt())
      CRSArrTime=input.nextInt();
    input=new Scanner(parts[16]);
    int arrTime=0 ;
    if (input.hasNextInt())
      arrTime=input.nextInt();
    boolean cancelled= (parts[17]=="1")?true:false;
    boolean diverted= (parts[18]=="1")?true:false;
    input=new Scanner(parts[19]);
    int distance=0 ;
    if (input.hasNextInt())
      distance = input.nextInt();
    DataPoint point = new DataPoint(year, month, day, code, flightNumber,origin,
      originCity,  originState,  originWac,  dest, destCity,  destState,
      destWac,  CRSDepTime, depTime,  CRSArrTime,  arrTime, cancelled,
      diverted,  distance);
    dataPoints.add(point);
  } 
}
void draw()
{
}
