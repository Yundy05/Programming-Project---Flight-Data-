/*class ScreenScrolling
{
  int barWidth;
  int barHeight;
  int barX = 700;
  int barY = 0;
  float scrollPos = 0;
  boolean isDragging;

  ScreenScrolling(int num, int num2) {
    this.barWidth = num;
    this.barHeight = num2;
  }
  
  void display() {
  if (isDragging) {
    fill(255, 255, 255, 150);
  } else {
    fill(255, 255, 255, 50);
  }
  noStroke();
  rect(barX, barY + scrollPos, barWidth, barHeight, 50);
}


  void update()
  {
    if (isDragging) {
      scrollPos = mouseY - barY - barHeight / 2;
      scrollPos = constrain(scrollPos, 0, height - barHeight);
    }
  }
  
  void mouseWheel(MouseEvent event) {
    // Adjust scrollAmount based on mouse wheel movement
    if (scrollPos+barHeight>height)
      scrollPos = height-barHeight;
    else if (scrollPos<0)
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
}*/
