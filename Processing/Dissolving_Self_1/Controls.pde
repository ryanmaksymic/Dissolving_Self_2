// Controls

void checkControls()
{
  if (keyPressed)
  {
    if (key == '1' && flood == false)    // narrative state 1
    {
      state = 1;

      zoomOffset = -12400;    // sphere is lost in the distance
      numLimit = 4;    // max 4 rings
      trackEn = false;    // user tracking disabled
      gyroEn = false;    // gyroscope disabled
      zoomLimit = 7000;    // sphere remains small

      println("State 1");
    }
    if (key == '2' && flood == false)    // narrative state 2
    {
      state = 2;

      zoomOffset = -7000;    // sphere is smallest
      numLimit = 16;    // max 16 rings
      trackEn = false;    // user tracking disabled
      gyroEn = false;    // gyroscope disabled
      zoomLimit = 3000;    // sphere grows slightly

      println("State 2");
    }
    if (key == '3' && flood == false)    // narrative state 3
    {
      state = 3;

      zoomOffset = -3000;    // sphere is larger
      numLimit = 32;    // max 32 rings
      trackEn = true;    // user tracking enabled
      gyroEn = false;    // gyroscope disabled
      zoomLimit = 1500;    // sphere grows slightly

      println("State 3");
    }
    if (key == '4' && flood == false)    // narrative state 4
    {
      state = 4;

      zoomOffset = -1500;    // sphere is larger
      numLimit = 64;    // max 64 rings
      trackEn = true;    // user tracking enabled
      gyroEn = false;    // gyroscope disabled
      zoomLimit = 1500;    // sphere remains same size

      println("State 4");
    }
    if (key == '5' && flood == false)    // narrative state 5
    {
      state = 5;

      zoomOffset = -1500;    // sphere is larger
      numLimit = 64;    // max 64 rings
      trackEn = true;    // user tracking enabled
      gyroEn = true;    // gyroscope enabled
      zoomLimit = 500;    // sphere can grow large

      println("State 5");
    }
    if (key == '6' && flood == false)    // narrative state 6
    {
      state = 6;

      zoomOffset = -1500;    // sphere is larger
      numLimit = 100;    // max 100 rings
      trackEn = false;    // user tracking enabled
      gyroEn = true;    // gyroscope enabled
      zoomLimit = 500;    // variable in this section

      println("State 6");
    }
    if (key == '7' && flood == false)    // narrative state 7
    {
      state = 7;

      zoomOffset = -1;    // sphere is max size
      numLimit = 100;    // max 100 rings
      trackEn = false;    // user tracking disabled
      gyroEn = false;    // gyroscope disabled
      zoomLimit = 1;    // sphere is max size

      println("State 7");
    }


    if (key == 'l' && flood == false)    // display logo
    {
      println("Logo");
      performance = false;
      endState = 1;
    }
    if (key == 'c' && flood == false)    // display credits
    {
      println("Credits");
      performance = false;
      endState = 2;
    }
    if (key == '0' && flood == false)    // return to performance
    {
      println("Performance");
      performance = true;
    }


    if (key == '[')    // zoom out camera
    {
      zoomOffset = zoomOffset - 10;
    }
    if (key == '{')    // zoom out camera quickly
    {
      zoomOffset = zoomOffset - 50;
    }
    if (key == ']')    // zoom in camera
    {
      if (state == 6)    // if in state 6
      {
        zoomLimit = zoomLimit - 2;    // increase zoom limit

        if (zoomLimit < 1)    // set zoom limit limits
        {
          zoomLimit = 1;
        }
      }
      else    // otherwise
      {
        zoomOffset = zoomOffset + 10;    // increase zoom

        if (zoomOffset > -zoomLimit)    // set zoom offset limits
        {
          zoomOffset = -zoomLimit;
        }
      }
    }


    if (key == '-' && flood == false)    // remove rings
    {
      num--;

      if (num < 0)    // set limit
      {
        num = 0;
      }
    }
    if (key == '=' && flood == false)    // add rings
    {
      num++;

      if (num > num_max)    // set limit
      {
        num = num_max;
      }
    }


    if (key == 'k' && flood == false)    // enable/disable Kinect tracking
    {
      if (kinectEn == true)
      {
        kinectEn = false;

        println("Kinect disabled");
      }
      else if (kinectEn == false)
      {
        kinectEn = true;

        println("Kinect enabled");
      }
    }
    if (key == '.' && flood == false)    // next Kinect user
    {
      userID++;

      if (userID > 10)    // set limit
      {
        userID = 10;
      }

      println("Kinect user ID: " + userID);
    }
    if (key == ',' && flood == false)    // previous Kinect user
    {
      userID--;

      if (userID < 1)    // set limit
      {
        userID = 1;
      }

      println("Kinect user ID: " + userID);
    }


    if (key == 'g' && flood == false)    // enable/disable gyroscope
    {
      if (gyroEn == true)
      {
        gyroEn = false;

        println("Gyroscope disabled");
      }
      else if (gyroEn == false)
      {
        gyroEn = true;

        println("Gyroscope enabled");
      }
    }


    flood = true;    // key is being pressed
  }

  if (keyPressed == false)    // no key is being pressed
  {
    flood = false;
  }
}

