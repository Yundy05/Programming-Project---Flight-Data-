Screen  homeScreen, flightScreen, graphScreen, individualFlightScreen, searchScreen, selectScreen, searchBarScreen, histogramScreen,
        pieChartScreen , barChartScreen, heatMapScreen, lineGraphScreen;

void setupScreen()
{
  homeScreen = new Screen(#121212, SCREEN_HOME, backgroundNeon, true); //Takes Hexadecimal Colour, and Int value of current page
  flightScreen = new Screen(#121212, SCREEN_FLIGHT, backgroundNeon, true);
  graphScreen = new Screen(#121212, SCREEN_GRAPH, backgroundNeon, true);
  individualFlightScreen = new doubleScreen(#121212, 255, SCREEN_INDIVIDUAL_FLIGHT, displayHeight/2);
  //  individualFlightScreen = new Screen(#121212, SCREEN_INDIVIDUAL_FLIGHT);
  searchScreen = new Screen(#121212, SCREEN_SEARCH, backgroundNeon, true);
  selectScreen = new Screen(#121212, SCREEN_SELECT);
  searchBarScreen = new Screen(#121212, SCREEN_SEARCH, backgroundNeon, true);
  histogramScreen = new Screen(#121212, SCREEN_HISTOGRAM);
  pieChartScreen = new Screen(#121212, SCREEN_PIE_CHART);
  barChartScreen = new Screen(#121212, SCREEN_BAR_CHART);
  heatMapScreen = new Screen(#121212, SCREEN_HEAT_MAP);
  lineGraphScreen = new Screen(#121212, SCREEN_LINE_GRAPH);
}

class doubleScreen extends Screen
{

  color screenBackground2;
  float splitPoint;

  doubleScreen(color b1, color b2, int screenType, float p)    //second color displayed for p pixels counting from below
  {
    super(b1, screenType);
    this.screenBackground2 = b2;
    this.splitPoint = p;
  }
  
  void drawBackground()
  {
    fill(screenBackground);
    rect(0, 1, displayWidth/2, displayHeight*9/10); // (x, y, width, height, outline thickness)
    if (map!=null)
      map.draw();
    //    fill(screenBackground2);
    //    rect(0, displayHeight*9/10 - splitPoint, displayWidth/2, splitPoint + 50, 50);
  }
  void draw()
  {
    drawBackground();
    drawBtn();
  }
}

class Screen
{
  int screenType;
  color screenBackground;
  ArrayList screenItems;
  int event;
  boolean isBackground;
  PImage logoImg = loadImage("Logo.PNG");
  PImage appearance;
  
  Screen(color background, int screenType)
  {
    screenItems = new ArrayList();
    this.screenBackground = background;
    this.screenType = screenType;
    this.isBackground = false;
  }
  
  Screen(color background, int screenType, PImage backgroundImg, boolean isBackground)
  {
    screenItems = new ArrayList();
    this.screenBackground = background;
    this.screenType = screenType;
    this.appearance = backgroundImg;
    appearance.resize(displayWidth/2, displayHeight*9/10);
    this.isBackground = isBackground;
  }
  
  /*
  void setLogo(PImage logo) {
    this.logoImg = logo;
    logo.resize(200, 200);
  }
  */

  void drawLogo() {
    imageMode(CENTER);
    image(logoImg, width/2, 60);
    logoImg.resize(200,200);
    imageMode(CORNER);
  }
  

  void addButton(Button button)
  {
    screenItems.add(button);
  }

  void removeButton(Button button)
  {
    screenItems.remove(button);
  }

  void drawBackground()
  {
   
    if(isBackground)
      background(appearance);
    else{
      fill(screenBackground);
       rect(0, 1, displayWidth/2, displayHeight - 100, 1); // (x, y, width, height, outline thickness)
    }
  }

  int returnEvent()
  {
    event = EVENT_BUTTON_NULL ;
    for (int i = 0; i<screenItems.size(); i++)
    {
      Button button = (Button) screenItems.get(i);
      if (button.clicked())
      {
        event = button.event;
        //println("event: "+event);
      }
    }
    return event;
  }
  void drawBtn()
  {
    for (int i = 0; i<screenItems.size(); i++)
    {
      Button button = (Button) screenItems.get(i);
      button.display();
      button.update();
      //if(button.clicked() == EVENT_BUTTON_HOME)
      //{
      //  currentScreen = SCREEN_HOME;
      //}
      //else if(button.clicked() == EVENT_BUTTON_FLIGHT)
      //{
      //  currentScreen = SCREEN_FLIGHT;
      //}
      // drawDropdown();
    }
  }

  void draw()
  {
    drawBackground();
    drawBtn();
  }
}
