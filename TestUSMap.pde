/**
 * Get Child. 
 * 
 * SVG files can be made of many individual shapes. 
 * Each of these shapes (called a "child") has its own name 
 * that can be used to extract it from the "parent" file.
 * This example loads a map of the United States and creates
 * two new PShape objects by extracting the data from two states.
 */

PShape usa;
PShape michigan;
PShape ohio;

void setup() {
  size(1000, 800);  
  usa = loadShape("Blank_US_Map_With_Labels.svg");
  michigan= new PShape();
  ohio= new PShape();
  michigan = usa.getChild("MI");
  ohio = usa.getChild("OH");
}

void draw() {
  background(255);
  
  // Draw the full map
  shape(usa, 0, 0);
  
  // Disable the colors found in the SVG file
  michigan.disableStyle();
  // Set our own coloring
  
  stroke(255);
  fill(0, 51, 102);
  // Draw a single state
  shape(michigan, 0, 0); // Wolverines!
  // Disable the colors found in the SVG file
  ohio.disableStyle();
  // Set our own coloring
  fill(153, 0, 0);
  stroke(255);
  // Draw a single state
  shape(ohio, 0, 0);  // Buckeyes!
}
