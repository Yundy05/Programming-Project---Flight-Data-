
import java.util.Arrays;
import controlP5.*;
import java.util.Arrays;


ControlP5 cp5;
ControlP5 cp5Copy;
ControlP5 cp5DesCities;
SearchBox sbOriginCities;
SearchBox sbDestinationCities;
SearchBox sbAirport;
DateCalander DC;
float x = 2560/200.0;
float y = (1600*9/10)/100.0;
float xSBAirport;          //unit x
float ySBAirport;    //unit y
float xSBCity;          //unit x
float ySBCity;    //unit y
float ySBDestinationCity;
String OriginCity = null;
String DestinationCity = null;
class SearchBox
{
  ControlP5 cp5;
  Textfield searchField;
  ScrollableList dropdown;
  java.util.List<String> allOptions = new java.util.ArrayList<String>();
  java.util.List<String> filteredOptions = new java.util.ArrayList<String>();
  float x, y;
  float width,height;
  String label;
  String selectedItem;
    SearchBox(ControlP5 cp5, PApplet parent,float x, float y, ArrayList<String> stringList, String label)
    {
        this.cp5 = cp5;
        this.x= x;
        this.y = y;
        this.width = 300;
        this.height = 100;
        allOptions = stringList;
        this.label = label;

        searchField =this.cp5.addTextfield(label)
           .align(ControlP5.TOP, ControlP5.TOP, ControlP5.CENTER, -80)
           //.setPaddingY(-15)
           //.setOffsetY(-20)
           //.setPaddingY(-20)
           .setPosition(this.x,this.y)
           .setSize((int)width, (int)height)
           .setFont(parent.createFont("arial", 32))
           .setAutoClear(true)
           .setColor(color(255))
           .setFocus(true)
           //.setLabel("Destroy the world immediately!!!!")
           //.hide()
           ;
         searchField.getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPadding(0, 10);
         //searchField.getCaptionLabel().setColorValue(parent.color(196, 132, 195));
         //searchField.getCaptionLabel().setColorValue(#567899);
         //searchField.getCaptionLabel().setColor(0xC484C3); // Sets the label color to red
         // Correct way to set the caption label color within a custom class
        searchField.getCaptionLabel().setColor(parent.color(196, 195, 255)); // Example: sets the color to red
        searchField.setColorBackground(122);



        dropdown = this.cp5.addScrollableList("Select twice \nto confirm")
                            .setPosition(x, y+height)
                            .setSize(300, 200)
                            .setFont(createFont("arial", 32))
                            .setBarHeight(100)
                            .setItemHeight(50)
                            .addItems(allOptions)
                            //.setColor(parent.color(0x6AEFF5))
                            //.hide()
                            ;
        //dropdown.setColorCaptionLabel(0xFF0000); // Sets the caption label color to red
        dropdown.setColorActive(0xE5ABE4); // Sets the active item color to red
        dropdown.setColorForeground(0xE5ABE4); // Sets the foreground color
        dropdown.setColorBackground(122); // Sets the background color

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
          selectedItem = event.getController().getLabel();
    
          //println("Selected value: " + value);
          println("Current selection: " + selectedItem);
        }
    }
    void drawSB(PApplet parent)
    {
      //println("gyhu");
      if(currentScreen== SCREEN_SEARCH_BAR)
      {
        //println("gyhhhjjj");
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
ArrayList<String> stringList;
void setupSB()
{
  cp5 = new ControlP5(this);
  cp5Copy = new ControlP5(this);
  cp5DesCities = new ControlP5(this);
  stringList = new ArrayList<String>(
    Arrays.asList( "trinity", "newYork", "MESSSSS"));

  DC = new DateCalander(1);
  //xSBAirport = DC.x *40 - 50;
  //ySBAirport = DC.y *80 -100;
  //xSBCity = DC.x *40;
  //ySBCity = DC.y *80;
  //xSBAirport = 200;
  //ySBAirport = 200;
  xSBCity = 100;
  ySBCity = 400;
  //xSBCity = x *100;
  //ySBCity = y*100/3;
  ySBDestinationCity = 400;
  sbOriginCities =new SearchBox(cp5, this, xSBCity, ySBCity, cities, "Origin");
  sbDestinationCities =new SearchBox(cp5DesCities, this, xSBCity+500, ySBDestinationCity, cities, "Destination");
  //sbAirport =new SearchBox(cp5Copy,this, xSBAirport,ySBAirport, airports);
}
void drawSB()
{
  //background(240);
  //sbCities.drawSB(this);
  //sbAirport.displaySB(this);
  sbOriginCities.drawSB(this);
  sbDestinationCities.drawSB(this);
  OriginCity=sbOriginCities.selectedItem;
  DestinationCity = sbDestinationCities.selectedItem;

  println(OriginCity, DestinationCity);
}
void controlEvent(ControlEvent event)
{
  sbOriginCities.controlEvent(event);
  sbDestinationCities.controlEvent(event);
  //sbAirport.controlEvent(event);
}
