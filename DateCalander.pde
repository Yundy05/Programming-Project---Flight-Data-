class DateCalander
{
  PFont font = loadFont("Raanana-16.vlw");
  int year = 2020;
  int month = 0; //january
  int amountOfDays;
  int totalDays = 31;
  int selectedInboundDay = -1;
  int selectedOutboundDay = -1;
  int clickCount = 0;
  float x = 2560/200.0;          //unit x
  float y = (1600*9/10)/100.0;    //unit y
  boolean singleDateMode = false;
  int circleXPos;
  ArrayList<DataPoint> dp = new ArrayList <DataPoint> ();
  Button toSelect =  new Button(50*x, 45*y, 20*x, 4*y, "Select", #8080ff, #b3b3ff, SCREEN_SELECT, 10); //glowsize set to 10 for default use
  DateCalander(int amountOfDays)
  {
    this.amountOfDays = amountOfDays;
  }

  void display() {
    scale(displayWidth/2560.0,displayHeight/1600.0);
    textFont(font);
    textSize(50);
    fill(255);
    text("January", 50 * x, 10 * y);
    textSize(40);
    rect(25 * x, 12 * y, 50 * x, 40 * y, 35);
    textSize(2 * x);
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
      else if(i + 1 > amountOfDays)
      {
        strokeWeight(0);
        fill(120);
      }
      else
      {
        strokeWeight(1);
        fill(255);
      }
      stroke(0);
      rect(xPos, yPos, 5* x, 5* x);
      fill(0);
      text(i + 1, xPos + 2.5 * x, yPos + 2* y);
    }
    toggleSingle();
  }
  
void mousePressed(int mouseX, int mouseY) {
    int clickedColumn = (int)((mouseX*2560.0/displayWidth - int(28.5 * x)) / 80);
    int clickedRow = (int)((mouseY*1600.0/displayHeight - int(22 * y)) / 80);
    int clickedDay = clickedRow * 7 + clickedColumn + 1;
    
     if (mouseX*2560.0/displayWidth > 63 * x && mouseX*2560.0/displayWidth < 63 * x + 8* x &&
        mouseY*1600.0/displayHeight > 16 * y && mouseY*1600.0/displayHeight < 16 * y + 2.5 * y) {
        // Toggle the button state
        singleDateMode = !singleDateMode;
        selectedInboundDay = -1;
        selectedOutboundDay = -1;
        clickCount = 0;
    }


    if (clickedDay > 0 && clickedDay <= amountOfDays) {
        float cellStartX = 28.5 * x + clickedColumn * 80;
        float cellEndX = cellStartX + 70;
        float cellStartY = 22 * y + clickedRow * 80;
        float cellEndY = cellStartY + 70;

        if (mouseX*2560.0/displayWidth >= cellStartX &&mouseX*2560.0/displayWidth <= cellEndX && mouseY*1600.0/displayHeight >= cellStartY && mouseY*1600.0/displayHeight <= cellEndY) {
            if (singleDateMode) {
                // In single date mode, just select the clicked day
                selectedInboundDay = clickedDay;
                selectedOutboundDay = -1; // default
                clickCount = 1; 
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
                        selectedInboundDay = clickedDay;
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
    toSelect.over = mouseX*2560.0/displayWidth >= toSelect.x && mouseX*2560.0/displayWidth <= toSelect.x + toSelect.width 
    && mouseY*1600.0/displayHeight >= toSelect.y && mouseY*1600.0/displayHeight <= toSelect.y + toSelect.height;
    if (toSelect.over) {
      toSelect.currentColor = lerpColor(toSelect.currentColor, toSelect.overColor, 0.4);
    } else {
      toSelect.currentColor = lerpColor(toSelect.currentColor, toSelect.notOverColor, 0.4);
    }
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
