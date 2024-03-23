ArrayList<Button>btnMain;
ArrayList<Button>btnControlPanel;
PFont buttonFont;

Button originBtn, destinationBtn, dateBtn, flightDataBtn, homePageBtn, graphBtn, backArrow, forwardArrow;
Button showPieChartBtn, showHistogramBtn,  individualFlightBtn, departBtn, arrivalBtn, getFlightBtn, searchPageBtn , toSelect;

void setupBtn() //Takes constructor (Xpos, Ypos, SizeX, SizeY, Text, BaseColour, HoverColour, ButtonEvent)
{
  float x = displayWidth/200.0;          //unit x 
  float y = (displayHeight*9/10)/100.0;         //unit y
//  float mx = 2*x;                        //x margin

  btnMain = new ArrayList<Button>();
  buttonFont = loadFont("Raanana-16.vlw");
  //MENU PAGE
//  dateBtn = new Button(x , MARGIN+ 2*(displayHeight - 100)/10, (displayWidth/2)/4 - 2*MARGIN, (displayHeight - 100)/20, "Date", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  flightDataBtn = new Button(60*x, 75*y, 30*x, 5*y, "Flight Data",#8080ff, #b3b3ff, EVENT_BUTTON_FLIGHT);
  graphBtn = new Button(10*x, 75*y, 30*x, 5*y, "GRAPHS",#8080ff, #b3b3ff, EVENT_BUTTON_TOGRAPH);
  individualFlightBtn = new Button(35*x, 45*y, 30*x, 5*y, "Individual Flights",#8080ff, #b3b3ff, EVENT_BUTTON_INDIVIDUAL_FLIGHT);
  
  //FLIGHT PAGE
  homePageBtn = new Button(45*x, 94*y , 8*x , 5*y, "",#8080ff, #b3b3ff, EVENT_BUTTON_HOME);
  
  //GRAPH PAGE
  showPieChartBtn = new Button(60*x, 20*y , 30*x, 5*y , "PieChart", #8080ff, #b3b3ff, EVENT_BUTTON_SHOWPIECHART);
  showHistogramBtn = new Button(10*x , 20*y , 30*x , 5*y, "Histogram", #8080ff, #b3b3ff, EVENT_BUTTON_SHOWHISTOGRAM);
  
  //INDIVIDUAL FLIGHTS PAGE - Andy
  originBtn = new Button(x, 75*y , 30*x , 5*y , "Origin", #8080ff, #b3b3ff, EVENT_BUTTON_ORIGIN);
  destinationBtn = new Button(69*x , 75*y , 30*x, 5*y, "Destination", #8080ff, #b3b3ff, EVENT_BUTTON_DESTINATION);
  departBtn = new Button(x, 56*y , 30*x, 5*y, "Departure", #8080ff, #b3b3ff, EVENT_BUTTON_DEPARTURE);
  arrivalBtn = new Button(69*x, 56*y , 30*x, 5*y, "Arrival", #8080ff, #b3b3ff, EVENT_BUTTON_ARRIVAL);
  getFlightBtn = new Button(33*x , y , 30*x, 5*y,"Get A Flight :) " , #8080ff, #b3b3ff, EVENT_GETFLIGHT);
  
  //TEST SEARCH PAGE - Andy
  searchPageBtn = new Button(35*x , 20*y , 30*x, 5*y,"Search Screen" , #8080ff, #b3b3ff, EVENT_BUTTON_SEARCH_PAGE);
  toSelect = new Button(35*x , 40*y , 30*x , 5*y, "Select" , #8080ff, #b3b3ff, SCREEN_SELECT);
  
  //HISTORY BUTTON PAGE - ANDY
  backArrow = new Button(x , y , 3*x, 4*y,"<" , #8080ff, #b3b3ff, EVENT_BUTTON_BACK);
  forwardArrow = new Button(5*x , y , 3*x, 4*y,">" , #8080ff, #b3b3ff, EVENT_BUTTON_FORWARD);
  
  btnMain.add(destinationBtn); btnMain.add(originBtn);
  btnMain.add(dateBtn); btnMain.add(flightDataBtn); btnMain.add(homePageBtn);
  
  homeScreen.addButton(individualFlightBtn);  
  homeScreen.addButton(flightDataBtn); 
  homeScreen.addButton(graphBtn);
  homeScreen.addButton(searchPageBtn);
  homeScreen.addButton(backArrow);
  homeScreen.addButton(forwardArrow);
  
  flightScreen.addButton(homePageBtn);
  flightScreen.addButton(backArrow);
  flightScreen.addButton(forwardArrow);
  
  graphScreen.addButton(homePageBtn);
  graphScreen.addButton(showPieChartBtn);
  graphScreen.addButton(showHistogramBtn);
  graphScreen.addButton(backArrow);
  graphScreen.addButton(forwardArrow);
  
  individualFlightScreen.addButton(homePageBtn);
  individualFlightScreen.addButton(originBtn);
  individualFlightScreen.addButton(destinationBtn);
  individualFlightScreen.addButton(departBtn);
  individualFlightScreen.addButton(arrivalBtn);
  individualFlightScreen.addButton(getFlightBtn);
  individualFlightScreen.addButton(backArrow);
  individualFlightScreen.addButton(forwardArrow);
  
  searchScreen.addButton(homePageBtn);
  searchScreen.addButton(toSelect);
  searchScreen.addButton(backArrow);
  searchScreen.addButton(forwardArrow);
  
  selectScreen.addButton(homePageBtn);
}

class fontChangingButton extends Button
{  
  color fontColor2;
  fontChangingButton(float x, float y, float width, float height, String label, color buttonColor, color overColor, int event , color fontColor , color fontColor2)
  {
    super(x , y , width, height , label , buttonColor , overColor, event );
    this.fontColor = fontColor;
    this.fontColor2 = fontColor2;
  }
  void display()
  {
    if(over== true)
    {
      fill(notOverColor);
      rect(this.x, this.y, this.width, this.height, cornerRadius);
      fill(fontColor2);
      textSize(28);
      textAlign(CENTER, CENTER);
      text(label, x + this.width/2, y + this.height/2);
    }
    else
    {
      fill(overColor);
    rect(this.x, this.y, this.width, this.height, cornerRadius);
    fill(fontColor);
    textSize(28);
    textAlign(CENTER, CENTER);
    text(label, x + this.width/2, y + this.height/2);
    }
  }
}

class Button
{
  float width, height;
  float x, y;
  int event;
  String label;
  boolean over = false;
  boolean wasPressed = false;    //used to activate the button only after releasing click to ensure that buttons dont fuck eachother up if they are in the same location  but on different screens 
  int cornerRadius = 20;
  color notOverColor;
  color overColor;
  color fontColor = 0;
  color buttonColor;
  
  Button(float x, float y, float width, float height, String label, color overColor, color buttonColor, int event)
  {
    this.x = x;
    this.y = y;
    this.event = event;
    this.width = width;
    this.height = height;
    this.label = label;
    this.overColor = overColor;
    this.notOverColor = buttonColor;
    textFont(buttonFont);
  }
  
  void display()
  {
    if(over == true)
    {
      fill(overColor);
      
    }
    else
    {
      fill(notOverColor);
    }
    rect(this.x, this.y, this.width, this.height, cornerRadius);
    fill(fontColor);
    textSize(28);
    textAlign(CENTER, CENTER);
    text(label, x + this.width/2, y + this.height/2);
  }
  
  void update()
  {
    if(mouseX>= x && mouseX <= x+ width && mouseY >= y && mouseY <= y+height)
    {
      over = true;
    }
    else
    {
      over = false;
    }
    
  }
  
  boolean clicked()
  {
    if(over && !mousePressed && wasPressed)
    {
       wasPressed = false;
 //      print(graphOption);
       return true;
     }
    else
    {
      wasPressed = mousePressed;
      return false;
    }
  }
}
