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
    for (int j = 0; j < numBall; j++)
    {
      part1[j].swirlSpeed = 0;    // stop group 1 swirl motion
    }
    break;

  case '5':    // ring mode
    mode = '5';
    println("Mode 5: Ring");
    break;

  case '6':    // shrink mode
    mode = '6';
    println("Mode 6: Shrink");
    //myPort.write('g');    // turn gyroscope off
    //gyroOn = false;
    radiusOn = false;
    println("Gyroscope: OFF");
    break;

  case '7':    // end mode
    mode = '7';
    println("Mode 7: End");
    fading = true;    // begin fading to black
    break;


  case 'r':    // toggle gyro-affected radius
    radiusOn = !radiusOn;
    println("Gyro-affected radius " + radiusOn);
    break;


    // SoMo commands
  case 'G':    // turn gyroscope on
    myPort.write('G');
    gyroOn = true;
    println("Gyroscope: ON");
    break;
  case 'g':    // turn gyroscope off
    myPort.write('g');
    gyroOn = false;
    println("Gyroscope: OFF");
    break;
  case 'E':    // turn EL wire on
    myPort.write('E');
    println("EL wire: ON");
    break;
  case 'e':    // turn EL wire off
    myPort.write('e');
    println("EL wire: OFF");
    break;
  case 'f':    // flicker EL wire
    myPort.write('f');
    println("EL wire: FLICKER");
    break;


    // images
  case 'Q':    // quote 1
    quote1On = !quote1On;
    println("Quote 1: " + quote1On);
    break;
  case 'q':    // quote 2
    quote2On = !quote2On;
    println("Quote 2: " + quote2On);
    break;
  case 'c':    // credits
    creditsAlpha = 0;
    creditsOn = !creditsOn;
    println("Credits: " + creditsOn);
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

    somoVal = float(inString);    // convert to float
  }
}

