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
  boolean delayed;
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
    int getArrDelay()
  {
    if(cancelled)
      return 0;
    int CRSArrTimeMinutes= (CRSArrTime/100)*60+(CRSArrTime%100);
    int arrTimeMinutes= (arrTime/100)*60+(arrTime%100);
    int delay=arrTimeMinutes-CRSArrTimeMinutes;
    int depDelay=getDepDelay();
    if (delay-depDelay>12*60)
    return (delay-24*60);
    else if (delay-depDelay<-12*60)
    return (delay+24*60);
    else
    return delay;
  }
  int getDepDelay()
  {
    if(cancelled)
      return 0;
    int CRSDepTimeMinutes= (CRSDepTime/100)*60+(CRSDepTime%100);
    int depTimeMinutes= (depTime/100)*60+(depTime%100);
    int delay=depTimeMinutes-CRSDepTimeMinutes;
    if (CRSDepTimeMinutes<=30&&depTimeMinutes>=23*60+30&&depTimeMinutes-(CRSDepTimeMinutes+24*60)>=-30)
      return depTimeMinutes-(CRSDepTimeMinutes+24*60);
    else if (delay>0) delayed=true;
    else if(delay<-30)//Assume flights can't take off more than 20 minutes earlier :)
    {
      delayed=true;
      delay+=24*60;
    }
    return delay;
  }

}
