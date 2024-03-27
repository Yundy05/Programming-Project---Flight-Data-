class DateCalander
{
  PImage takeOff = loadImage("flight-takeoff.256x193.png");
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
  String inputChanged = "";
  int circleXPos;
  ArrayList<DataPoint> dp = new ArrayList <DataPoint> ();
  ArrayList<String> departureOrArrive = new ArrayList<String>();
  ArrayList<String> departure = new ArrayList<String>();
  ArrayList<String> arrival = new ArrayList<String>();

  DropdownTextbox dropdownOption1;
  DropdownTextbox dropdownOption2;
  DropdownTextbox dropdownOption3;
  Button toSelect =  new Button(50*x, 77*y, 20*x, 4*y, "Select", #8080ff, #b3b3ff, SCREEN_SELECT, 10); //glowsize set to 10 for default use
  
  DateCalander(int amountOfDays)
  {
    this.amountOfDays = amountOfDays;
    takeOff.resize(int(3 * x),int(2 * y));
    dropdownOption1 = new DropdownTextbox(int(x * 10), int(x * 15), int(80 * x) , int(5 * y), 10);
    dropdownOption2 = new DropdownTextbox(int(x * 10), int(x * 25), int(80 * x) , int(5 * y), 10);
    dropdownOption3 = new DropdownTextbox(int(x * 10), int(x * 35), int(80 * x) , int(5 * y), 10);

    Collections.addAll(departureOrArrive, "Departure Only", "Arrival Only", "Departure & Arriving", "Single Date Only", "Date range");
    dropdownOption1.addOptions(departureOrArrive);
  }


void displayForOrigin()
{
  scale(displayWidth/2560.0,displayHeight/1600.0);
  textFont(font);
  fill(225);
  noStroke();
  rect(5 * x, 12 * y, 90 * x, 80 * y, 20);
  rect(5 * x, 8 * y, 20 * x, 5 * y);
  
  textSize(30);
  fill(100);
  image(takeOff, 6* x, 8.5 * y);
  text("Check a flight", 16 * x, 9.5 * y);
  displayForCalendar();
  dropdownOption3.draw();
  dropdownOption2.draw();
  dropdownOption1.draw();
  
  if(dropdownOption1.inputText == "Departure & Arriving")
  {
    dropdownOption2.inputText = "Departure: " + OriginCity; 
    dropdownOption3.inputText = "Arrival: " + DestinationCity; 
  }
  else if(dropdownOption1.inputText == "Departure Only")
  {
    dropdownOption2.inputText = "Departure: " + OriginCity; 
    dropdownOption3.inputText = "Arrival: Any"; 
  }
  
  else if(dropdownOption1.inputText == "Arrival Only")
  {
    dropdownOption2.inputText = "Departure: Any";
    dropdownOption3.inputText = "Arrival: " + DestinationCity; 
  }
  else if(dropdownOption1.inputText =="Single Date Only" || dropdownOption1.inputText == "Date range")
  {
    dropdownOption2.inputText = "Departure: Any";
    dropdownOption3.inputText = "Arrival: Any";
  }
  else if(dropdownOption1.inputText == "")
  {
    dropdownOption1.inputText = ("Select Your Data Type");
  }
}

//for Calendar -jhy
  void displayForCalendar() {
    scale(displayWidth/2560.0,displayHeight/1600.0);
    textFont(font);
    textSize(40);
    fill(255);
    rect(25 * x, 50 * y, 50 * x, 35 * y, 35);
    for (int i = 0; i < totalDays; i++) {
      int xPos = (i % 7) * 80 + int(28.5 * x);
      int yPos = (i / 7) * 80 + int(55 * y);
      if (i + 1 == selectedInboundDay || i + 1 == selectedOutboundDay && dropdownOption1.inputText != "") {
        strokeWeight(4);
        fill(color(50,205,50));
      } 
      else if(i + 1 > selectedInboundDay && i + 1 < selectedOutboundDay && dropdownOption1.inputText != "")
      {
        strokeWeight(2);
        fill(200);
      }
      else if(i + 1 > amountOfDays || dropdownOption1.inputText == "" || !dropdownOption1.ifItIsOption)
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
    textSize(50);
    fill(0);
    text("January", 50 * x, 52 * y);
    
    if(inputChanged != dropdownOption1.inputText)
    {
      selectedInboundDay = -1;
      selectedOutboundDay = -1;
      inputChanged = dropdownOption1.inputText;
      if(inputChanged == "Departure & Arriving" || inputChanged == "Date range")
      {
        singleDateMode = false;
      }
      else
      {
        singleDateMode = true;
      }
    }
  }


  
void mousePressed(int mouseX, int mouseY) {
    dropdownOption1.mousePressed();
    int clickedColumn = (int)((mouseX*2560.0/displayWidth - int(28.5 * x)) / 80);
    int clickedRow = (int)((mouseY*1600.0/displayHeight - int(55 * y)) / 80);
    int clickedDay = clickedRow * 7 + clickedColumn + 1;

    if (clickedDay > 0 && clickedDay <= amountOfDays && (dropdownOption1.inputText != "" && dropdownOption1.ifItIsOption)) {
        float cellStartX = 28.5 * x + clickedColumn * 80;
        float cellEndX = cellStartX + 70;
        float cellStartY = 55 * y + clickedRow * 80;
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

void keyPressed()
{
  dropdownOption1.keyPressed();
}

void mouseWheel(MouseEvent event)
{
  dropdownOption1.mouseWheel(event);
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

boolean finalToGoSelect()
{
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
