//made by yjh
class ShowingData { //new mousewheel scroll method for better screen performance as temp as scrollbar has bugs
  PGraphics screen = new PGraphics();
  PVector screenPos = new PVector(20, 20);
  float screenX = 0;
  float screenY = 0;
  float scroll = 0;
  float textHeight = 20;
  float textLeading = 35;
  float startLine = 0; //to be implimented for scrollBar
  int endLine = 0;   //to be implimented for scrollbar
  StringList flights;

  //screenScrolling
  int barWidth = 20;
  int barWidth2 = 10;
  int barHeight = 100;
  int barX = displayWidth / 2 -25;
  int barY = 1;
  float scrollPos = 0;
  float maxScrollPos;
  float scrollAmount;
  boolean isDragging;

  ShowingData(float x, float y, int widthh, int heightt) {
    screen = createGraphics(widthh - 60, heightt - 60, P2D);
    flights = new StringList();
  }

  void display() {
    //setup of display
    screen.beginDraw();
    screen.background(0, 0, 0, 0);
    screen.noFill();
    screen.rect(0, 0, screen.width - 1, screen.height - 1);//my little box
    screen.textSize(displayWidth/100);
    screen.fill(255);
    screen.textAlign(LEFT, TOP);
    screen.textLeading(textLeading);

    //the loading of flights onto screen
    calculateStartLine();
    for (int i = (int)startLine; i < flights.size(); i++) {
      float y = screenY + i * textLeading + scroll;
      if (y > screen.height) // Stop drawing if the text is beyond the visible area
      {
        break;
      }
      screen.text(flights.get(i), screenX, y);
      //    println(flights.get(i));
    }
    screen.endDraw();
    image(screen, screenPos.x, screenPos.y);
    updatingScroll();
    scrollDisplay();
    //  scrollingBar.display();
    //  scrollingBar.update();
  }


  void mouseWheel(MouseEvent event)
  {
    scroll -= event.getCount() * 20; //the speed that u can scroll at that can be changed with 20
    scroll = constrain(scroll, -(flights.size() * textLeading - screen.height), 0); //constrains the scroll to not go over limits e.g off screen
  }

  void calculateStartLine() {
    startLine = max(0, (int) (-scroll / textLeading));
  }


  void addFlight(String message) {
    flights.append(message); // add new message line to string to be shown on screen
  }



  //screenScrollingMethods

  void scrollDisplay()
  {
    if (isDragging) {
      fill(#E3E3E3, 180);
    } else {
      fill(#E3E3E3, 130);
    }
    noStroke();
    if (isDragging) {
      rect(barX, barY + scrollPos, barWidth, barHeight, 50);
    } else {
      rect(barX + 5, barY + scrollPos, barWidth2, barHeight, 50);
    }
  }


  void updatingScroll() {
    float totalContentHeight = flights.size() * textLeading;
    float visibleHeight = screen.height;
    maxScrollPos = -(totalContentHeight - visibleHeight); // Max negative scroll value

    if (isDragging) {
      scroll = mouseY - barY - (barHeight / 2);
      scroll = constrain(scroll, 0, visibleHeight - barHeight); //visible part
      scroll = scroll / (visibleHeight - barHeight);
      scroll = scroll * maxScrollPos;
    }
    float scrollRatio = (scroll / maxScrollPos);
    scrollPos = scrollRatio * (visibleHeight - barHeight);
    scrollPos = constrain(scrollPos, 0, visibleHeight - barHeight); // Constrain to the scroll area
  }


  void mousePressed() {
    if (mouseX > barX && mouseX < barX + barWidth && mouseY > barY + scrollPos && mouseY < barY + scrollPos + barHeight)
    {
      isDragging = true;
      println("is dragging");
    } else {
      // println("wrong");
    }
  }


  void mouseReleased() {
    isDragging = false;
  }
}
