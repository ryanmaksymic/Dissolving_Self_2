// DS2 Functions


void serialEvent(Serial myPort)
{
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null)
  {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    float inByte = float(inString);
    inByte = map(inByte, 0, 1023, -2, 2);
    inByte = abs(inByte);
    //println(inByte);

    speed = inByte;
  }
}


void keyPressed()
{
  //moving = true;    // turn on moving condition

  if (key == 'h')
  {
    myPort.write('H');
  } else if (key == 'l')
  {
    myPort.write('L');
  }
}

