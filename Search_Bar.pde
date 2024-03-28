
import controlP5.*;
import java.util.Arrays;
class SearchBox
{
    ArrayList<String> options = new ArrayList<String>();
    ArrayList<String> filteredOptions =new ArrayList<String>();
    float x, y;
    float width, height;
    int ddlVisableCount = 4;
    int scrollIndex = 0;
    boolean ddlVisible = false;
    String label;
    String selectedItem;
    String searchQuery ="";
    boolean overSearchBox = false;
    SearchBox(ArrayList<String> data, float x, float y, String label) 
    {
        options = data;
        //filteredOptions = null;
        this.x = x;
        this.y = y;
        this.width = 300;
        this.height = 40;
        this.label = label;
    }

    void draw()
    {
        textSize(32);
        //setFontSize(32);
        drawGlow(x, y, width, height, color(#CFFCFB));
        fill(0);
        textAlign(LEFT);
        fill(255);
        text(label, x, y-height/2);
        fill(0);
        rect(x, y, width, height);
        fill(255);
        textAlign(LEFT);
        text(searchQuery, x +10, y+ this.height/2 +7);
        
       /* textSize(32);
        //setFontSize(32);
        drawGlow(x, y, width, height, color(#CFFCFB));
        fill(0);
        //rectMode(RIGHT);
        rect(x, y, width, height);
        fill(255);
        //textAlign(CENTER);
        text(searchQuery, x +10, y+ this.height/2 +7);*/

        if(ddlVisible && !filteredOptions.isEmpty())
        {
            for(int i = 0; i < ddlVisableCount; i++)
            {
                if(i + scrollIndex < filteredOptions.size())
                {
                    int optionX = (int)x;
                    int optionY = (int)y + (int)height *(i+1);

                    drawGlow(optionX, optionY, width, height,color(#CFFCFB));

                    fill(0);
                    //rectMode(RIGHT);
                    rect(optionX, optionY, width, height);
                    fill(255);
                    //textAlign(CENTER);
                    text(filteredOptions.get(i+scrollIndex), optionX +10, optionY +height/2 +7);
                }
            }
        }
        updateFilteredOptions();
        overSearchBox();
        //rectMode(CORNER);
    }

    void mouseWheel(MouseEvent event)
    {
        float e = event.getCount();
        if(ddlVisible)
        {
          //println("event.getCount()" + event.getCount());
            scrollIndex += int(e);
            //println("scrollIndex" + scrollIndex);
            scrollIndex = max(0,min(scrollIndex, filteredOptions.size()- ddlVisableCount));
            //scrollIndex = max(0,min(scrollIndex, filteredOptions.size()));
            //println(scrollIndex);
            
        }
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

    void keyPressed()
    {
        if(keyCode == BACKSPACE)
        {
            if(searchQuery.length()>0)
            {
                searchQuery = searchQuery.substring(0, searchQuery.length()-1);
                updateFilteredOptions();
            }
        }
        else if(keyCode == ENTER|| keyCode == RETURN)
        {
            ddlVisible = !ddlVisible;
        }
        else if(key >= ' ' && key <= '~')
        {
            searchQuery += key;
            updateFilteredOptions();
        }
    }

    void updateFilteredOptions()
    {
        filteredOptions.clear();
        if(searchQuery.equals(""))
        {
                    
            ddlVisible = false;
        }
        else
        {
          for(String option: options)
          {
                int inputLength = searchQuery.length();
                String cutString = option.substring(0, inputLength);
                if(cutString.toLowerCase().contains(searchQuery.toLowerCase()))
                {
                    filteredOptions.add(option);
                    ddlVisible = true;
                }
            }
        }
    }

    void mousePressed()
    {
        if(ddlVisible)
        {
            int clickedIndex = (int)((mouseY - y)/ height-1 );
            //println(clickedIndex);
            //println(filteredOptions.size());
            if(clickedIndex >=0 && clickedIndex <= (filteredOptions.size()-1))
            {
                searchQuery = filteredOptions.get(clickedIndex+scrollIndex);
                selectedItem = filteredOptions.get(clickedIndex+scrollIndex);
                println(selectedItem);
                // println("bhbh");
                ddlVisible = false;
                updateFilteredOptions();
            }
        }
        else;
       
    }
    
    void overSearchBox()
    {
      if(mouseX>x && mouseX< x+ width&& mouseY >y && mouseY <y+height)
      {
        overSearchBox= true;
      }
      else
      {
        overSearchBox = false;
      }
    }
}

SearchBox activeSB = null;
SearchBox sbOriginCities;
SearchBox sbDestinationCities;
SearchBox sbAirport;
//DateCalander DC;
float x = 2560/200.0; 
float y = (1600*9/10)/100.0;
float xSBAirport;          //unit x
float ySBAirport;    //unit y
float xSBCity;          //unit x
float ySBCity;    //unit y
float ySBDestinationCity;
String OriginCity = null;
String DestinationCity = null;

ArrayList<String> stringList;
void setupSB()
{

  //DC = new DateCalander(1);
  //xSBAirport = DC.x *40 - 50;
  //ySBAirport = DC.y *80 -100;
  //xSBCity = DC.x *40;
  //ySBCity = DC.y *80;
  //xSBAirport = 200;
  //ySBAirport = 200;
  xSBCity = 300;
  ySBCity = 350;
  //xSBCity = x *100;
  //ySBCity = y*100/3;
  ySBDestinationCity = 700;
  sbOriginCities =new SearchBox(cities, xSBCity,ySBCity , "Origin");
  sbDestinationCities =new SearchBox(cities, xSBCity, ySBDestinationCity  , "Destination");
  //sbAirport =new SearchBox(cp5Copy,this, xSBAirport,ySBAirport, airports);
  
             
}

void drawSB()
{
    sbOriginCities.draw();
    sbDestinationCities.draw();
    OriginCity=sbOriginCities.selectedItem;
    DestinationCity = sbDestinationCities.selectedItem;

}

void mouseWheelSB(MouseEvent event)
{
  if(activeSB != null)
    {
      activeSB.mouseWheel(event);
    }
  //sbOriginCities.mouseWheel(event);
  //sbDestinationCities.mouseWheel(event);
}
void keyPressedSB()
{
  if(activeSB != null)
    {
      activeSB.keyPressed();
    }
  //sbOriginCities.keyPressed();
  //sbDestinationCities.keyPressed();
}

void mousePressedSB()
{
  if(activeSB != null)
    {
      activeSB.mousePressed();
    }
    if(sbOriginCities.overSearchBox == true)
    {
      activeSB = sbOriginCities;
    }
    else if(sbDestinationCities.overSearchBox == true)
    {
      activeSB = sbDestinationCities;
    }
  //sbOriginCities.mousePressed();
  //sbDestinationCities.mousePressed();
}
