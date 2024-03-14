ArrayList<Button>btnMain;
ArrayList<Button>btnControlPanel;
PFont buttonFont;

Button originBtn, destinationBtn, dateBtn, flightDataBtn, homePageBtn;

void setupBtn() //Takes constructor (Xpos, Ypos, SizeX, SizeY, Text, BaseColour, HoverColour, ButtonEvent)
{
  btnMain = new ArrayList<Button>();
  buttonFont = loadFont("Raanana-16.vlw");
  originBtn = new Button(MARGIN, MARGIN, SCREENX/4 - 2*MARGIN, SCREENY/20, "Origin", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  destinationBtn = new Button(SCREENX - SCREENX/3, MARGIN+ 2*SCREENY/10 , SCREENX/3 - 50, SCREENY/20, "Destination", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  dateBtn = new Button(MARGIN , MARGIN+ 2*SCREENY/10, SCREENX/4 - 2*MARGIN, SCREENY/20, "Date", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  flightDataBtn = new Button(SCREENX - SCREENX/3, SCREENY - 100, SCREENX/3 - 50, SCREENY/20, "Flight Data",#8080ff, #b3b3ff, EVENT_BUTTON_FLIGHT);
  homePageBtn = new Button(SCREENX-SCREENX/3, SCREENY - 100, SCREENX/3 - 50, SCREENY/20, "Home",#8080ff, #b3b3ff, EVENT_BUTTON_HOME);
  
  btnMain.add(destinationBtn); btnMain.add(originBtn);
  btnMain.add(dateBtn); btnMain.add(flightDataBtn); btnMain.add(homePageBtn);
  
  homeScreen.addButton(originBtn);  
  homeScreen.addButton(destinationBtn); 
  homeScreen.addButton(dateBtn); homeScreen.addButton(flightDataBtn);
  flightScreen.addButton(homePageBtn);
}


class Button
{
  int width, height;
  int x, y;
  int event;
  String label;
  boolean over = false;
  boolean wasPressed = false;    //used to activate the button only after releasing click to ensure that buttons dont fuck eachother up if they are in the same location  but on different screens 
  int cornerRadius = 20;
  color notOverColor;
  color overColor;
  color fontColor = 0;
  color buttonColor;
  
  Button(int x, int y, int width, int height, String label, color buttonColor, color overColor, int event)
  {
    this.x = x;
    this.y = y;
    this.event = event;
    this.width = width;
    this.height = height;
    this.label = label;
    this.notOverColor = buttonColor;
    this.overColor = overColor;
    textFont(buttonFont);
  }
  
  void display()
  {
    if(over== true)
    {
      fill(notOverColor);
    }
    else
    {
      fill(overColor);
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
       print(event);
       return true;
     }
    else
    {
      wasPressed = mousePressed;
      return false;
    }
  }
}
