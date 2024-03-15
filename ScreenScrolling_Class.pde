class ScreenScrolling
{
   int barWidth;
   int barHeight;
   int barX ;
   int barY ;
   float scrollPos = 0;
   boolean isDragging;
   
   ScreenScrolling(int widthh, int heightt,int x, int y){
     this.barWidth = widthh;
     this.barHeight = heightt;
     this.barX = x;
     this.barY = y;
   }
   
   
   void display() 
   {
    fill(255);
    noStroke();
    rect(barX, barY + scrollPos, barWidth, barHeight);
  }

  void update() 
  {
    if (isDragging) {
      scrollPos = mouseY - barY - barHeight /2 ;
      scrollPos = constrain(scrollPos, 0, height - barHeight);
    }
  }
void mouseWheel(MouseEvent event) {
  // Adjust scrollAmount based on mouse wheel movement
  if(scrollPos+barHeight>height)
  scrollPos = height-barHeight;
  else if(scrollPos<0)
  scrollPos = 0;
  else
  scrollPos += event.getCount() ;
}

  void mousePressed() {
    if (mouseX > barX && mouseX < barX + barWidth &&
        mouseY > barY + scrollPos && mouseY < barY + scrollPos + barHeight) {
      isDragging = true;
 
    }
  }

  void mouseReleased() {
    isDragging = false;
  }
}

 
