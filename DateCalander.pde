class DateCalander
{
  PFont font = loadFont("Raanana-16.vlw");
  int year = 2020;
  int month = 0; //january
  int totalDays = 31;
  int selectedInboundDay = -1;
  int selectedOutboundDay = -1;
  int clickCount = 0;
  float x = displayWidth/200.0;          //unit x
  float y = (displayHeight*9/10)/100.0;    //unit y
  boolean singleDateMode = false;
  int circleXPos;
  Button toSelect =  new Button(50*x, 45*y, 20*x, 4*y, "Select", #8080ff, #b3b3ff, SCREEN_SELECT, 10); //glowsize set to 10 for default use


  void display() {
    textFont(font);
    textSize(50);
    fill(255);
    text("January", 50 * x, 10 * y);
    textSize(40);
    rect(25 * x, 12 * y, 50 * x, 40 * y, 35);
    textSize(30);
    fill(0);
    text("Toggle Single", 67 * x, 14 * y);
    textSize(40);
    for (int i = 0; i < totalDays; i++) {
      int xPos = (i % 7) * 80 + int(28.5 * x);
      int yPos = (i / 7) * 80 + int(22 * y);
      if (i + 1 == selectedInboundDay || i + 1 == selectedOutboundDay) {
        strokeWeight(4);
        fill(color(50,205,50));
      } 
      else if(i + 1 > selectedInboundDay && i + 1 < selectedOutboundDay)
      {
        strokeWeight(2);
        fill(200);
      }
      else {
        strokeWeight(1);
        fill(255);
      }
      stroke(0);
      rect(xPos, yPos, 70, 70);
      fill(0);
      text(i + 1, xPos + 35, yPos + 30);
    }
    toggleSingle();
  }
  
void mousePressed(int mouseX, int mouseY) {
    int clickedColumn = (int)((mouseX - int(28.5 * x)) / 80);
    int clickedRow = (int)((mouseY - int(22 * y)) / 80);
    int clickedDay = clickedRow * 7 + clickedColumn + 1;
    
     if (mouseX > 63 * x && mouseX < 63 * x + 8* x &&
        mouseY > 16 * y && mouseY < 16 * y + 2.5 * y) {
        // Toggle the button state
        singleDateMode = !singleDateMode;
        selectedInboundDay = -1;
        selectedOutboundDay = -1;
        clickCount = 0;
    }


    if (clickedDay > 0 && clickedDay <= totalDays) {
        float cellStartX = 28.5 * x + clickedColumn * 80;
        float cellEndX = cellStartX + 70;
        float cellStartY = 22 * y + clickedRow * 80;
        float cellEndY = cellStartY + 70;

        if (mouseX >= cellStartX && mouseX <= cellEndX && mouseY >= cellStartY && mouseY <= cellEndY) {
            if (singleDateMode) {
                // In single date mode, just select the clicked day
                selectedInboundDay = clickedDay;
                selectedOutboundDay = -1; // default
                clickCount = 1; // You might adjust or remove the click count logic depending on your needs
            } else {
                // Existing logic for range selection
                if (clickCount == 0 || clickCount == 2) {
                    selectedInboundDay = clickedDay;
                    selectedOutboundDay = -1;
                    clickCount = 1;
                } else if (clickCount == 1) {
                    if (clickedDay > selectedInboundDay) {
                        selectedOutboundDay = clickedDay;
                        clickCount = 2;
                    } else {
                        selectedInboundDay = clickedDay; // Optional: Adjust based on desired behavior for invalid selection
                        clickCount = 1;
                    }
                }
            }
        }
    }
}



  
boolean isSelectionComplete() {
    if (singleDateMode) {
        return selectedInboundDay > -1;
    } else {
        return selectedInboundDay > -1 && selectedOutboundDay > -1;
    }
}

String getSelectedDates() {
    if (isSelectionComplete()) 
    {
      return "selectedInboundDay , selectedOutboundDay";
    }
    return "Incomplete Search";
}
//67 * x, 14 * y
void toggleSingle()
{
  float circleXPos;
  if(singleDateMode)
  {
    fill(color(50,205,50));
    stroke(0);
    rect(63 * x, 16 * y, 8* x, 2.5 * y, (2.5 * y)/2);
    circleXPos =  63 * x + 8* x - 2.5 * y;
    fill(0);
    textSize(25);
    text("On", 66 * x, 17 * y);
  }
  else
  {
    fill(color(192,192,192));
    stroke(0);
    rect(63 * x, 16 * y, 8* x, 2.5 * y, (2.5 * y)/2);
    circleXPos = 63 * x;
    fill(255);
    textSize(25);
    text("Off", 68 * x, 17 * y);
  }
  fill(255); // White for the circle
  ellipse(circleXPos + (2.5 * y)/2, 16 * y + (2.5 * y)/2, 2.5 * y *0.8, 2.5 * y *0.8);
}


boolean finalToGoSelect()
{
    toggleSingle();
    toSelect.display();
    toSelect.update();
    if(toSelect.clicked())
    {
      return true;
    }
    else
    {
      return false;
    }
}
}
