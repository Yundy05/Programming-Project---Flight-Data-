ArrayList<Button>btnMain;
ArrayList<Button>btnControlPanel;
PFont buttonFont;

Button originBtn, destinationBtn, dateBtn, flightDataBtn, homePageBtn, graphBtn , showPieChartBtn , showHistogramBtn;

void setupBtn() //Takes constructor (Xpos, Ypos, SizeX, SizeY, Text, BaseColour, HoverColour, ButtonEvent)
{
  btnMain = new ArrayList<Button>();
  buttonFont = loadFont("Raanana-16.vlw");
  //MENU PAGE
  originBtn = new Button(MARGIN, MARGIN, (displayWidth/2)/4 - 2*MARGIN, (displayHeight - 100)/20, "Origin", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  destinationBtn = new Button((displayWidth/2) - (displayWidth/2)/3, MARGIN+ 2*(displayHeight - 100)/10 , (displayWidth/2)/3 - 50, (displayHeight - 100)/20, "Destination", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  dateBtn = new Button(MARGIN , MARGIN+ 2*(displayHeight - 100)/10, (displayWidth/2)/4 - 2*MARGIN, (displayHeight - 100)/20, "Date", #8080ff, #b3b3ff, EVENT_BUTTON_NULL);
  flightDataBtn = new Button((displayWidth/2) - (displayWidth/2)/3, (displayHeight - 100) - 500, (displayWidth/2)/3 - 50, (displayHeight - 100)/20, "Flight Data",#8080ff, #b3b3ff, EVENT_BUTTON_FLIGHT);
  graphBtn = new Button(displayWidth/15, (displayHeight - 100) - 500, (displayWidth/2)/3 - 50, (displayHeight - 100)/20, "GRAPHS",#8080ff, #b3b3ff, EVENT_BUTTON_TOGRAPH);
  //FLIGHT PAGE
  homePageBtn = new Button((displayWidth/2)-(displayWidth/2)/3, (displayHeight - 100) - 100, (displayWidth/2)/3 - 50, (displayHeight - 100)/20, "Home",#8080ff, #b3b3ff, EVENT_BUTTON_HOME);
  
  //GRAPH PAGE
  showPieChartBtn = new Button((displayWidth/2) - (displayWidth/2)/3, MARGIN+ 2*(displayHeight - 100)/10 , (displayWidth/2)/3 - 50, (displayHeight - 100)/20, "PieChart", #8080ff, #b3b3ff, EVENT_BUTTON_SHOWPIECHART);
  showHistogramBtn = new Button(MARGIN , MARGIN+ 2*(displayHeight - 100)/10, (displayWidth/2)/4 - 2*MARGIN, (displayHeight - 100)/20, "Histogram", #8080ff, #b3b3ff, EVENT_BUTTON_SHOWHISTOGRAM);
  
  btnMain.add(destinationBtn); btnMain.add(originBtn);
  btnMain.add(dateBtn); btnMain.add(flightDataBtn); btnMain.add(homePageBtn);
  

  homeScreen.addButton(originBtn);  
  homeScreen.addButton(destinationBtn);
  homeScreen.addButton(dateBtn); homeScreen.addButton(flightDataBtn); 
  homeScreen.addButton(graphBtn);
  flightScreen.addButton(homePageBtn);
  
  graphScreen.addButton(homePageBtn);
  graphScreen.addButton(showPieChartBtn);
  graphScreen.addButton(showHistogramBtn);
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
