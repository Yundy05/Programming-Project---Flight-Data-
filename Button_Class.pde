ArrayList<Button>btnMain;
ArrayList<Button>btnControlPanel;
PFont buttonFont;

Button originBtn, destinationBtn, dateBtn, flightDataBtn, homePageBtn;

void setupBtn() //Takes constructor (Xpos, Ypos, SizeX, SizeY, Text, BaseColour, HoverColour, ButtonEvent)
{
  btnMain = new ArrayList<Button>();
  //buttonFont = loadFont("Raanana-16.vlw");

  //originBtn      = new Button(MARGIN, MARGIN * 6, (displayWidth/3)/5, ((displayWidth)/2)/20, "Origin", #97f6fa, #CDF6F7, EVENT_BUTTON_NULL, 10);
  originBtn      = new Button(MARGIN, MARGIN * 6, (displayWidth/3)/5, ((displayWidth)/2)/20, "Origin", #CDF6F7, #97f6fa, EVENT_BUTTON_NULL, 10);
  //destinationBtn = new Button((displayWidth/3)/4 - MARGIN + 25, MARGIN * 6, (displayWidth/3)/5, ((displayWidth)/2)/20, "Destination", #8080ff, #b3b3ff, EVENT_BUTTON_NULL, 10);
  destinationBtn = new Button((displayWidth/3)/4 - MARGIN + 25, MARGIN * 6, (displayWidth/3)/5, ((displayWidth)/2)/20, "Destination", #b3b3ff, #8080ff, EVENT_BUTTON_NULL, 10);
  dateBtn        = new Button((displayWidth/3)/4 - MARGIN + 25, 150, (displayWidth/3)/5, ((displayWidth)/2)/20, "Date", #8080ff, #b3b3ff, EVENT_BUTTON_NULL, 10);
  flightDataBtn  = new Button(MARGIN, 150, (displayWidth/3)/5, ((displayWidth)/2)/20, "Flight Data", #F74BF5, #ea8be8, EVENT_BUTTON_FLIGHT, 10);

  homePageBtn    = new Button(MARGIN, MARGIN, (displayWidth/3)/5, ((displayWidth)/2)/20, "Home", #F74BF5, #ea8be8, EVENT_BUTTON_HOME, 10);

  btnMain.add(destinationBtn);
  btnMain.add(originBtn);
  btnMain.add(dateBtn);
  btnMain.add(flightDataBtn);
  btnMain.add(homePageBtn);

  homeScreen.addButton(originBtn);
  homeScreen.addButton(destinationBtn);
  homeScreen.addButton(dateBtn);
  homeScreen.addButton(flightDataBtn);
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
  int cornerRadius = 10;

  color notOverColor;
  color overColor;
  color fontColor = 0;
  color buttonColor;
  color currentColor;

  int glowSize;


  Button(int x, int y, int width, int height, String label, color buttonColor, color overColor, int event, int glowSize)
  {
    this.x = x;
    this.y = y;
    this.event = event;
    this.width = width;
    this.height = height;
    this.label = label;
    this.notOverColor = buttonColor;
    this.overColor = overColor;
    this.currentColor = buttonColor;
    this.glowSize = glowSize;
  }

  void display()
  {
    drawNeonEffect(x, y, width, height, over ? overColor : notOverColor, glowSize);
    fill(fontColor);
    stroke(255, 50); ///!!!
    textAlign(CENTER, CENTER);
    textFont(buttonFont2);
    text(label, x + this.width/2, y + this.height/2);   
  }

  void drawNeonEffect(int x, int y, int w, int h, color neonColor, int glowSize) {
    int baseAlpha = 30;
    int alphaStep = baseAlpha / (glowSize / 2);
    fill(currentColor);

    strokeWeight(2);
    stroke(neonColor);
    rect(x, y, w, h, cornerRadius);

    for (int i = glowSize; i >= 0; i--) {
      int alpha = max(baseAlpha - (alphaStep * i), 0);
      noFill();
      stroke(neonColor, alpha);
      strokeWeight(2 + i * 1.5);
      rect(x - i, y - i, w + i * 2, h + i * 2, cornerRadius);
    }
  }

  void update() {
    boolean isOver = mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    if (isOver) {
      currentColor = lerpColor(currentColor, overColor, 0.4);
    } else {
      currentColor = lerpColor(currentColor, notOverColor, 0.4);
    }
  }

  boolean clicked()
  {
    if (over && !mousePressed && wasPressed)
    {
      wasPressed = false;
      print(event);
      return true;
    } else {
      wasPressed = mousePressed;
      return false;
    }
  }
}
