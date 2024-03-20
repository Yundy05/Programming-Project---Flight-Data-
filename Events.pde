

void printIndividualData(DataPoint aPoint)
{
      //originBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/3   Reminder of coordinates  Do Not uncomment
      //departBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/4   
      float x = displayWidth/200.0;          //unit x 
      float y = (displayHeight*9/10)/100.0;         //unit y  
      int m = 0;
      int LM =0;
      float buttonH = 5*y;
      int tR = (int)displayWidth/60;           //self adjusting texts
      
      float y1 = 55*y;                   //first line counting from north to south
      float y2 = 74*y ;

      stroke(128);
      line(1,  y2 , displayWidth/2 , y2);
      line(1,  y1 , displayWidth/2 , y1);
      String theDepartDate = aPoint.day + "/" + aPoint.month + "/" + aPoint.year ;
      String theArriveDate = (aPoint.CRSArrTime < aPoint.CRSDepTime ? aPoint.day+1 : aPoint.day) + "/" + aPoint.month + "/" + aPoint.year;
      textAlign(LEFT);
      
      fill(128);
      textSize(tR);
      text(theDepartDate , x ,y1+10*y);      
      
      fill(0);
      textSize(tR*1.25);
      text(convertTo24HourFormat(aPoint.CRSDepTime) +"     "+aPoint.origin , x , y1+15*y);
      fill(#2F67DE);
      text(eraseQuotation(aPoint.originCity), x , y2 + 15*y);
      
      textAlign(RIGHT);   //the other half
      
      fill(128);
      textSize(tR);
      text(theArriveDate, displayWidth/2 - x , y1+10*y);
      
      fill(0);
      textSize(tR*1.25);
      text(convertTo24HourFormat(aPoint.CRSArrTime) +"     "+aPoint.dest , displayWidth/2 - x, y1+15*y);
      fill(#2F67DE);
      text(eraseQuotation(aPoint.destCity),displayWidth/2-x, y2 + 15*y);
      
      pinOrigin.change(5*x,(displayHeight/2)*(1.618 - 1));                      //// Golden Ratio
      pinOrigin.dropPin();
      pinArrival.change(displayWidth/2 - 5*x, (displayHeight/2)*(1.618 - 1));   // Golden Ratio
      pinArrival.dropPin();
      airChina = new PlaneAnimate(pinOrigin.getX(),pinOrigin.getY(),pinArrival.getX(),pinArrival.getY(),planeImg);
      fly = true;
      pinOrigin.draw();
      pinArrival.draw();
      airChina.fly();
      color status;
      if(aPoint.cancelled || aPoint.diverted)          // cancelled or dead
      {
        status = (#B20407);       // dead red
      }
      else if(aPoint.CRSDepTime >= aPoint.depTime && aPoint.CRSArrTime >= aPoint.arrTime)  // !late 
      {
        status = (#21FF53);       //a healthy green
      }
      else                                   // delayed
      {
        status = (#F09941);        // an ominous organge
      }
      stroke(status);
      line(5*x,(displayHeight/2)*(1.618 - 1),displayWidth/2 - 5*x, (displayHeight/2)*(1.618 - 1));      //between the pins
      
      fill(status); 
      if(!aPoint.cancelled && !aPoint.diverted)
      {
      textAlign(LEFT);
      text(convertTo24HourFormat(aPoint.depTime)+" "+aPoint.origin,3*x,  50*y);
      textAlign(RIGHT);
      text(convertTo24HourFormat(aPoint.arrTime)+" "+aPoint.dest,displayWidth/2-3*x , 50*y);
      textAlign(CENTER,TOP);
              if(aPoint.CRSDepTime >= aPoint.depTime && aPoint.CRSArrTime >= aPoint.arrTime)
              {                
                text("On Time" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);                
              }
              else
              {
                text("Delayed" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);
              }
      }
      else if(aPoint.cancelled)
      {
         textAlign(CENTER,TOP);
         text("Cancelled" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x); 
      }
      else
      {
         textAlign(CENTER,TOP);
         text("Diverted" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*x);         
      }
      stroke(0);
      
}
String eraseQuotation (String aString)
{
        if (aString.length() >= 2 && aString.charAt(0) == '"' && aString.charAt(aString.length() - 1) == '"') {
            return aString.substring(1, aString.length() - 1);            // Return the string without the first and last characters (quotation marks)
        } else {
            return aString;
        }
}

String convertTo24HourFormat(int time) {
        // Extract hours and minutes from the integer
        int hours = time / 100;
        int minutes = time % 100;

        // Format hours and minutes as strings with leading zeros if necessary
        String hoursStr = String.format("%02d", hours);
        String minutesStr = String.format("%02d", minutes);

        // Concatenate hours and minutes with a colon separator
        String timeStr = hoursStr + ":" + minutesStr;

        return timeStr;
    }
