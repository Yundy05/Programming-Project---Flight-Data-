

void printIndividualData(DataPoint aPoint)
{
      //originBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/3   Reminder of coordinates  Do Not uncomment
      //departBtn = Button(MARGIN, MARGIN+ 2*(displayHeight)/4   
      float buttonH = (displayHeight - 100)/20;
      int m = 5;    // adjust stroke position to have a nicer look
      int LM = 30;       //leftMargin for displaying texts
      float y2 = 2*(displayHeight)/3 + m;
      float y3 = 2*(displayHeight)/3 + 4 * buttonH;
      float y1 = (displayHeight)/2 + m;                   //first line counting from north to south
      stroke(128);
      line(1,  y2 , displayWidth/2 , 2*(displayHeight)/3 + m);
      line(1,  y3 , displayWidth/2 , 2*(displayHeight)/3 + 4 * buttonH);
      line(1,  y1 , displayWidth/2 , (displayHeight)/2  + m);
      String theDepartDate = aPoint.day + "/" + aPoint.month + "/" + aPoint.year ;
      String theArriveDate = (aPoint.CRSArrTime < aPoint.CRSDepTime ? aPoint.day+1 : aPoint.day) + "/" + aPoint.month + "/" + aPoint.year;
      textAlign(LEFT);
      
      fill(128);
      textSize(40);
      text(theDepartDate , LM ,y1+displayWidth/20);      
      
      fill(255);
      textSize(50);
      text(convertTo24HourFormat(aPoint.CRSDepTime) +"     "+aPoint.origin , LM , y1+displayWidth/12);
      fill(#2F67DE);
      text(eraseQuotation(aPoint.originCity),LM, y2 + displayWidth/12);
      
      textAlign(RIGHT);   //the other half
      
      fill(128);
      textSize(40);
      text(theArriveDate, displayWidth/2 - LM , y1+displayWidth/20);
      
      fill(255);
      textSize(50);
      text(convertTo24HourFormat(aPoint.CRSArrTime) +"     "+aPoint.dest , displayWidth/2 - LM, y1+displayWidth/12);
      fill(#2F67DE);
      text(eraseQuotation(aPoint.destCity),displayWidth/2-LM, y2 + displayWidth/12);
      
      pinOrigin.change(5*LM,(displayHeight/2)*(1.618 - 1));                      //// Golden Ratio
      pinOrigin.dropPin();
      pinArrival.change(displayWidth/2 - 5*LM, (displayHeight/2)*(1.618 - 1));   // Golden Ratio
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
      line(5*LM,(displayHeight/2)*(1.618 - 1),displayWidth/2 - 5*LM, (displayHeight/2)*(1.618 - 1));      //between the pins
      
      fill(status); 
      if(!aPoint.cancelled && !aPoint.diverted)
      {
      textAlign(LEFT);
      text(convertTo24HourFormat(aPoint.depTime)+" "+aPoint.origin,3*LM,  displayHeight/2.5);
      textAlign(RIGHT);
      text(convertTo24HourFormat(aPoint.arrTime)+" "+aPoint.dest,displayWidth/2-3*LM , displayHeight/2.5);
      textAlign(CENTER,TOP);
              if(aPoint.CRSDepTime >= aPoint.depTime && aPoint.CRSArrTime >= aPoint.arrTime)
              {                
                text("On Time" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*LM);                
              }
              else
              {
                text("Delayed" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*LM);
              }
      }
      else if(aPoint.cancelled)
      {
         textAlign(CENTER,TOP);
         text("Cancelled" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*LM); 
      }
      else
      {
         textAlign(CENTER,TOP);
         text("Diverted" ,displayWidth/4, (displayHeight/2)*(1.618 - 1) + 2*LM);         
      }
      
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
