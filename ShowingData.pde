class ShowingData { //new mousewheel scroll method for better screen performance as temp as scrollbar has bugs
  PGraphics screen = new PGraphics();
  PVector screenPos = new PVector(20, 20);
  float screenX = 0;
  float screenY = 0;
  float scroll = 0;
  float textHeight = 20;
  float textLeading = 25;
  int startLine = 0; //to be implimented for scrollBar
  int endLine = 0;   //to be implimented for scrollbar
  StringList flights;
  ScreenScrolling scrollingBar;
  
  ShowingData(float x, float y, int widthh, int heightt, ScreenScrolling scrollingBar) {
    screen = createGraphics(widthh - 60, heightt - 60, P2D);
    flights = new StringList();
    this.scrollingBar = scrollingBar;
  }

void display() {
  //setup of display
  screen.beginDraw();
  screen.background(0, 0, 0, 0);
  screen.noFill();
  screen.rect(0, 0, screen.width - 1, screen.height - 1);//my little box
  screen.textSize(20);
  screen.fill(0);
  screen.textAlign(LEFT, TOP);
  screen.textLeading(textLeading);
  
  
  //the loading of flights onto screen
  for (int i = 0; i < flights.size(); i++) {
    float y = screenY + (i - startLine) * textLeading + scroll;
    if (y > screen.height) break; // Stop drawing if the text is beyond the visible area
    screen.text(flights.get(i), screenX, y);
  }
  screen.endDraw();
  image(screen, screenPos.x, screenPos.y);
}




void mouseWheel(MouseEvent event)
{
    scroll -= event.getCount() * 20; //the speed that u can scroll at that can be changed with 20
    scroll = constrain(scroll, -(flights.size() * textLeading - screen.height), 0); //constrains the scroll to not go over limits e.g off screen
}


  void addFlight(String message) {
    flights.append(message); // add new message line to string to be shown on screen
}
}
