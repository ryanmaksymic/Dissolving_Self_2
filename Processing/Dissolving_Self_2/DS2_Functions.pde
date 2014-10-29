// DS2 Functions


void keyPressed()
{
  switch(key)
  {
    // particle orientations

  case '0':    // reset
    mode = '0';
    println("Mode 0: Offscreen");
    colourIndex = -1;    // reset colourIndex for Mode 3
    fading = false;
    break;

  case '1':    // universe mode
    mode = '1';
    println("Mode 1: Universe");
    break;

  case '2':    // ball mode
    mode = '2';
    println("Mode 2: Ball");
    break;

  case '3':    // colour mode
    mode = '3';
    println("Mode 3: Colour");
    colourIndex++;    // increment colourIndex
    break;

  case '4':    // shell mode
    mode = '4';
    println("Mode 4: Shell");
    //radius1 = radius2;    // increase radius limit - white
    break;

  case '5':    // ring mode
    mode = '5';
    println("Mode 5: Ring");
    break;

  case '6':    // shrink mode
    mode = '6';
    println("Mode 6: Shrink");
    break;

  case '7':    // end mode
    mode = '7';
    println("Mode 7: End");
    fading = true;
    break;


    // SoMo commands
  case 'g':    // turn gyroscope on
    myPort.write('g');
    gyroOn = true;
    println("Gyroscope: ON");
    break;
  case 'f':    // turn gyroscope off
    myPort.write('f');
    gyroOn = false;
    println("Gyroscope: OFF");
    break;
  case 'h':    // turn EL wire on
    myPort.write('h');
    println("EL wire: ON");
    break;
  case 'l':    // turn EL wire off
    myPort.write('l');
    println("EL wire: OFF");
    break;
  }


  // keyed camera control
  if (key == CODED)
  {
    // set camera destination based on key input
    if (keyCode == LEFT)
      camDest = 'L';
    if (keyCode == RIGHT)
      camDest = 'R';
    if (keyCode == SHIFT)
      camDest = 'C';
    if (keyCode == UP)
      camDest = 'U';
    if (keyCode == DOWN)
      camDest = 'D';
  }
}


void serialEvent(Serial myPort)
{
  String inString = myPort.readStringUntil('\n');    // get the ASCII string

  if (inString != null)
  {
    inString = trim(inString);    // trim off any whitespace

    somoVal = float(inString);
  }
}

