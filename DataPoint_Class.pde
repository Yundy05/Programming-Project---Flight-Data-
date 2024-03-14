class DataPoint
{
  int year;
  int month;
  int day;
  String code;
  int flightNumber;
  String origin;
  String originCity;
  String originState;
  int originWac;
  String dest;
  String destCity;
  String destState;
  int destWac;
  int CRSDepTime;
  int depTime;
  int CRSArrTime;
  int arrTime ;
  boolean cancelled; //– Cancelled Flight indicator (1=yes).
  boolean diverted; //– Diverted Flight indicator (1=yes).
  int distance;
  
  DataPoint(int year, int month, int day, String code, int flightNumber, String origin,
    String originCity, String originState, int originWac, String dest, String destCity, String destState,
    int destWac, int CRSDepTime, int depTime, int CRSArrTime, int arrTime, boolean cancelled,
    boolean diverted, int distance)
  {
    this.year= year;
    this.month= month;
    this.day= day;
    this.code= code;
    this.flightNumber= flightNumber;
    this.origin= origin;
    this.originCity= originCity;
    this.originState= originState;
    this.originWac= originWac;
    this.dest= dest;
    this.destCity= destCity;
    this.destState= destState;
    this.destWac= destWac;
    this.CRSDepTime= CRSDepTime;
    this.depTime= depTime;
    this.CRSArrTime= CRSArrTime;
    this.arrTime= arrTime ;
    this. cancelled=cancelled; //– Cancelled Flight indicator (1=yes).
    this. diverted= diverted; //– Diverted Flight indicator (1=yes).
    this.distance= distance;
  }

  void printData()
  {
    System.out.println(year+" "+ month+" "+  day+" "+ code+" "+  flightNumber+" "+  origin+" "+ originCity+" "
      +  originState+" "+ originWac+" "+ dest+" "+  destCity+" "+  destState+" "+ destWac+" "+  CRSDepTime+" "
      +  depTime+" "+ CRSArrTime+" "+ arrTime+" "+  cancelled+" "+  diverted+" "+  distance);
  }

  String getData()
  {
    return year+" "+ month+" "+  day+" "+ code+" "+  flightNumber+" "+  origin+" "+ originCity+" "
      +  originState+" "+ originWac+" "+ dest+" "+  destCity+" "+  destState+" "+ destWac+" "+  CRSDepTime+" "
      +  depTime+" "+ CRSArrTime+" "+ arrTime+" "+  cancelled+" "+  diverted+" "+  distance;
  }
    String getShortData()
  {
    return month+ originCity+" "  +  originState+" "+  distance;
  }

}
