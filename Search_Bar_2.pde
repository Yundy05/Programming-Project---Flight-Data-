class DropdownTextbox { //made by jiahao for the departure/ single/ arrival etc
  ArrayList<String> dropdownOptions = new ArrayList<String>();
  ArrayList<String> filteredOptions = new ArrayList<String>();
  boolean displayDropdown = false;
  String inputText = "";
  int textboxX;
  int textboxY;
  int textboxWidth;
  int textboxHeight;
  int dropdownItemHeight;
  int scrollOffset = 0;
  int round;
  boolean textboxSelected = false;
  boolean ifItIsOption = false;
  
  DropdownTextbox(int x, int y, int widthh, int heightt, int round) 
  {
    this.textboxX = x;
    this.textboxY = y;
    this.dropdownItemHeight = int(heightt * 0.8);

    this.textboxWidth = widthh;
    this.textboxHeight = heightt;
    this.round = round;
    filteredOptions.addAll(dropdownOptions); //copy all data over for filter
  }
  
void addOptions(ArrayList<String> options) 
{
    for (String option : options) {
        dropdownOptions.add(option);
    }
    filterDropdownOptions();
}

void draw() 
{
  drawTextbox();
  if (displayDropdown && textboxSelected) 
  {
    drawDropdown();
  }
}
  
void drawTextbox() 
{
    textSize(30);
    if(textboxSelected)
    {
      fill(245);
      strokeWeight(2);
      ifItIsOption = false;
    }
    if(!textboxSelected && inputText != "" && !ifItIsOption)
    {
      strokeWeight(1);
      fill(255);

      for(int i = 0; i < dropdownOptions.size(); i++)
      {
        if(dropdownOptions.get(i) == inputText)
        {
          ifItIsOption = true;
          break;
        }
        else
        {
            stroke(255,0,0);
            fill(255,0,0);
            text("Pick valid Type!", textboxX, 1.45* textboxY);
            fill(255);
        }
      } 
    }
    else
    {
      fill(255);
      strokeWeight(1);
    }
    
    rect(textboxX, textboxY, textboxWidth, textboxHeight);
    fill(0);
    textAlign(LEFT, CENTER); 
    String displayText = inputText;
    float textW = textWidth(displayText);
    
    //fixing alignment because for some weird reason it goes left when typing
    float textX = textboxX + 5; 
    if (textW > textboxWidth - 10) { // 10 pixels for padding
        textX = textboxX + textboxWidth - 5 - textW;
    }
    text(displayText, textX, textboxY + textboxHeight / 2);
}

  
  void drawDropdown() {
    int shownCount = 0;
    for (int i = scrollOffset; i < filteredOptions.size(); i++) {
      if (shownCount >= 5) break; // Limit visible items
      int itemY = textboxY + textboxHeight + shownCount * dropdownItemHeight;
      fill(255);
      stroke(0);
      rect(textboxX, itemY, textboxWidth, dropdownItemHeight);
      fill(0);
      text(filteredOptions.get(i), textboxX + 10, itemY + dropdownItemHeight / 2);
      shownCount++;
    }
  }
  
  void keyPressed() {
    if (!textboxSelected) return;
    if (key == BACKSPACE) {
      if (inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      }
    } else if (key != CODED && key >= 32 && key <= 126) {
      inputText += key;
    }
    
    filterDropdownOptions();
    displayDropdown = true;
  }
  
  void filterDropdownOptions() {
    filteredOptions.clear();
    String lowerCaseInput = inputText.toLowerCase();
    for (String option : dropdownOptions) {
      if (option.toLowerCase().contains(lowerCaseInput)) {
        filteredOptions.add(option);
      }
    }
    scrollOffset = 0; // Reset scroll offset on filter change
  }
  
  void mousePressed() {
    if (overTextbox(mouseX, mouseY)) {
      textboxSelected = true;
      displayDropdown = true;
    } else if (displayDropdown && overDropdown(mouseX, mouseY)) {
      int index = (mouseY - textboxY - textboxHeight) / dropdownItemHeight + scrollOffset;
      if (index >= 0 && index < filteredOptions.size()) {
        inputText = filteredOptions.get(index);
        textboxSelected = false;
        displayDropdown = false;
      }
    } else {
      textboxSelected = false;
    }
  }
  
  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    if (displayDropdown && overDropdown(mouseX, mouseY)) {
      scrollOffset -= (int)e;
      scrollOffset = constrain(scrollOffset, 0, max(0, filteredOptions.size() - 5));
    }
  }
  
  boolean overTextbox(int x, int y) {
    return x > textboxX && x < textboxX + textboxWidth && y > textboxY && y < textboxY + textboxHeight;
  }
  
  boolean overDropdown(int x, int y) {
    int dropdownHeight = min(filteredOptions.size(), 5) * dropdownItemHeight;
    return x > textboxX && x < textboxX + textboxWidth && y > textboxY + textboxHeight && y < textboxY + textboxHeight + dropdownHeight;
  }
}
