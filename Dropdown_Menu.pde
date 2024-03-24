import controlP5.*;
class DropdownMenu
{
  ControlP5 cp5;
  DropdownList ddl;
  String[] item;
  boolean isDdlOpen = false;
  //boolean isDdlOpen = false;
  //MyControlListener myListener;

  DropdownMenu(String name, int x, int y, String[] item)
  {
    ddl = cp5.addDropdownList(name)
      .setPosition(x, y)
      ;
    this.item = item;
    customize();
    ddl.addListener(new ControlListener()
    {
      public void controlEvent(ControlEvent event)
      {
        if (event.isController() && !isDdlOpen) {
          ddl.open(); // open the dropdown list if it's not open
          isDdlOpen = true;
        } else if (event.isController() && isDdlOpen)
        {
          ddl.close(); // close the dropdown list if it's open
          isDdlOpen = false;
        }
      }
    }
    );
  }


  void customize()
  {
    ddl.setBackgroundColor(color(190));
    ddl.setItemHeight(30);
    ddl.setBarHeight(20);
    for (int i = 0; i< item.length; i ++)
    {
      ddl.addItem(item[i], i);
    }
  }

  /*void customize(DropdownList ddl) {
   // a convenience function to customize a DropdownList
   ddl.setBackgroundColor(color(190));
   ddl.setItemHeight(20);
   ddl.setBarHeight(15);
   //ddl.captionLabel().set("dropdown");
   //ddl.captionLabel().style().marginTop = 3;
   //ddl.captionLabel().style().marginLeft = 3;
   //ddl.valueLabel().style().marginTop = 3;
   for (int i=0;i<40;i++) {
   ddl.addItem("item "+i, i);
   }
   //ddl.scroll(0);
   ddl.setColorBackground(color(60));
   ddl.setColorActive(color(255, 128));
   ddl.setColorBackground(color(60));
   ddl.setColorActive(color(150));
   }*/
}
