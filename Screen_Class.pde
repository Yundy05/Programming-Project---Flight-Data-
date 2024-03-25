Screen homeScreen, flightScreen, graphScreen, individualFlightScreen, searchScreen, selectScreen;

void setupScreen()
{
  homeScreen = new Screen(#121212, SCREEN_HOME); //Takes Hexadecimal Colour, and Int value of current page
  flightScreen = new Screen(#121212, SCREEN_FLIGHT);
  graphScreen = new Screen(#121212, SCREEN_GRAPH);
  individualFlightScreen = new doubleScreen(#121212, 255, SCREEN_INDIVIDUAL_FLIGHT, displayHeight/2);
  searchScreen = new Screen(#121212, SCREEN_SEARCH);
  selectScreen = new Screen(#121212, SCREEN_SELECT);
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
    fill(screenBackground2);
    rect(0, displayHeight*9/10 - splitPoint, displayWidth/2, splitPoint + 50, 50);
  }
  void draw()
  {
    drawBackground();
    //    drawBackgroundOutline();
    drawBtn();
  }
}

class Screen
{
  int screenType;
  color screenBackground;
  ArrayList screenItems;
  int event;
  Screen(color background, int screenType)
  {
    screenItems = new ArrayList();
    this.screenBackground = background;
    this.screenType = screenType;
  }

  void addButton(Button button)
  {
    screenItems.add(button);
  }

  void drawBackground()
  {
    rect(0, 1, displayWidth/2, displayHeight - 100, 1); // (x, y, width, height, outline thickness)
    fill(screenBackground);
  }

  void drawBackgroundOutline()
  {
    stroke(0); // Set the stroke color back to black
    strokeWeight(OUTLINE_WIDTH);
    rect(0, 0, displayWidth/2, displayHeight - 100, 1);
    noFill();
  }
  int returnEvent()
  {
    event = EVENT_BUTTON_NULL ;
    for (int i = 0; i<screenItems.size(); i++)
    {
      Button button = (Button) screenItems.get(i);
      if (button.clicked())
        event = button.event;
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
    drawBackgroundOutline();
    drawBtn();
  }
}
