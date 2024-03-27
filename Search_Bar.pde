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
  String selectedItem;
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
    void drawSB(PApplet parent)
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
ControlP5 cp5DesCities;
SearchBox sbOriginCities;
SearchBox sbDestinationCities;
SearchBox sbAirport;
DateCalander DC;
float xSBAirport;          //unit x
float ySBAirport;    //unit y
float xSBCity;          //unit x
float ySBCity;    //unit y
String OriginCity = null;
String DestinationCity = null;

ArrayList<String> stringList;
void setupSB()
{
  cp5 = new ControlP5(this);
  cp5Copy = new ControlP5(this);
  cp5DesCities = new ControlP5(this);
  stringList = new ArrayList<String>(
                Arrays.asList( "trinity", "newYork", "MESSSSS"));

  DC = new DateCalander(1);
  xSBAirport = DC.x *40 - 50;
  ySBAirport = DC.y *80 -100;
  xSBCity = DC.x *40;
  ySBCity = DC.y *80;
  /*xSBAirport = 200;
  ySBAirport = 200;
  xSBCity = 300;
  ySBCity = 300;*/
  sbOriginCities =new SearchBox(cp5,this, xSBCity,ySBCity , cities);
  sbDestinationCities =new SearchBox(cp5DesCities,this, xSBCity,ySBCity+200 , cities);
  sbAirport =new SearchBox(cp5Copy,this, xSBAirport,ySBAirport, airports);
  
             
}

void drawSB()
{
  //background(240);
  //sbCities.drawSB(this);
  //sbAirport.drawSB(this);
  OriginCity=sbOriginCities.selectedItem;
  DestinationCity = sbDestinationCities.selectedItem;
}
void controlEvent(ControlEvent event)
{
  sbOriginCities.controlEvent(event);
  sbDestinationCities.controlEvent(event);
  sbAirport.controlEvent(event);
}
