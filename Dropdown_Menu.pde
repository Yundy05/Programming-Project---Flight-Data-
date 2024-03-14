DropdownMenu ddMenu;
void setupDropDown()
{
  ddMenu = new DropdownMenu(100, 100, 200, 30);
  ddMenu.addItem(" fish airport");
  
}
void drawDropdown()
{
  //background(#DB6868);
  ddMenu.display();
}

void mousePressedDropdown()
{
  ddMenu.handleMousePressed();
}

class DropdownMenu
{
  int x, y, width, height;
  int cornerRadius = 10;
  String selected;
  ArrayList<String> items;
  boolean expanded;
  color boxClr = #D0C2D1;
  color textClr =#E3DC8E;
  
  DropdownMenu(int x, int y, int width, int height)
  {
    this.x = x;
    this.y = y;
    this.width  = width;
    this.height = height;
    this.items = new ArrayList<String>();
    this.selected = "";
    this.expanded = false;
  }
  
  void addItem(String item)
  {
    items.add(item);
  }
  
  void display()
  {
    fill(boxClr);
    stroke(2);
    if(expanded)
    {
      rect(x, y, width, height,cornerRadius);
      fill(textClr);
      text(selected, x+5, y + height -5);
      for(int i = 0; i < items.size(); i++)
      {
        int itemY = y+ height *(i+1);
        fill(boxClr);
        rect(x, itemY, width, height);
        fill(textClr);
        text(items.get(i), x+5, itemY + height -5);
      }
    }
    else
    {
      rect(x, y, width, height);
      //rect(MARGIN, MARGIN, SCREENX/4 - 2*MARGIN, SCREENY/20,20);
      fill(0);
      text(selected.equals("")?"Airport":selected, x+55, y + height -15);
      //text(selected.equals("")?"Origin":selected, MARGIN + 100, MARGIN +40);
    }
  }
  
  void toggle()
  {
    expanded = !expanded;
  }
  
  void select(String item)
  {
    selected = item;
    toggle();
  }
  
  void handleMousePressed()
  {
    if(mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height)
    {
      toggle();
    }
    else if (expanded)
    {
      for(int i =0; i < items.size(); i++)
      {
        int itemY = y + height *(i+1);
        if(mouseX >= x && mouseX <= x + width && mouseY <= itemY + height)
        {
          select(items.get(i));
          return;
        }
      }
    }
  }
  
}
