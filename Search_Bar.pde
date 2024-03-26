ControlP5 cp5;
import java.util.Arrays;
class SearchBox
{
  //ControlP5 cp5;
  Textfield searchField;
  ScrollableList dropdown;
  java.util.List<String> allOptions = new java.util.ArrayList<String>();
  java.util.List<String> filteredOptions = new java.util.ArrayList<String>();
  float x, y;
  float width,height;
    SearchBox(Button btn, ArrayList<String> stringList)
    {
        x= btn.x;
        y = btn.y +btn.height;
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
        }
    }
}
SearchBox searchBox;
Button button;
ArrayList<String> stringList;
void setupSB()
{
  //size(700,700);
  cp5 = new ControlP5(this);
  stringList = new ArrayList<String>(
                Arrays.asList( "trinity", "newYork", "MESSSSS"));
  button = new Button(300, 400, 80, 50, "", #8080ff, #b3b3ff,3, 10);
  searchBox =new SearchBox(button, stringList);
             
}

void drawSB()
{
  background(240);
  button.display();
}
void controlEvent(ControlEvent event)
{
  searchBox.controlEvent(event);
}
