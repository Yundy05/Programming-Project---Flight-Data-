import java.util.Arrays;
class SearchBox
{
  ControlP5 cp5;
  Textfield searchField;
  ScrollableList dropdown;
  java.util.List<String> allOptions = new java.util.ArrayList<String>();
  java.util.List<String> filteredOptions = new java.util.ArrayList<String>();
  float x, y;
  float width,height;
    SearchBox(ControlP5 cp5, PApplet parent,float x, float y, ArrayList<String> stringList)
    {
        this.cp5 = cp5;
        this.x= x;
        this.y = y;
        this.width = 80;
        this.height = 50;
        allOptions = stringList;

        searchField =this.cp5.addTextfield("SF")
           .setPosition(this.x,this.y)
           .setSize((int)width, (int)height)
           .setFont(createFont("arial", 30))
           .setAutoClear(true)
           .setColor(color(255,0,0))
           .setFocus(true)
           .setLabel("Destroy the world immediately!!!!")
           .hide()
           ;
        dropdown = this.cp5.addScrollableList("ddl")
                            .setPosition(x, y+height)
                            .setSize(200, 120)
                            .setBarHeight(10)
                            .setItemHeight(50)
                            .addItems(allOptions)
                            .hide()
                            ;
    }

    void updateDropdown(String query)
    {
        filteredOptions.clear();
        for(String option : allOptions)
        {
            if(option.toLowerCase().contains(query.toLowerCase()))
            {
                filteredOptions.add(option);
            }
        }

        dropdown.clear();
        dropdown.addItems(filteredOptions);
    }
    void controlEvent(ControlEvent event)
    {
        if(event.isFrom(searchField))
        {
            updateDropdown(searchField.getText());
        }
        if (event.isFrom(dropdown)) 
        {
          float value = event.getValue();
          String selectedItem = event.getController().getLabel();
    
          println("Selected value: " + value);
          println("Selected item: " + selectedItem);
        }
    }
    void drawSB()
    {
      if(currentScreen== SCREEN_SEARCH && searchField.getText()!=null)
      {
        searchField.show();
        if(!searchField.getText().trim().isEmpty())
        {
          dropdown.show();
          println(searchField.getText());
        }
      }
      else
      {
        searchField.hide();
        dropdown.hide();
      }
    }
}
ControlP5 cp5;
ControlP5 cp5Copy;
SearchBox sbCities;
SearchBox sbAirport;
DateCalander DC;
float xSBAirport;          //unit x
float ySBAirport;    //unit y
float xSBCity;          //unit x
float ySBCity;    //unit y

ArrayList<String> stringList;
void setupSB()
{
  cp5 = new ControlP5(this);
  cp5Copy = new ControlP5(this);
  stringList = new ArrayList<String>(
                Arrays.asList( "trinity", "newYork", "MESSSSS"));

  //sbCities =new SearchBox(cp5, this, btnCites, cities);
  DC = new DateCalander(1);
  xSBAirport = DC.x *40;
  ySBAirport = DC.y *80;
  xSBCity = DC.x *40;
  ySBCity = DC.y *80;
  sbAirport =new SearchBox(cp5Copy,this, xSBAirport,ySBAirport, airports);
             
}

void drawSB()
{
  //background(240);
  sbAirport.drawSB();
}
void controlEvent(ControlEvent event)
{
  sbCities.controlEvent(event);
  sbAirport.controlEvent(event);
}
