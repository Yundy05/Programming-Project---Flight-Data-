Screen homeScreen, flightScreen;

void setupScreen()
{
  homeScreen = new Screen(#121212, SCREEN_HOME); //Takes Hexadecimal Colour, and Int value of current page
  flightScreen = new Screen(#121212, SCREEN_FLIGHT);
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
    rect(15, 5, displayWidth/3 - 30, ((displayWidth)/2) - 10, 30); // (x, y, width, height, outline thickness)
    fill(screenBackground);
  }

  
   void drawBackgroundOutline()
   {
   stroke(0); // Set the stroke color back to black
   strokeWeight(OUTLINE_WIDTH);
   rect(0, 0, displayWidth/3, ((displayWidth)/2));
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
