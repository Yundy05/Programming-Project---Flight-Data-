ArrayList<Button>btnMain;
ArrayList<Button>btnControlPanel;
PFont buttonFont;

Button originBtn, destinationBtn, dateBtn, flightDataBtn, homePageBtn, graphBtn, backArrow, forwardArrow, previousPage, nextPage, lengthByRoute, showHeatMapBtn;
Button showPieChartBtn, showHistogramBtn, showBarChartBtn, showLineGraphBtn, individualFlightBtn, departBtn,
  arrivalBtn, getFlightBtn, searchPageBtn, toSelect, helpBtn, searchBarBtn, filterBtn1, filterBtn2;
Button adjustDelayBtn, adjustDistanceBtn, adjustStatusBtn;
void setupBtn() //Takes constructor (Xpos, Ypos, SizeX, SizeY, Text, BaseColour, HoverColour, ButtonEvent)
{
  float x = displayWidth/200.0;                 //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  //  float mx = 2*x;                           //x margin
  int glowSize = 10;

  buttonFont = loadFont("Raanana-16.vlw");

  //MENU PAGE
  flightDataBtn = new Button(60*x, 75*y, 30*x, 5*y, "Flight Data", #8080ff, #b3b3ff, EVENT_BUTTON_FLIGHT, glowSize);
  //graphBtn = new Button(50*x, 30*y, 30*x, 5*y, "GRAPHS", #8080ff, #b3b3ff, SCREEN_GRAPH, glowSize);
  individualFlightBtn = new Button(35*x, 45*y, 30*x, 5*y, "Individual Flights", #8080ff, #b3b3ff, SCREEN_INDIVIDUAL_FLIGHT, glowSize);

  //FLIGHT PAGE
  // homePageBtn = new Button(45*x, 94*y, 8*x, 5*y, "", #8080ff, #b3b3ff, EVENT_BUTTON_HOME, glowSize);
  homePageBtn = new ImageButton(45*x, 91*y, 8*x, "homeButton1.png", "homeButton2.png", #8080ff, #b3b3ff, EVENT_BUTTON_HOME, glowSize);

  //GRAPH PAGE
  showPieChartBtn  = new ImageButton(60*x, 20*y, 20*x, "pie2.png", "pie1.png", #8080ff, #b3b3ff, EVENT_BUTTON_PIECHART, glowSize);
  showHistogramBtn  = new ImageButton(10*x, 20*y, 25*x, "hist2.png", "hist1.png", #8080ff, #b3b3ff, EVENT_BUTTON_HISTOGRAM, glowSize);
  showBarChartBtn  = new ImageButton(10*x, 60*y, 25*x, "bar2.png", "bar1.png", #8080ff, #b3b3ff, SCREEN_BAR_CHART, glowSize);
  showHeatMapBtn  = new ImageButton(60*x, 60*y, 35*x, "heat2.png", "heat1.png", #8080ff, #b3b3ff, EVENT_BUTTON_HEAT_MAP, glowSize);
  showLineGraphBtn = new ImageButton(35*x, 40*y, 25*x, "Line2.png", "Line1.png", #8080ff, #b3b3ff, SCREEN_LINE_GRAPH, glowSize);

  //HISTOGRAM PAGE - ANDY
  adjustDelayBtn = new ImageButton(15*x, 10*y, 25*x, "delay2.png", "delay1.png", #8080ff, #b3b3ff, EVENT_BUTTON_DELAY, glowSize);
  adjustDistanceBtn = new ImageButton(60*x, 10*y, 25*x, "distance2.png", "distance1.png", #8080ff, #b3b3ff, EVENT_BUTTON_DISTANCE, glowSize);

  //3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679 PAGE
  adjustStatusBtn = new ImageButton(37.5*x, 10*y, 25*x, "status2.png", "status1.png", #8080ff, #b3b3ff, EVENT_BUTTON_STATUS, glowSize);

  //BARCHART PAGE
  lengthByRoute = new Button(35*x, 10*y, 30*x, 5*y, "Longest Routes", #8080ff, #b3b3ff, EVENT_BUTTON_RL, glowSize);
  filterBtn1 = new Button(5*x, 10*y, 30*x, 5*y, "10 Busiest Airports", #8080ff, #b3b3ff, EVENT_BUTTON_FILTER_AIRPORT, glowSize);
  filterBtn2 = new Button(65*x, 10*y, 30*x, 5*y, "Filter 2", #8080ff, #b3b3ff, EVENT_BUTTON_FILTER_2, glowSize);

  //INDIVIDUAL FLIGHTS PAGE - Andy
  originBtn = new ImageButton(x, 73*y, 30*x, "Origin.png", "Origin.png", #8080ff, #b3b3ff, EVENT_BUTTON_ORIGIN, glowSize);
  destinationBtn = new ImageButton(69*x, 73*y, 30*x, "Destination.png", "Destination.png", #8080ff, #b3b3ff, EVENT_BUTTON_DESTINATION, glowSize);
  departBtn = new ImageButton(x, 54*y, 30*x, "Departure.png", "Departure.png", #8080ff, #b3b3ff, EVENT_BUTTON_DEPARTURE, glowSize);
  arrivalBtn = new ImageButton(69*x, 54*y, 30*x, "Arrival.png", "Arrival.png", #8080ff, #b3b3ff, EVENT_BUTTON_ARRIVAL, glowSize);
  getFlightBtn   = new ImageButton(41*x, 55*y, 17*x, "getFlight2.png", "getFlight1.png", #8080ff, #b3b3ff, EVENT_GETFLIGHT, glowSize);
  helpBtn   = new ImageButton(45*x, 75*y, 10*x, "help2.png", "help1.png", #8080ff, #b3b3ff, EVENT_GETHELP, glowSize);


  //SEARCH PAGE - Andy
  searchPageBtn = new Button(35*x, 20*y, 30*x, 5*y, "Search Screen", #8080ff, #b3b3ff, SCREEN_SEARCH, glowSize);
  toSelect = new Button(50*x, 50*y, 30*x, 5*y, "Select", #8080ff, #b3b3ff, SCREEN_SELECT, glowSize);

  //HISTORY BUTTON PAGE - ANDY
  backArrow = new ImageButton(x, y, 4*x, "LImg1.png", "LImg2.png", #8080ff, #b3b3ff, EVENT_BUTTON_BACK, glowSize);
  forwardArrow = new ImageButton(5*x, y, 4*x, "RImg1.png", "RImg2.png", #8080ff, #b3b3ff, EVENT_BUTTON_FORWARD, glowSize);

  //SELECT PAGE -CHUAN
  nextPage = new fontChangingButton(85*x, 90*y, 5*x, 5*y, ">", #36DFFF, #BF2E2E, EVENT_BUTTON_NEXT, 194, 0, 10);
  previousPage = new fontChangingButton(10*x, 90*y, 5*x, 5*y, "<", #36DFFF, #BF2E2E, EVENT_BUTTON_PREVIOUS, 194, 0, 10);

  //SEARCH BAR PAGE - ANDY
  searchBarBtn = new ImageButton(20*x, 20*y, 60*x, "searchButtom2.png", "searchButtom1.png", #8080ff, #b3b3ff, SCREEN_SELECT, glowSize);
  graphBtn = new ImageButton(20*x, 35*y, 60*x, "graphsButtom2.png", "graphsButtom1.png", #8080ff, #b3b3ff, SCREEN_GRAPH, glowSize);

  homeScreen.addButton(graphBtn);
  homeScreen.addButton(searchBarBtn);


  //flightScreen.addButton(homePageBtn);
  //flightScreen.addButton(backArrow);
  //flightScreen.addButton(forwardArrow);

  //graphScreen.addButton(homePageBtn);
  graphScreen.addButton(showPieChartBtn);
  graphScreen.addButton(showHistogramBtn);
  graphScreen.addButton(showHeatMapBtn);
  graphScreen.addButton(showBarChartBtn);
  graphScreen.addButton(showLineGraphBtn);
  //graphScreen.addButton(backArrow);
  //graphScreen.addButton(forwardArrow);

  //histogramScreen.addButton(homePageBtn);
  //histogramScreen.addButton(backArrow);
  //histogramScreen.addButton(forwardArrow);
  histogramScreen.addButton(adjustDelayBtn);
  histogramScreen.addButton(adjustDistanceBtn);

  //pieChartScreen.addButton(homePageBtn);
  //pieChartScreen.addButton(backArrow);
  //pieChartScreen.addButton(forwardArrow);
  pieChartScreen.addButton(adjustDelayBtn);
  pieChartScreen.addButton(adjustDistanceBtn);
  pieChartScreen.addButton(adjustStatusBtn);
  //barChartScreen.addButton(homePageBtn);
  barChartScreen.addButton(lengthByRoute);
  barChartScreen.addButton(filterBtn1);
  barChartScreen.addButton(filterBtn2);
  //barChartScreen.addButton(backArrow);
  //barChartScreen.addButton(forwardArrow);


  //individualFlightScreen.addButton(homePageBtn);
  individualFlightScreen.addButton(originBtn);
  individualFlightScreen.addButton(destinationBtn);
  individualFlightScreen.addButton(departBtn);
  individualFlightScreen.addButton(arrivalBtn);
  individualFlightScreen.addButton(getFlightBtn);
  //individualFlightScreen.addButton(backArrow);
  //individualFlightScreen.addButton(forwardArrow);
  individualFlightScreen.addButton(helpBtn);

  //searchBarScreen.addButton(backArrow);
  //searchBarScreen.addButton(forwardArrow);
  //searchBarScreen.addButton(homePageBtn);
  searchBarScreen.addButton(searchPageBtn);

  //searchScreen.addButton(homePageBtn);
  //searchScreen.addButton(backArrow);
  //searchScreen.addButton(forwardArrow);

  //  selectScreen.addButton(homePageBtn);
  selectScreen.addButton(nextPage);
  selectScreen.addButton(previousPage);
}

class fontChangingButton extends Button
{
  color fontColor2;
  fontChangingButton(float x, float y, float width, float height, String label, color overColor, color buttonColor, int event, color fontColor, color fontColor2, int glowSize)
  {
    super(x, y, width, height, label, buttonColor, overColor, event, glowSize);
    this.fontColor = fontColor;
    this.fontColor2 = fontColor2;
  }
  void display()
  {
    stroke(0);
    if (over== true)
    {
      fill(notOverColor);
      rect(this.x, this.y, this.width, this.height, cornerRadius);
      fill(fontColor2);
      textSize(28);
      textAlign(CENTER, CENTER);
      text(label, x + this.width/2, y + this.height/2);
    } else
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

class ImageButton extends Button {
  PImage unclickedImage;
  PImage clickedImage;

  //ImageButton(float x, float y, float targetWidth, String UnClickedImagePath, String ClickedImagePath, color overColor, color buttonColor, int event, int glowSize) {
  //  super(x, y, targetWidth, 0, "", overColor, buttonColor, event, glowSize);
  ImageButton(float x, float y, float targetWidth, String UnClickedImagePath, String ClickedImagePath, color overColor, color buttonColor, int event, int glowSize) {
    super(x, y, targetWidth, 0, "", overColor, buttonColor, event, glowSize);
    this.unclickedImage = loadImage(UnClickedImagePath);
    this.clickedImage = loadImage(ClickedImagePath);

    float aspectRatioUnclicked = unclickedImage.width / (float) unclickedImage.height;
    unclickedImage.resize((int)targetWidth, (int)(targetWidth / aspectRatioUnclicked));
    this.height = unclickedImage.height;

    float aspectRatioClicked = clickedImage.width / (float) clickedImage.height;
    clickedImage.resize((int)targetWidth, (int)(targetWidth / aspectRatioClicked));
  }

  void display()
  {
    if (over == true)
    {
      //imageMode(CENTER);
      image(unclickedImage, x, y);
      //unclickedImage.resize(600, 400);
      //imageMode(CORNER);
    } else
    {
      //imageMode(CENTER);
      image(clickedImage, x, y);
      //clickedImage.resize(600, 400);
      //imageMode(CORNER);
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
  int cornerRadius = 15;
  color notOverColor;
  color overColor;
  color fontColor = 0;
  color buttonColor;

  color currentColor;
  int glowSize = 10;

  Button(float x, float y, float width, float height, String label, color overColor, color buttonColor, int event, int glowSize)
  {
    this.x = x;
    this.y = y;
    this.event = event;
    this.width = width;
    this.height = height;
    this.label = label;
    this.buttonColor = buttonColor;
    this.overColor = overColor;
    this.notOverColor = buttonColor;
    this.currentColor = buttonColor;
    this.glowSize = glowSize;
    textFont(buttonFont);
  }

  void display() {
    drawNeonEffect(x, y, width, height, over ? overColor : notOverColor, glowSize);
    fill(fontColor);
    stroke(0);
    textSize(28);
    textAlign(CENTER, CENTER);
    text(label, x + this.width/2, y + this.height/2);
  }

  void drawNeonEffect(float x, float y, float w, float h, color neonColor, int glowSize) {
    int baseAlpha = 30;
    int alphaStep = baseAlpha / (glowSize / 2);
    fill(currentColor);
    strokeWeight(2);
    //    stroke(neonColor);
    rect(x, y, w, h, cornerRadius);

    //for (int i = glowSize; i >= 0; i--) {
    //  int alpha = max(baseAlpha - (alphaStep * i), 0);
    //  noFill();
    //  stroke(neonColor, alpha);
    //  strokeWeight(2 + i * 1.5);
    //  rect(x - i, y - i, w + i * 2, h + i * 2, cornerRadius);
    //}
  }

  void update() {
    over = mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    if (over) {
      currentColor = lerpColor(currentColor, overColor, 0.3);
    } else {
      currentColor = lerpColor(currentColor, notOverColor, 0.3);
    }
  }

  boolean clicked() {
    if (over && !mousePressed && wasPressed) {
      wasPressed = false;
      //      print(graphOption);
      return true;
    } else {
      wasPressed = mousePressed;
      return false;
    }
  }
}
