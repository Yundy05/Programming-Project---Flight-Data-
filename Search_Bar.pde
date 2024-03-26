
import controlP5.*;
import java.util.Arrays;
//controlP5 cp5;
class SearchBox
{
  ControlP5 cp5;
  Textfield searchField;
  ScrollableList dropdown;
  java.util.List<String> allOptions = new java.util.ArrayList<String>();
  java.util.List<String> filteredOptions = new java.util.ArrayList<String>();
  int x, y;
  int width,height;
  /*
  x= 20;
  y = 100;
  width = 50;
  height = 100;*/
    /*cp5.addTextField("TextField")
       .setPosition(x,y)
       .setSize(width, height)
       .setFont(createFont("arial", 20))
       .setAutoClear(true)
       .setColor(c0lor(255,0,0))
       .setFocus(true)
       .setLabel("Destroy the world immediately!!!!")
       ;*/
    SearchBox()
    {
        x= 20;
        y = 100;
        width = 50;
        height = 100;

        searchField =cp5.addTextfield("SF")
           .setPosition(x,y)
           .setSize(width, height)
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

    /*void Matched(ArrayList<String> items, String query)
    {
        ArrayList<String> matches = new ArrayList<String>();
        for(String obj: items)
        {
            if(obj.toLowerCase().contains(query.toLowerCase()))
            {
                matches.add(obj);
            }
        }
        items = matches;
        //filteredCities = matches.toArray(new String[matches.size()]);
    }*/

    /*void controlEvent(ControlEvent event)
    {
        if(event.isGroup() && event.getName().equals("dropdownList"))
        {
            int index = (int)event.getValue();
            if(index>=0 && index < items.size())
            {
                dropdownList.hide();
            }
        }
    }*/

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

void controlEvent(ControlEvent event)
{
  searchBox.controlEvent(event);
}
