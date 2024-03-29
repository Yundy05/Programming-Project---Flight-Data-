import java.util.Scanner; //<>// //<>// //<>// //<>// //<>//
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

//screen and UI settings::
final int MARGIN = 10;
final int OUTLINE_WIDTH = 7;
final int EVENT_BUTTON_FORWARD = -3;
final int EVENT_BUTTON_BACK = -2; //Arrows for screen history
final int EVENT_BUTTON_NULL = -1;
final int EVENT_BUTTON_HOME = 0;
final int EVENT_BUTTON_FLIGHT = 1;
final int EVENT_BUTTON_NEXT = 21;
final int EVENT_BUTTON_PREVIOUS = 22;


final int EVENT_BUTTON_ORIGIN = 3;
final int EVENT_BUTTON_DESTINATION = 3;
final int EVENT_BUTTON_DEPARTURE = 3;
final int EVENT_BUTTON_ARRIVAL = 3;

final int EVENT_BUTTON_PIECHART = 11;
final int EVENT_BUTTON_HISTOGRAM = 12;
final int EVENT_GETFLIGHT = 13;
final int EVENT_BUTTON_DELAY = 14;
final int EVENT_BUTTON_DISTANCE = 15;
final int EVENT_BUTTON_RL = 16;
final int EVENT_BUTTON_FILTER_1 = 17;
final int EVENT_BUTTON_FILTER_2 = 18;

final int EVENT_GETHELP = 20;

final int SCREEN_HOME = 0;  //Screen sequences
final int SCREEN_FLIGHT = 1;
final int SCREEN_GRAPH = 2;
final int SCREEN_INDIVIDUAL_FLIGHT = 3;
final int SCREEN_SEARCH = 4;
final int SCREEN_SELECT = 5;
final int SCREEN_SEARCH_BAR = 6;
final int SCREEN_HISTOGRAM = 7;
final int SCREEN_PIE_CHART = 8;
final int SCREEN_BAR_CHART = 9;


float adapter;
int currentScreen ;
int TS;
PShape usa;
boolean fly;
boolean prepare;
PImage pinImg, planeImg;
USMap map;
ArrayList<Integer> screenArrow;
int screenHistory = -1;
int hasScreenAdded = -1;
//screnn and UI ends//


//events related settings//
boolean updateData;
int currentEvent;
int selectedFlight;                        // An index to access individual flight
final int EVENT_PRINT_DATA_FLIGHTSCREEN = 1;   // keep listing according to SCREEN order
int flightNum = -1;       // the index for showing a flight in Individual flight screen
boolean flightSelected;    //used in Selection page to ensure we select flights only once before next selection
boolean helping;
ArrayList temp;               //temp Arraylist to store the selected flights
//  String lists for dropdown menu
ArrayList<String> cities = new ArrayList<String>();
ArrayList<String> airports = new ArrayList<String>();
//ArrayList<DataPoint> selectedFlights = new ArrayList<DataPoint>();
//events ends//
ShowingData showingData;
DateCalander calendar;


int count;

ArrayList <DataPoint> dataPoints;
ArrayList <DataPoint> nonCancelledFlights;
ArrayList <DataPoint> nonDivertedFlights;
ArrayList <DataPoint> calendarDataPoint;
ArrayList <DataPoint> filter;                   //corruptible filter to select data
BufferedReader reader;
String line;
//HashMap<String, String> hashMap;

HashTable tableOfDates = new HashTable();
HashTable tableOfOrigin = new HashTable();
HashTable tableOfOrigin_Wac = new HashTable();
HashTable tableOfDestination = new HashTable();
HashTable tableOfDestination_Wac = new HashTable();
HashTable tableOfAirports_Origin = new HashTable();
HashTable tableOfAirports_Dest = new HashTable();
HashMap <Integer, Integer> arrDelayFreq;
HashMap <String, Integer> airportFreq;
List<Map.Entry<String, Integer>> airportFreqList;
PieChart pieChartOfDates;
Histogram histogramOfDates;
BarChart flightsByAirport;
Histogram currentHistogram = new Histogram();
boolean switchingHistogram = false;

PieChart  currentPie = new PieChart();
boolean switchingPie = false;

BarChart  currentBar = new BarChart();
boolean switchingBar = false;

String variableHistogram = "";
String variablePie = "";
String independentVariableBar = "";
String dependentVariableBar = "";
//HashTable tableOfDates;
//int listSize = dataPoints[0].size();
int lineHeight = 20;

