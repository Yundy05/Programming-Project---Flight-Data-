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
  float x = displayWidth/200.0;                 //unit x
  float y = (displayHeight*9/10)/100.0;         //unit y
  int tR =(int)displayWidth/60;
  boolean singleDateMode = false;
  boolean toggleClickMode = false;
  boolean errorOption = false;
  String inputChanged = "";
  int circleXPos;
  ArrayList<DataPoint> dp = new ArrayList <DataPoint> ();
  ArrayList<String> departureOrArrive = new ArrayList<String>();
  ArrayList<String> departure = new ArrayList<String>();
  ArrayList<String> arrival = new ArrayList<String>();

  DropdownTextbox dropdownOption1;
  DropdownTextbox dropdownOption2;
  DropdownTextbox dropdownOption3;
  Button toSelect =  new Button(50*x, 80*y, 20*x, 4*y, "View Flights", #8080ff, #b3b3ff, SCREEN_SELECT, 10); //glowsize set to 10 for default use
  Button toGraph = new Button(50*x, 85 *y, 20*x, 4*y, "GRAPHS", #8080ff, #b3b3ff, EVENT_BUTTON_TOGRAPH, 10);

  DateCalander(int amountOfDays)
  {
    this.amountOfDays = amountOfDays;
    takeOff.resize(int(3 * x), int(2 * y));
    dropdownOption1 = new DropdownTextbox(int(x * 10), int(x * 15), int(80 * x), int(5 * y), 10);
    dropdownOption2 = new DropdownTextbox(int(x * 10), int(x * 25), int(80 * x), int(5 * y), 10);
    dropdownOption3 = new DropdownTextbox(int(x * 10), int(x * 35), int(80 * x), int(5 * y), 10);

    Collections.addAll(departureOrArrive, "Departure Only", "Arrival Only", "Departure & Arriving", "Single Date Only", "Date range");
    dropdownOption1.addOptions(departureOrArrive);
  }


  void displayForOrigin()
  {
    //  scale(displayWidth/2560.0,displayHeight/1600.0);
    textFont(font);
    fill(225);
    noStroke();
    rect(5 * x, 12 * y, 90 * x, 80 * y, 20);
    rect(5 * x, 8 * y, 20 * x, 5 * y);

    textSize(0.7 * tR);
    fill(100);
    image(takeOff, 6 * x, 8.5 * y);
    text("Check a flight", 16 * x, 9.5 * y);
    displayForCalendar();
    dropdownOption3.draw();
    dropdownOption2.draw();
    dropdownOption1.draw();

    if (dropdownOption1.inputText == "Departure & Arriving")
    {
      dropdownOption2.inputText = "Departure: " + OriginCity;
      dropdownOption3.inputText = "Arrival: " + DestinationCity;
    } 
    else if (dropdownOption1.inputText == "Departure Only")
    {
      dropdownOption3.inputText = "Arrival: Any";
      if(OriginCity == null)
      {
        dropdownOption2.inputText = "Departure: ERROR";
      }
      else
      {
      dropdownOption2.inputText = "Departure: " + OriginCity;
      }
    }
    else if (dropdownOption1.inputText == "Arrival Only")
    {
      dropdownOption2.inputText = "Departure: Any";
      if(DestinationCity == null)
      {
          dropdownOption3.inputText = "Arrival: ERROR";
      }
      else
      {
      dropdownOption3.inputText = "Arrival: " + DestinationCity;
      }
    } 
    else if (dropdownOption1.inputText =="Single Date Only" || dropdownOption1.inputText == "Date range")
    {
      dropdownOption2.inputText = "Departure: Any";
      dropdownOption3.inputText = "Arrival: Any";
    } else if (dropdownOption1.inputText == " ")
    {
      dropdownOption1.inputText = ("Select Your Data Type");
    }
    if(toggleClickMode)
    {
      toggleSingle();
      textSize(0.5 * tR);
      fill(0);
      text("Toggle Single", 63 * x, 50 * y);
    }
  }

  //for Calendar -jhy
  void displayForCalendar() {
    //    scale(displayWidth/2560.0,displayHeight/1600.0);
    textFont(font);
    textSize(1 * tR);
    fill(255);
    rect(25 * x, 47 * y, 50 * x, 44 * y, 35);
    for (int i = 0; i < totalDays; i++) {
      int xPos = int((i % 7) * 6.25*x + 28.5 * x);
      int yPos = int((i / 7) * 6.25*y + 55 * y);
      if (i + 1 == selectedInboundDay || i + 1 == selectedOutboundDay && dropdownOption1.inputText != "") {
        strokeWeight(4);
        fill(color(50, 205, 50));
      } else if (i + 1 > selectedInboundDay && i + 1 < selectedOutboundDay && dropdownOption1.inputText != "")
      {
        strokeWeight(2);
        fill(200);
      } else if (i + 1 > amountOfDays || dropdownOption1.inputText == "" || !dropdownOption1.ifItIsOption)
      {
        strokeWeight(0);
        fill(120);
      } else
      {
        strokeWeight(1);
        fill(255);
      }
      stroke(0);
      rect(xPos, yPos, 5 * x, 5 * x);
      fill(0);
      text(i + 1, xPos + 2.5 * x, yPos + 2 * y);
    }
    textSize(1.2 * tR);
    fill(0);
    text("January", 50 * x, 50 * y);

    if (inputChanged != dropdownOption1.inputText)
    {
      selectedInboundDay = -1;
      selectedOutboundDay = -1;
      inputChanged = dropdownOption1.inputText;
      toggleClickMode = false;
      if (inputChanged == "Departure & Arriving" || inputChanged == "Date range")
      {
        singleDateMode = false;
      }
      else if(inputChanged == "Single Date Only")
      {
        singleDateMode = true;
      }
      else
      {
        singleDateMode = false;
        toggleClickMode = true;
      }
    }
  }



  void mousePressed(int mouseX, int mouseY) {
    dropdownOption1.mousePressed();
    //int clickedColumn = (int)((mouseX*2560.0/displayWidth - int(28.5 * x)) / 80);
    //int clickedRow = (int)((mouseY*1600.0/displayHeight - int(55 * y)) / 80);
    int clickedColumn = (int)((mouseX- int(28.5 * x)) / (6.25*x));
    int clickedRow = (int)((mouseY - int(55 * y)) / (4.53*y));
    int clickedDay = clickedRow * 7 + clickedColumn + 1;

    if(toggleClickMode)
    {
      if (mouseX > (63 * x) && mouseX < (63 * x + 8 * x) && mouseY > (51 * y) && mouseY < (51 * y + 2.5 * y))
      {
        // Toggle on off
        singleDateMode = !singleDateMode;
        selectedInboundDay = -1;
        selectedOutboundDay = -1;
        clickCount = 0;
      }
    }
    
    
    if (clickedDay > 0 && clickedDay <= amountOfDays && (dropdownOption1.inputText != "" && dropdownOption1.ifItIsOption)) {
      float cellStartX = 28.5 * x + clickedColumn * 6.25*x;
      float cellEndX = cellStartX + 5.46*x;
      float cellStartY = 55 * y + clickedRow * 4.53*y;
      float cellEndY = cellStartY + 4*y;    
      
      //       if (mouseX*2560.0/displayWidth >= cellStartX &&mouseX*2560.0/displayWidth <= cellEndX && mouseY*1600.0/displayHeight >= cellStartY && mouseY*1600.0/displayHeight <= cellEndY) {
      if (mouseX >= cellStartX &&mouseX <= cellEndX && mouseY >= cellStartY && mouseY <= cellEndY) {
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


void toggleSingle()
{
  float circleXPos;
  if(singleDateMode)
  {
    fill(color(50,205,50));
    stroke(0);
    rect(63 * x, 51 * y, 8* x, 2.5 * y, (2.5 * y)/2);
    circleXPos =  63 * x + 8* x - 2.5 * y;
    fill(0);
    textSize(25);
    text("On", 66 * x, 52 * y);
  }
  
  else
  {
    fill(color(192,192,192));
    stroke(0);
    rect(63 * x, 51 * y, 8* x, 2.5 * y, (2.5 * y)/2);
    circleXPos = 63 * x;
    fill(255);
    textSize(25);
    text("Off", 67 * x, 52 * y);
  }
  fill(255); // White for the circle
  ellipse(circleXPos + (2.5 * y)/2, 51 * y + (2.5 * y)/2, 2.5 * y *0.8, 2.5 * y *0.8);
}



  boolean isSelectionComplete() {
    if(dropdownOption2.inputText == "Departure: ERROR"  || dropdownOption3.inputText == "Arrival: ERROR")
    {
      return false;
    }
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
    toSelect.over = mouseX >= toSelect.x && mouseX <= toSelect.x + toSelect.width
      && mouseY >= toSelect.y && mouseY <= toSelect.y + toSelect.height;
    if (toSelect.over) {
      toSelect.currentColor = lerpColor(toSelect.currentColor, toSelect.overColor, 0.4);
    } else {
      toSelect.currentColor = lerpColor(toSelect.currentColor, toSelect.notOverColor, 0.4);
    }
    if (toSelect.clicked())
    {
      updateData=true;
      return true;
    } else
    {
      return false;
    }
  }
  
  boolean finalToGoGraph()
  {
    toGraph.display();
    toGraph.over = mouseX >= toGraph.x && mouseX <= toGraph.x + toGraph.width
      && mouseY >= toGraph.y && mouseY <= toGraph.y + toGraph.height;
    if (toGraph.over) {
      toGraph.currentColor = lerpColor(toGraph.currentColor, toGraph.overColor, 0.4);
    } else {
      toGraph.currentColor = lerpColor(toGraph.currentColor, toGraph.notOverColor, 0.4);
    }
    if (toGraph.clicked())
    {
      updateData=true;
      return true;
    } else
    {
      return false;
    }
  }
}
