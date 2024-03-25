
ArrayList<Button> createSelections(ArrayList<DataPoint> theFlights)
{
  float y = (displayHeight*9/10)/100.0;         //unit y
  ArrayList<Button> flights;
  flights = new ArrayList<Button>();
  for (int i =0; i<10; i++)         // change into (i<theFlight.size() ) in future
  {
    flights.add(createButtonForFlight(theFlights.get(i), i));
  }
  return flights;
}
void showFlightSelections( ArrayList<Button> theButtons, ArrayList<DataPoint> theFlights)
{
  float y = (displayHeight*9/10)/100.0;         //unit y
  for (int i = 0; i<10; i++)
  {
    Button button = (Button) theButtons.get(i);
    button.display();
    button.update();
  }
  stroke(#FF1FA6);
  for (int i =1; i<=10; i++)
  {
    line(1, i*10*y, displayWidth/2, i*10*y);
    fill(#FF1FA6);
    pushMatrix();
    translate(0, (i-1)*10*y);
    printSimplifiedData(theFlights.get(i-1));
    translate(0, 0);
    popMatrix();
  }
}
void printSimplifiedData(DataPoint p)
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  textSize(1.5*TS);
  textAlign(LEFT);
  text(convertTo24HourFormat(p.CRSDepTime)+ " --- " +convertTo24HourFormat(p.CRSArrTime), 4*x, 3*y );
  textSize(TS);
  text(eraseQuotation(p.originCity) + "--->"  + eraseQuotation(p.destCity), 4*x, 6*y);
}

Button createButtonForFlight(DataPoint p, int i)
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  Button aButton;
  aButton = new fontChangingButton(60*x, 2.5*y + 10*i*y, 30*x, 5*y, "LET'S GO!", #36DFFF, #BF2E2E, 100+i, 194, 0, 10);
  return aButton;
}

int returnEventFromListOfButton(ArrayList<Button> buttons)
{
  int event = EVENT_BUTTON_NULL ;
  for (int i = 0; i<buttons.size(); i++)
  {
    Button button = (Button) buttons.get(i);
    if (button.clicked())
      event = button.event;
  }
  return event;
}

void drawHelpingLines()
{
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  for (int i = 1; i<=100; i++)
  {
    stroke(0);
    strokeWeight(1);
    if (i%5==0)
      stroke(255, 0, 0);
    line(x*i, 0, x*i, 100*y);
    line(0, y*i, 100*x, y*i);
  }
}


void printIndividualData(DataPoint aPoint)
{
  //originBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/3   Reminder of coordinates  Do Not uncomment
  //departBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/4
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  //  float buttonH = 5*y;
  int tR = (int)displayWidth/60;           //self adjusting texts

  float y1 = 55*y;                   //first line counting from north to south
  float y2 = 74*y ;

  stroke(128);
  line(1, y2, displayWidth/2, y2);
  line(1, y1, displayWidth/2, y1);
  String theDepartDate = aPoint.day + "/" + aPoint.month + "/" + aPoint.year ;
  String theArriveDate = (aPoint.CRSArrTime < aPoint.CRSDepTime ? aPoint.day+1 : aPoint.day) + "/" + aPoint.month + "/" + aPoint.year;
  textAlign(LEFT);

  fill(128);
  textSize(tR);
  text(theDepartDate, x, y1+10*y);

  fill(0);
  textSize(tR*1.25);
  text(convertTo24HourFormat(aPoint.CRSDepTime) +"     "+aPoint.origin, x, y1+15*y);
  fill(#2F67DE);
  text(eraseQuotation(aPoint.originCity), x, y2 + 15*y);

  textAlign(RIGHT);   //the other half

  fill(128);
  textSize(tR);
  text(theArriveDate, displayWidth/2 - x, y1+10*y);

  fill(0);
  textSize(tR*1.25);
  text(convertTo24HourFormat(aPoint.CRSArrTime) +"     "+aPoint.dest, displayWidth/2 - x, y1+15*y);
  fill(#2F67DE);
  text(eraseQuotation(aPoint.destCity), displayWidth/2-x, y2 + 15*y);

  pinOrigin.change(5*x, (displayHeight/2)*(1.618 - 1));                      //// Golden Ratio
  pinOrigin.dropPin();
  pinArrival.change(displayWidth/2 - 5*x, (displayHeight/2)*(1.618 - 1));   // Golden Ratio
  pinArrival.dropPin();
  airChina = new PlaneAnimate(pinOrigin.getX(), pinOrigin.getY(), pinArrival.getX(), pinArrival.getY(), planeImg);
  fly = true;
  pinOrigin.draw();
  pinArrival.draw();
  airChina.fly();
  color status;
  if (aPoint.cancelled || aPoint.diverted)          // cancelled or dead
  {
    status = (#B20407);       // dead red
  } else if (aPoint.CRSDepTime >= aPoint.depTime && aPoint.CRSArrTime >= aPoint.arrTime)  // !late
  {
    status = (#21FF53);       //a healthy green
  } else                                   // delayed
  {
    status = (#F09941);        // an ominous organge
  }
  stroke(status);
  line(5*x, (displayHeight/2)*(1.618 - 1), displayWidth/2 - 5*x, (displayHeight/2)*(1.618 - 1));      //between the pins

  fill(status);
  if (!aPoint.cancelled && !aPoint.diverted)
  {
    textAlign(LEFT);
    text(convertTo24HourFormat(aPoint.depTime)+" "+aPoint.origin, 3*x, 50*y);
    textAlign(RIGHT);
    text(convertTo24HourFormat(aPoint.arrTime)+" "+aPoint.dest, displayWidth/2-3*x, 50*y);
    textAlign(CENTER, DOWN);
    text(aPoint.distance+" miles", displayWidth/4, (displayHeight/2)*(1.618 - 1)- 5*y);
    textAlign(CENTER, TOP);
    if (aPoint.CRSDepTime >= aPoint.depTime && aPoint.CRSArrTime >= aPoint.arrTime)
    {
      text("On Time", displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);
    } else
    {
      text("Delayed", displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);
    }
  } else if (aPoint.cancelled)
  {
    textAlign(CENTER, TOP);
    text("Cancelled", displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);
  } else
  {
    textAlign(CENTER, TOP);
    text("Diverted", displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);
  }
  stroke(0);
}
String eraseQuotation (String aString)
{
  if (aString.length() >= 2 && aString.charAt(0) == '"' && aString.charAt(aString.length() - 1) == '"') {
    return aString.substring(1, aString.length() - 1);            // Return the string without the first and last characters (quotation marks)
  } else {
    return aString;
  }
}

String convertTo24HourFormat(int time) {
  // Extract hours and minutes from the integer
  int hours = time / 100;
  int minutes = time % 100;

  // Format hours and minutes as strings with leading zeros if necessary
  String hoursStr = String.format("%02d", hours);
  String minutesStr = String.format("%02d", minutes);

  // Concatenate hours and minutes with a colon separator
  String timeStr = hoursStr + ":" + minutesStr;

  return timeStr;
}