void settings() //REPLACED SCREENX WITH (displayWidth/2) & SCREENY WITH (displayHeight - 100)
{
  size(displayWidth/2, displayHeight*9/10, P2D);
}

void setup()
{
  pinImg = loadImage("pin.png");
  planeImg = loadImage("plane.png");
  usa = loadShape("Blank_US_Map_With_Labels.svg");
  setupPins();
  setupScreen();
  setupBtn();
  TS = int(displayWidth/60.0);  //universal text size;
  arrDelayFreq = new HashMap <Integer, Integer>();
  airportFreq = new HashMap <String, Integer>();

  //data setup::
  dataPoints = new ArrayList<DataPoint>();
  init_stateCoord();
  read_in_the_file();
  calendarDataPoint=dataPoints;
  createHashMaps();
  GraphicsSetUp();
  createHashMaps(calendarDataPoint);
  createCharts();
  //data setup ends//

  showingData = new ShowingData(20, 20, displayWidth/2, displayHeight - 100);
  calendar = new DateCalander(tableOfDates.size);
  //  Scanner input = new Scanner(System.in);
  //  setupDropDown();
  for (int i=0; i<tableOfOrigin_Wac.size; i++)
  {
    if (tableOfOrigin_Wac.getDataByIndex(i).size()!=0)
    {
      for (int j=0; j<tableOfOrigin_Wac.getDataByIndex(i).size(); j++)
      {
        if (!duplicateValue(cities, eraseQuotation(tableOfOrigin_Wac.getDataByIndex(i).get(j).originCity)))
          cities.add(eraseQuotation(tableOfOrigin_Wac.getDataByIndex(i).get(j).originCity));
      }
    }
  }
  for (int i=0; i<tableOfAirports_Origin.size; i++)
  {
    if (tableOfAirports_Origin.getDataByIndex(i).size()!=0)
    {

      airports.add(eraseQuotation(tableOfAirports_Origin.getDataByIndex(i).get(0).origin));
    }
  }
  //println(cities);
  //print(airports);
  // filter test example  (originCity,destCity,startDay,endDay,only show non-cancelled flights)
 // getFilteredFlights("Chicago, IL", "", 1, 5, true);


  //Screen History Arrows - Andy
  screenArrow = new ArrayList<Integer>();
  //Searching Bar
  setupSB();
  
}


