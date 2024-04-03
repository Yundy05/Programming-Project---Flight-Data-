import java.util.Arrays;
class SearchBox
{
    ArrayList<String> options = new ArrayList<String>();
    ArrayList<String> filteredOptions =new ArrayList<String>();
    int x, y;
    int widthh, heightt;
    int ddlVisableCount = 5;
    int scrollIndex = 0;
    boolean ddlVisible = false;
    String selectedItem;
    String searchQuery =" ";
    boolean overSearchBox = false;
    
    
    
    int dropdownItemHeight;
    int tR =(int)displayWidth/60;
    int scrollOffset = 0;
    int round;
    boolean textboxSelected = false;
    boolean ifItIsOption = false;
  //mouse blinker like how we have it when we type as a guideline
    boolean cursorVisible = true; // Whether the cursor is currently visible
    int cursorTimer = 0; // Timer to control cursor blinking
    int intervalForTime = 500; 
  
    SearchBox(ArrayList<String> data, int x, int y, int widthh, int heightt, int round, String label) 
    {
        options = data;
        //filteredOptions = null;
        this.x = x;
        this.y = y;
        this.widthh = widthh;
        this.dropdownItemHeight = int(heightt);
        this.heightt = heightt;
        this.searchQuery = label;
        this.round = round;
        filteredOptions.addAll(options);
    }

    void draw()
    {
        strokeWeight(0);
        textSize(0.6 * tR);
        drawGlow(x, y, widthh, heightt, color(#CFFCFB));
        textAlign(LEFT);
        fill(255);
        rect(x, y, widthh, heightt);
        fill(0);
        textAlign(LEFT);
        text(searchQuery, x +10, y + heightt/5 * 3);
        if (textboxSelected)
        {
          ifItIsOption = false;
        }
        else if (!textboxSelected && searchQuery != "" && !ifItIsOption)
        {
          for (int i = 0; i < options.size(); i++)
          {
            if (options.get(i) == searchQuery)
          {
            ifItIsOption = true;
            break;
          }
          }
        }
        if(ddlVisible && textboxSelected)
        {
              int shownCount = 0;
              for(int i = scrollOffset; i < filteredOptions.size(); i++)
              {
                if(shownCount >= 5)
                {
                  break;
                }
                int optionX = (int)x;
                int optionY = (int)y + (int)heightt + shownCount * dropdownItemHeight;
                drawGlow(optionX, optionY, widthh, heightt,color(#CFFCFB));
                fill(255);
                rect(optionX, optionY, widthh, dropdownItemHeight);
                fill(0);
                text(filteredOptions.get(i), optionX +10, optionY +dropdownItemHeight/2);
                shownCount++;
              }
        }
  //      updateFilteredOptions();
        overSearchBox();
        strokeWeight(0);
    }
    
    void drawGlow(float t, float p, float w, float h, int glowColor)
    {
      
        int glowSize = 10;  
        for(int i = glowSize; i>0; i--)
        {
            int alphaValue = (int)map(i, 0, glowSize, 0, 150);
            fill(red(glowColor), green(glowColor), blue(glowColor), alphaValue);
            //rectMode(RIGHT);
            rect(t-i, p-i, w+i*2, h+i*2);
        }
    }

    void mouseWheel(MouseEvent event)
    {
        float e = event.getCount();
        if(ddlVisible && overddl()) {
          scrollOffset += (int)e;
          scrollOffset = constrain(scrollOffset, 0, max(0, filteredOptions.size() - 5));
    }
    }


    void keyPressed()
    {
        if (!textboxSelected)
        {
          return;
        }
        if(keyCode == BACKSPACE)
        {
            if(searchQuery.length()>0)
            {
                searchQuery = searchQuery.substring(0, searchQuery.length()-1);
            }
        }
        else if(keyCode == ENTER|| keyCode == RETURN)
        {
            ddlVisible = !ddlVisible;
        }
        else if(key != CODED && key >= 32 && key <= 126)
        {
            searchQuery += key;
        }
        updateFilteredOptions();
        ddlVisible = true;
    }

    void updateFilteredOptions()
    {
        filteredOptions.clear();
        for(String option: options)
        {
          int inputLength = searchQuery.length();
          String cutString = option.substring(0, min(inputLength, option.length()));
          if(cutString.toLowerCase().contains(searchQuery.toLowerCase()))
          {
            filteredOptions.add(option);
          }
        }
        scrollOffset = 0;
    }
    
    
    

    void mousePressed()
    {
      if(overSearchBox())
      {
        textboxSelected = true;
        ddlVisible = true;
        searchQuery = "";
        updateFilteredOptions();
      }
      else if(ddlVisible && overddl())
      {
        int clickedIndex = (mouseY - int(y) - heightt) / dropdownItemHeight + scrollOffset;
        if(clickedIndex >=0 && clickedIndex < (filteredOptions.size()))
        {
          searchQuery = filteredOptions.get(clickedIndex);
          selectedItem = filteredOptions.get(clickedIndex);
          textboxSelected = false;
          ddlVisible = false;
  //        updateFilteredOptions();
        }
      }
      else
      {
        textboxSelected = false;
        ddlVisible = false;
      }
       
    }
   
    boolean overSearchBox()
    {
      if(mouseX>x && mouseX< x+ widthh&& mouseY >y && mouseY <y+heightt)
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    
    boolean overddl()
    {
      int dropdownHeight = min(filteredOptions.size(), 5) * dropdownItemHeight;
      return mouseX > x && mouseX < x + widthh && mouseY > y + heightt && mouseY < y + heightt + dropdownHeight;
    }
}
