import java.util.Arrays;
class SearchBox
{
  //ControlP5 cp5;
  Textfield searchField;
  ScrollableList dropdown;
  java.util.List<String> allOptions = new java.util.ArrayList<String>();
  java.util.List<String> filteredOptions = new java.util.ArrayList<String>();
  float x, y;
  float value;
  String selectedItem;
  float width,height;
    SearchBox(ControlP5 cp5, PApplet parent, Button btn, ArrayList<String> stringList)
    {
        x= btn.x+btn.width;
        y = btn.y ;//+btn.height;
        width = btn.width;
        height = btn.height/2;
        allOptions = stringList;

        searchField =cp5.addTextfield("SF")
           .setPosition(x,y)
           .setSize((int)width, (int)height)
           .setFont(createFont("arial", 20))
           .setAutoClear(true)
           .setColor(color(255,0,0))
           .setFocus(true)
           .setLabel("Destroy the world immediately!!!!")
           ;
        dropdown = cp5.addScrollableList("ddl")
                            .setPosition(x, y+height)
                            .setSize(200, 120)
                            .setBarHeight(20)
                            .setItemHeight(20)
                            .addItems(allOptions);
                            //.hide();
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
            //dropdown = cp5.show();
        }
        if (event.isFrom(dropdown)) {
    value = event.getValue();
    selectedItem = event.getController().getLabel();
    
    println("Selected value: " + value);
    println("Selected item: " + selectedItem);
  }
    }
}
ControlP5 cp5;
ControlP5 cp5Copy;
SearchBox sbCities;
SearchBox sbAirport;
Button btnCites;
Button btnAirport;
ArrayList<String> stringList;
void setupSB()
{
  //size(700,700);
  cp5 = new ControlP5(this);
  cp5Copy = new ControlP5(this);
  stringList = new ArrayList<String>(
                Arrays.asList( "trinity", "newYork", "MESSSSS"));
  btnCites = new Button(100, 100, 80, 50, "Cities", #8080ff, #b3b3ff,3, 10);
  btnAirport = new Button(500, 100, 80, 50, "Airport", #8080ff, #b3b3ff,3, 10);
  sbCities =new SearchBox(cp5, this, btnCites, cities);
  sbAirport =new SearchBox(cp5Copy, this,btnAirport, airports);
             
}

void drawSB()
{
  //background(240);
  btnCites.display();
  btnAirport.display();
}
void controlEvent(ControlEvent event)
{
  sbCities.controlEvent(event);
  //sbAirport.controlEvent(event);
}