void draw() {
  background(#DB6868);
  //  currentEvent = getCurrentEvent();
  //  print(screenArrow.toString());
  //   println(screenHistory);
  switch(currentScreen)
  {
  case SCREEN_HOME :
    {
      homeScreen.draw();
      homeScreen.drawLogo();
      screenArrow.clear();
      screenArrow.add(0);
      screenHistory = 0;
      hasScreenAdded = 0;
      // drawDropdown();
      currentEvent = homeScreen.returnEvent();
      if (currentEvent == SCREEN_SELECT)
        currentScreen = SCREEN_SEARCH_BAR;
      else if (currentEvent == SCREEN_GRAPH)
        currentScreen = SCREEN_GRAPH;
    }
    break;

    /////////////////////////////////////////////////////////////////
  //case SCREEN_FLIGHT :
  //  {
  //    flightScreen.draw();

  //    if (hasScreenAdded != SCREEN_FLIGHT)
  //    {
  //      if (currentEvent !=  EVENT_BUTTON_BACK && currentEvent !=  EVENT_BUTTON_FORWARD)
  //      {
  //        screenArrow.add(SCREEN_FLIGHT);
  //        screenHistory++;
  //      }
  //      hasScreenAdded = SCREEN_FLIGHT;
  //    }

  //    currentEvent = flightScreen.returnEvent();
  //    if (currentEvent == EVENT_BUTTON_HOME)
  //      currentScreen = SCREEN_HOME;

  //    if (currentEvent == EVENT_BUTTON_BACK)
  //    {
  //      if (screenHistory > 0)
  //        screenHistory--;
  //      currentScreen = screenArrow.get(screenHistory);
  //    } else if (currentEvent == EVENT_BUTTON_FORWARD)
  //    {
  //      if (screenArrow.size()-1 > screenHistory && screenArrow.size() > 1)
  //        screenHistory++;
  //      currentScreen = screenArrow.get(screenHistory);
  //    }

  //    //  printFlightData();
  //    printSortedFlightData();
  //    //printOriginSortedFlightData();
  //  }
  //  break;

    
    
    
    
///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   
  case SCREEN_GRAPH :
    graphScreen.draw();
    if (hasScreenAdded != SCREEN_GRAPH)
    {
      if (currentEvent !=  EVENT_BUTTON_BACK && currentEvent !=  EVENT_BUTTON_FORWARD)
      {
        screenArrow.add(SCREEN_GRAPH);
        screenHistory++;
      }
      hasScreenAdded = SCREEN_GRAPH;
    }
    currentEvent = graphScreen.returnEvent();
    if (currentEvent == EVENT_BUTTON_HOME)
        currentScreen = SCREEN_HOME;
     else if (currentEvent == EVENT_BUTTON_PIECHART)
    {
      currentScreen = SCREEN_PIE_CHART;
    } else if (currentEvent == EVENT_BUTTON_HISTOGRAM)
      currentScreen = SCREEN_HISTOGRAM;
      else if( currentEvent == SCREEN_BAR_CHART)
      currentScreen = SCREEN_BAR_CHART;
    break;
///GRAPH///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH   ///GRAPH       
    
    
    
////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE//
  case SCREEN_PIE_CHART :
    pieChartScreen.draw();
    if (hasScreenAdded != SCREEN_PIE_CHART)
    {
      if (currentEvent !=  EVENT_BUTTON_BACK && currentEvent !=  EVENT_BUTTON_FORWARD)
      {
        screenArrow.add(SCREEN_PIE_CHART);
        screenHistory++;
      }
      hasScreenAdded = SCREEN_PIE_CHART;
    }
    currentEvent = pieChartScreen.returnEvent();
//    pieChartOfDates.drawPieChart();
    if (currentEvent == EVENT_BUTTON_HOME)
       currentScreen = SCREEN_HOME;
    else if(currentEvent == EVENT_BUTTON_DELAY)
    {
       variablePie = "Delay";
       switchingPie = true;
    }
    else if(currentEvent == EVENT_BUTTON_DISTANCE)
    {
       variablePie = "Distance";
       switchingPie = true;
    }       
      if(variablePie!="")
      {
        if(switchingPie)
        {
        //currentPie = quickFrequencyPie(calendarDataPoint , variablePie , calendarDataPoint.get(0).day+"/"+calendarDataPoint.get(0).month+"/"+calendarDataPoint.get(0).year+ " <---TO---> "+
    //calendarDataPoint.get(calendarDataPoint.size()-1).day+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).month+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).year); 
          currentPie=pieChartOfDates;
          switchingPie = false;
        }
        currentPie.drawPieChart();
      }
    break;
////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE////////////PIE    
    
 ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM
  case SCREEN_HISTOGRAM :
    histogramScreen.draw();
    if (hasScreenAdded != SCREEN_HISTOGRAM)
    {
      if (currentEvent !=  EVENT_BUTTON_BACK && currentEvent !=  EVENT_BUTTON_FORWARD)
      {
        screenArrow.add(SCREEN_HISTOGRAM);
        screenHistory++;
      }
      hasScreenAdded = SCREEN_HISTOGRAM;
    }
    currentEvent = histogramScreen.returnEvent();
    if (currentEvent == EVENT_BUTTON_HOME)
        currentScreen = SCREEN_HOME;
    else if(variableHistogram!="")
    {
      if(switchingHistogram)
      {
    currentHistogram = quickFrequencyHistogram(calendarDataPoint , variableHistogram , calendarDataPoint.get(0).day+"/"+calendarDataPoint.get(0).month+"/"+calendarDataPoint.get(0).year+ " <---TO---> "+
    calendarDataPoint.get(calendarDataPoint.size()-1).day+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).month+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).year); 
        switchingHistogram = false;
      }
    currentHistogram.drawHistogram();
    }
    //    histogramOfDates.drawHistogram();
       //CHANGE CODE FROM HERE TO WHATEVER YOU WANT DELAY AND DISTANCE TO DO 
    else if(currentEvent == EVENT_BUTTON_DELAY)
    {
       variableHistogram = "Delay";
       switchingHistogram = true;
    }
    else if(currentEvent == EVENT_BUTTON_DISTANCE)
    {
       variableHistogram = "Distance";
       switchingHistogram = true;
    }

    break;
 ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM ///////SCREEN_HISTOGRAM   
    
/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////
  case SCREEN_BAR_CHART:
      barChartScreen.draw();
      if (hasScreenAdded != SCREEN_BAR_CHART)
    {
      if (currentEvent !=  EVENT_BUTTON_BACK && currentEvent !=  EVENT_BUTTON_FORWARD)
      {
        screenArrow.add(SCREEN_BAR_CHART);
        screenHistory++;
      }
      hasScreenAdded = SCREEN_BAR_CHART;
    }
      currentEvent = barChartScreen.returnEvent();
      if (currentEvent == EVENT_BUTTON_HOME)
        currentScreen = SCREEN_HOME;
      else if(currentEvent == EVENT_BUTTON_RL)
      {
        independentVariableBar = "Route";
        dependentVariableBar = "Distance";
        switchingBar = true;
      }
      
      if(dependentVariableBar!="")
      {
        if(switchingBar)
        {
          currentBar = flightsByAirport;// = quickBar(calendarDataPoint, independentVariableBar , dependentVariableBar , calendarDataPoint.get(0).day+"/"+calendarDataPoint.get(0).month+"/"+calendarDataPoint.get(0).year+ " <---TO---> "+
    //calendarDataPoint.get(calendarDataPoint.size()-1).day+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).month+"/"+calendarDataPoint.get(calendarDataPoint.size()-1).year); 
            switchingBar = false;
        }
        currentBar.drawBarChart();
        currentBar.drawBarChartt();
      }
      
  break;
/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART/////BAR_CHART

  
////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT   
  case SCREEN_INDIVIDUAL_FLIGHT:
    individualFlightScreen.draw();
    if (currentEvent == EVENT_BUTTON_HOME)
        currentScreen = SCREEN_HOME;
    if (currentEvent==EVENT_GETHELP)
    {
      helping = !helping;
    }
    if (helping)
      drawHelpingLines();

    if (currentEvent == EVENT_GETFLIGHT)
    {
      flightNum = (int)random(0, calendarDataPoint.size());                     //for fun
      currentEvent = EVENT_BUTTON_NULL;
    } else if (currentEvent>=100)
      flightNum = selectedFlight;                         //selected from selection screen

    if (flightNum!=-1)
    {
      DataPoint flight = calendarDataPoint.get(flightNum);
      map = new USMap(0, 0, flight.originState, flight.destState);
      printIndividualData(flight);
    }
    currentEvent = individualFlightScreen.returnEvent();


    break;
////////SCREEN_INDIVIDUAL_FLIGHT////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT ////////SCREEN_INDIVIDUAL_FLIGHT     
    
    
    
/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH
  case SCREEN_SEARCH :
    {
      searchScreen.draw();
      calendar.displayForOrigin();
      //      calendar.displayForCalendar();
      if (currentEvent == EVENT_BUTTON_HOME)
         currentScreen = SCREEN_HOME;
      if (calendar.isSelectionComplete())
      {
        fill(0);
        textSize(TS/1.5);
        if (calendar.singleDateMode)
        {
          text("Press \"View Flights\" \nOr \"GRAPHS\" \n to view data", calendar.x * 28, calendar.y * 88);
        } else
        {
          text("Press \"View Flights\" \nOr \"GRAPHS\" \n to view data", calendar.x * 28, calendar.y * 88);
        }
        if (calendar.finalToGoSelect())
        {
          if (calendar.inputChanged == "Departure Only")
          {
            filter = findIntersection(tableOfOrigin, hashFuncForCity(OriginCity));
            selectFlightsByDateAndOthers(filter);
            currentScreen = SCREEN_SELECT;
          } else if (calendar.inputChanged == "Arrival Only")
          {
            filter = findIntersection(tableOfDestination, hashFuncForCity(DestinationCity));
            selectFlightsByDateAndOthers(filter);
            currentScreen = SCREEN_SELECT;
          } else if (calendar.inputChanged == "Departure & Arriving")
          {
            filter = findIntersection(tableOfOrigin, hashFuncForCity(OriginCity), tableOfDestination, hashFuncForCity(DestinationCity));
            selectFlightsByDateAndOthers(filter);
            currentScreen = SCREEN_SELECT;
          } else if (calendar.inputChanged == "Single Date Only")
          {
            selectFlightsByDate();
            currentScreen = SCREEN_SELECT;
          } else if (calendar.inputChanged == "Date range")
          {
            selectFlightsByDate();
            currentScreen = SCREEN_SELECT;
          }
        }
        
          if (calendar.finalToGoGraph())
          {
          if (calendar.inputChanged == "Departure Only")
          {
            filter = findIntersection(tableOfOrigin, hashFuncForCity(OriginCity));
            selectFlightsByDateAndOthers(filter);
             currentScreen = SCREEN_GRAPH;
          } else if (calendar.inputChanged == "Arrival Only")
          {
            filter = findIntersection(tableOfDestination, hashFuncForCity(DestinationCity));
            selectFlightsByDateAndOthers(filter);
             currentScreen = SCREEN_GRAPH;
          } else if (calendar.inputChanged == "Departure & Arriving")
          {
            filter = findIntersection(tableOfOrigin, hashFuncForCity(OriginCity), tableOfDestination, hashFuncForCity(DestinationCity));
            selectFlightsByDateAndOthers(filter);
             currentScreen = SCREEN_GRAPH;
          } else if (calendar.inputChanged == "Single Date Only")
          {
            selectFlightsByDate();
            currentScreen = SCREEN_GRAPH;
          } else if (calendar.inputChanged == "Date range")
          {
            selectFlightsByDate();
            currentScreen = SCREEN_GRAPH;
          }
          createHashMaps(calendarDataPoint);
          createCharts();
        }
      }
      currentEvent = searchScreen.returnEvent();
       if (currentEvent == SCREEN_GRAPH)
        currentScreen = SCREEN_GRAPH;
    }
    break;
/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH/////SCREEN_SEARCH



////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR
  case SCREEN_SEARCH_BAR :
    {
      searchBarScreen.draw();
      currentEvent = searchBarScreen.returnEvent();
      if (currentEvent == EVENT_BUTTON_HOME)
         currentScreen = SCREEN_HOME;
     else if (currentEvent == SCREEN_SEARCH)
        currentScreen = SCREEN_SEARCH;
        //CHANGE THIS FOR FILTER BUTTONS 
     else if (currentEvent == EVENT_BUTTON_FILTER_1)
        currentScreen = SCREEN_SEARCH;
     else if (currentEvent == EVENT_BUTTON_FILTER_2)
        currentScreen = SCREEN_SEARCH;      
      drawSB();
    }
    break;

////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR////////////SCREEN_SEARCH_BAR

////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT


  case SCREEN_SELECT :
    {
      if (!flightSelected)
      {
        temp = createSelections(calendarDataPoint);  //temp is a list of buttons consisting the information of the flights
        flightSelected = true;
      }
      selectScreen.draw();
      showFlightSelections(temp, calendarDataPoint);
      currentEvent = returnEventFromListOfButton(temp);
      if (currentEvent>=100)  //the flights events are allocated after 100
      {
        selectedFlight = currentEvent-100;
        currentScreen = SCREEN_INDIVIDUAL_FLIGHT;
      //  print(selectedFlight);
      }
    }
////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT////////////SCREEN_SELECT


  default:
    break;
  }
  homePageBtn.display();
  homePageBtn.update();
  
  backArrow.display();
  forwardArrow.display(); 
  backArrow.update();
  forwardArrow.update();
  
  if(homePageBtn.clicked())
  currentScreen = SCREEN_HOME;
  
  if(forwardArrow.clicked())
  currentEvent = EVENT_BUTTON_FORWARD;
  if(backArrow.clicked())
  currentEvent = EVENT_BUTTON_BACK;
  toggleScreen();
  if(switchedScreen())
  recordScreen();
}



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
//}
//}

