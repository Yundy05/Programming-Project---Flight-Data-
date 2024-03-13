class ScreenScrolling
{
   int barWidth;
   int barHeight;
   int barX = 580;
   int barY = 0;
   float scrollPos = 0;
   boolean isDragging;
   
   ScreenScrolling(int num, int num2){
     this.barWidth = num;
     this.barHeight = num2;
   }
   
   
   void display() {
    fill(255);
    noStroke();
    rect(barX, barY + scrollPos, barWidth, barHeight);
  }

  void update() {
    if (isDragging) {
      scrollPos = mouseY - barY - barHeight / 2;
      scrollPos = constrain(scrollPos, 0, height - barHeight);
    }
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

 
