class ScreenScrolling
{
   int barWidth;
   int barHeight;
   int barX ;
   int barY ;
   float scrollPos = 0;
   float maxScrollPos;
   float scrollAmount;
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
    scrollPos = -(scrollPos);
    rect(barX, barY + scrollPos, barWidth, barHeight);
  }

  void update() 
  {
    if (isDragging) {
      scrollPos = mouseY - barY - barHeight / 2;
      scrollPos = -(scrollPos);
      scrollPos = constrain(scrollPos, maxScrollPos, 0);
      println(scrollPos);
    }
  }
  
void mouseWheel(MouseEvent event) {
  scrollAmount = event.getCount() * 20; // Customize the multiplier as needed for smooth scrolling
  scrollPos = constrain(scrollPos + scrollAmount, 0, maxScrollPos);
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

 