void printSortedFlightData()
{
  //jhy implimented a better working printing text that
  //only prints the values within the screen and not all from very top to the scrollbar
  HashTable tempT = tableOfDestination_Wac;
  showingData.display();
  if (count!=dataPoints.size())
  {
    for (int i = 0; i < tempT.size; i++)
    {
      LinkedList<DataPoint> temp = tempT.getDataByIndex(i);
      for (int j= 0; j<temp.size(); j++)
      {
        showingData.addFlight(temp.get(j).getData());
        count++;
      }
    }
  }
}

ArrayList<DataPoint> getFilteredFlights (String origin, String dest, int date1, int date2, boolean nonCancelled)
{
  ArrayList<DataPoint>selectedFlights=new ArrayList<DataPoint> ();
  if (origin!=null)
    selectedFlights = tableOfOrigin.getDataByIndex(hashFuncForCity(origin)).stream().filter(DataPoint -> DataPoint.originCity.contains(origin)).collect(Collectors.toCollection(ArrayList<DataPoint>::new));
  else
    selectedFlights = dataPoints;
  if (dest!=null)
    selectedFlights = selectedFlights.stream().filter(DataPoint -> DataPoint.destCity.contains(dest)).collect(Collectors.toCollection(ArrayList<DataPoint>::new));
  if (date1!=0&&date2!=0)
  {
    selectedFlights=selectedFlights.stream().filter(DataPoint ->(  DataPoint.day<=date2&&DataPoint.day>=date1)).collect(Collectors.toCollection(ArrayList<DataPoint>::new));
  }
  if (nonCancelled)
    selectedFlights=selectedFlights.stream().filter(DataPoint ->(  DataPoint.cancelled ==false)).collect(Collectors.toCollection(ArrayList<DataPoint>::new));
  // test
 /* for (int i=0; i<selectedFlights.size(); i++)
  {
    selectedFlights.get(i).printData();
  }*/
  return selectedFlights;
}

void printOriginSortedFlightData()
{
  //jhy implimented a better working printing text that
  //only prints the values within the screen and not all from very top to the scrollbar
  showingData.display();
  if (count!=dataPoints.size())
  {
    for (int i = 0; i < tableOfOrigin.size; i++)
    {
      LinkedList<DataPoint> temp = tableOfOrigin.getDataByIndex(i);
      for (int j= 0; j<temp.size(); j++)
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
  showingData.mousePressed();
  if (currentScreen == 4)
  {
    calendar.mousePressed(mouseX, mouseY);
  }
  //dropdown menu:
  //  mousePressedDropdown();
}

void mouseWheel(MouseEvent event) {
  if (currentScreen == 4)
  {
    calendar.mouseWheel(event);
  }
  if (showingData != null) {
    showingData.mouseWheel(event);
  }
  mouseWheelSB(event);
}

void keyPressed() {
  if (currentScreen == 4)
  {
    calendar.keyPressed();
  }
  keyPressedSB();
}

void mouseReleased() {
  showingData.mouseReleased();
  mousePressedSB();
}

void mouseClicked() //Flight For Plane AND Pins
{

  
  
  if (pinOrigin.isDropped() && pinArrival.isDropped())
  {
    pinOrigin.pickPin();
    pinArrival.pickPin();
    pinOrigin = new PlanePins(-1, -1, pinImg);
    pinArrival = new PlanePins(-1, -1, pinImg);
    fly = false;
  }
  if (pinOrigin.isDropped()&&!pinArrival.isDropped())
  {
    pinArrival.change(mouseX, mouseY);
    pinArrival.dropPin();
    airChina = new PlaneAnimate(pinOrigin.getX(), pinOrigin.getY(), pinArrival.getX(), pinArrival.getY(), planeImg);
    fly = true;
  }
  if (!pinOrigin.isDropped())
  {
    pinOrigin.change(mouseX, mouseY);
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
    tableOfOrigin.putOrigin(data);
    tableOfOrigin_Wac.putOriginWac(data);
    tableOfDestination.putDestination(data);
    tableOfDestination_Wac.putDestinationWac(data);
    tableOfAirports_Origin.putAirport(data, data.origin);
    tableOfAirports_Dest.putAirport(data, data.dest);
    int arrDelay = (int)(data.getArrDelay())/60;
    arrDelayFreq.put(arrDelay, arrDelayFreq.getOrDefault(arrDelay, 0) + 1);
  }
}
void createHashMaps(ArrayList<DataPoint> flights)
{
  arrDelayFreq=new HashMap<Integer, Integer>();
  airportFreq=new HashMap<String, Integer>();
  for (int i=0;i<flights.size();i++)
  {
    DataPoint data = flights.get(i);
    int arrDelay = (int)(data.getArrDelay())/60;
    arrDelayFreq.put(arrDelay, arrDelayFreq.getOrDefault(arrDelay, 0) + 1);
    String airport = data.origin;
    airportFreq.put(airport, airportFreq.getOrDefault(airport, 0) + 1);
    airport = data.dest;
    airportFreq.put(airport, airportFreq.getOrDefault(airport, 0) + 1);
  }
  airportFreqList = new ArrayList<>(airportFreq.entrySet());
  Collections.sort(airportFreqList, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return Integer.compare(o1.getValue(),o2.getValue());
            }
        });
   Collections.reverse(airportFreqList);
}

void createCharts()              //!!! Use this to create ALL the charts we need!!!               By chuan:)
{
   //createHashMaps(calendarDataPoint);
  //  int[] numberOfFlightsByDay = new int[tableOfDates.size];
  ArrayList<Integer> numOfFlightsByArrDelay = new ArrayList<Integer>();

  //String[] lables = new String[tableOfDates.size];
  /* for(int i=0 ; i<tableOfDates.size; i++)
   {
   numberOfFlightsByDay[i]=tableOfDates.getDataByIndex(i).size();
   lables[i] = "January "+(i+1);
   }*/
  String[] airportArray = new String[min(airportFreqList.size(),10)];
   int[] airportsNumArray = new int[min(airportFreqList.size(),10)];
  for (Map.Entry<Integer, Integer> entry : arrDelayFreq.entrySet())
  {
    numOfFlightsByArrDelay.add( entry.getValue());
  }
  for (int i=0;i<10&&i<airportFreqList.size();i++) {
     airportArray[i]= airportFreqList.get(i).getKey();
     airportsNumArray[i]= airportFreqList.get(i).getValue();
     println(airportFreqList.get(i).getKey()+" " +airportFreqList.get(i).getValue());
   }
  
 
  int[] arrDelayFreqArray = new int[numOfFlightsByArrDelay.size()];
  for (int i = 0; i < numOfFlightsByArrDelay.size(); i++)
  {
    arrDelayFreqArray[i] = numOfFlightsByArrDelay.get(i);
  }
  //pieChartOfDates = new PieChart(displayWidth/7,displayHeight/2, displayWidth/10,numberOfFlightsByDay,lables);
  String[] lables = {"on time", "cancelled", "delayed", "diverted"};
  pieChartOfDates = new PieChart(displayWidth/7, displayHeight/2, displayWidth/10, countCancelDelayDivert(calendarDataPoint), lables, "Proportions of flights with different status");//(int x, int y, int radius, int[]data, String[] labels, String title)
  // histogramOfDates = new Histogram(displayWidth/7, displayHeight/2 , displayHeight/10 , displayWidth/8, numberOfFlightsByDay, tableOfDates.size, 10, 10);
  histogramOfDates = new Histogram(displayWidth/50, displayHeight/4, displayHeight/2, displayWidth/4, arrDelayFreqArray, arrDelayFreqArray.length, 0, 1,
    "Frequencies of arrival delay", "Arrival delay (h)", "Frequency");
   flightsByAirport= new BarChart (displayWidth/50, displayHeight/7, displayHeight/2, displayWidth/4, airportsNumArray, airportsNumArray.length, airportArray,
   "Busiest airports", "Airports IATA", "Frequency");
  //   if(variable !="")
  
  //BarChart(int x, int y, int gphH, int gphW, double[] data, int numOfBins, String[] xCatogories,
   // String title, String labelX, String labelY )
  //  histogramOfDates = quickFrequencyHistogram(dataPoints , variable , "1/1 - 1/31");   //what do u wish---supporting: Delay , Distance
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
void sortDataByDistance (ArrayList <DataPoint> data)
{
  Collections.sort(data, new DistanceComparator());
}
void sortDataByArrDelay (ArrayList <DataPoint> data)
{
  Collections.sort(data, new ArrDelayComparator());
}

void sortDataByDepDelay (ArrayList <DataPoint> data)
{
  Collections.sort(data, new DepDelayComparator());
}

int[] countCancelDelayDivert(ArrayList <DataPoint> data)
{
  int normal=0;
  int cancel=0;
  int delay=0;
  int divert=0;
  for (int i =0; i<data.size(); i++)
  {
    DataPoint flight = data.get(i);
    if (flight.delayed)
      delay++;
    else if (flight.cancelled)
      cancel++;
    else if (flight.diverted)
      divert++;
    else
      normal++;
  }
  int[] freqArray={normal, cancel, delay, divert};
  return freqArray;
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
void init_stateCoord()
{
  stateCoord=new HashMap<String, double[]>();
  double[] coord={68, 265};
  stateCoord.put("CA", coord);
  coord=new double[]{125, 42};
  stateCoord.put("WA", coord);
  coord=new double[]{96, 112};
  stateCoord.put("OR", coord);
  coord=new double[]{189, 142};
  stateCoord.put("ID", coord);
  coord=new double[]{134, 227};
  stateCoord.put("NV", coord);
  coord=new double[]{218, 250};
  stateCoord.put("UT", coord);
  coord=new double[]{202, 357};
  stateCoord.put("AZ", coord);
  coord=new double[]{108, 477};
  stateCoord.put("AK", coord);
  coord=new double[]{282, 83};
  stateCoord.put("MT", coord);
  coord=new double[]{295, 174};
  stateCoord.put("WY", coord);
  coord=new double[]{319, 266};
  stateCoord.put("CO", coord);
  coord=new double[]{300, 360};
  stateCoord.put("NM", coord);
  coord=new double[]{423, 441};
  stateCoord.put("TX", coord);
  coord=new double[]{456, 349};
  stateCoord.put("OK", coord);
  coord=new double[]{440, 279};
  stateCoord.put("KS", coord);
  coord=new double[]{420, 214};
  stateCoord.put("NE", coord);
  coord=new double[]{410, 145};
  stateCoord.put("SD", coord);
  coord=new double[]{412, 81};
  stateCoord.put("ND", coord);
  coord=new double[]{295, 174};
  stateCoord.put("WY", coord);
  coord=new double[]{319, 266};
  stateCoord.put("CO", coord);
  coord=new double[]{299, 360};
  stateCoord.put("NM", coord);
  coord=new double[]{423, 441};
  stateCoord.put("TX", coord);
  coord=new double[]{456, 349};
  stateCoord.put("OK", coord);
  coord=new double[]{440, 279};
  stateCoord.put("KS", coord);
  coord=new double[]{420, 214};
  stateCoord.put("NE", coord);
  coord=new double[]{410, 145};
  stateCoord.put("SD", coord);
  coord=new double[]{412, 81};
  stateCoord.put("ND", coord);
  coord=new double[]{499, 114};
  stateCoord.put("MN", coord);
  coord=new double[]{515, 204};
  stateCoord.put("IA", coord);
  coord=new double[]{536, 285};
  stateCoord.put("MO", coord);
  coord=new double[]{543, 357};
  stateCoord.put("AR", coord);
  coord=new double[]{543, 437};
  stateCoord.put("LA", coord);
  coord=new double[]{650, 160};
  stateCoord.put("MI", coord);
  coord=new double[]{573, 148};
  stateCoord.put("WI", coord);
  coord=new double[]{588, 242};
  stateCoord.put("IL", coord);
  coord=new double[]{639, 237};
  stateCoord.put("IN", coord);
  coord=new double[]{696, 227};
  stateCoord.put("OH", coord);
  coord=new double[]{663, 291};
  stateCoord.put("KY", coord);
  coord=new double[]{649, 333};
  stateCoord.put("TN", coord);
  coord=new double[]{596, 400};
  stateCoord.put("MS", coord);
  coord=new double[]{649, 396};
  stateCoord.put("AL", coord);
  coord=new double[]{712, 394};
  stateCoord.put("GA", coord);
  coord=new double[]{758, 484};
  stateCoord.put("FL", coord);
  coord=new double[]{738, 259};
  stateCoord.put("WV", coord);
  coord=new double[]{884, 74};
  stateCoord.put("ME", coord);
  coord=new double[]{858, 117};
  stateCoord.put("NH", coord);
  coord=new double[]{840, 118};
  stateCoord.put("VT", coord);
  coord=new double[]{863, 147};
  stateCoord.put("MA", coord);
  coord=new double[]{870, 162};
  stateCoord.put("RI", coord);
  coord=new double[]{853, 167};
  stateCoord.put("CT", coord);
  coord=new double[]{807, 147};
  stateCoord.put("NY", coord);
  coord=new double[]{777, 200};
  stateCoord.put("PA", coord);
  coord=new double[]{833, 208};
  stateCoord.put("NJ", coord);
  coord=new double[]{826, 240};
  stateCoord.put("DE", coord);
  coord=new double[]{808, 236};
  stateCoord.put("MD", coord);
  coord=new double[]{782, 274};
  stateCoord.put("VA", coord);
  coord=new double[]{781, 319};
  stateCoord.put("NC", coord);
  coord=new double[]{754, 360};
  stateCoord.put("SC", coord);
  coord=new double[]{799, 241};
  stateCoord.put("DC", coord);
  coord=new double[]{362, 551};
  stateCoord.put("HI", coord);
}
void printDataByDepDelay(ArrayList data, boolean reversedOrder)
{
  nonCancelledFlights=getNonCancelledFlights(data);
  if (nonCancelledFlights!=null)
  {
    sortDataByDepDelay(nonCancelledFlights);
    if (!reversedOrder)
    {
      for (int index=0; index<nonCancelledFlights.size(); index++)
      {
        nonCancelledFlights.get(index).printData();
      }
    } else
    {
      for (int index=nonCancelledFlights.size()-1; index>=0; index--)
      {
        nonCancelledFlights.get(index).printData();
      }
    }
  }
}

void printDataByArrDelay(ArrayList data, boolean reversedOrder)
{
  nonDivertedFlights=getNonDivertedFlights(data);
  if (nonDivertedFlights!=null)
  {
    sortDataByArrDelay(nonDivertedFlights);
    if (!reversedOrder)
    {
      for (int index=0; index<nonDivertedFlights.size(); index++)
      {
        nonDivertedFlights.get(index).printData();
      }
    } else
    {
      for (int index=nonDivertedFlights.size()-1; index>=0; index--)
      {
        nonDivertedFlights.get(index).printData();
      }
    }
  }
}
