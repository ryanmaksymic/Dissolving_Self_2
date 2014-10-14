/*

 Dissolving Self 1
 
 Created on April 4, 2013
 
 References:
 * http://www.openprocessing.org/sketch/10478
 * http://learning.codasign.com/index.php?title=Getting_Joint_Position_in_3D_Space_from_the_Kinect
 
 */

import processing.serial.*;
import SimpleOpenNI.*;

Serial myPort;

boolean performance = true;    // true = performance sketch runs; false = logo and credits run
int state = 1;    // state of the narrative

int num = 1;    // initial number of rings
int numLimit = 4;    // maximum number of rings for current state
int num_max = 100;    // maximum number of rings
Ellipse e[] = new Ellipse[num_max];    // array of ellipse instances

boolean flood = false;    // true = key is being pressed

int zoomOffset = -12400;    // camera zoom offset
int zoom = 1;    // total camera zoom
int zoomLimit = 7000;    // maximum zoom for current state

int gyroVal = 0;    // current gyroscope value
boolean gyroEn = false;    // true = enable gyroscope

SimpleOpenNI  context;    // Kinect vision
boolean trackEn = false;    // true = enable user tracking
boolean kinectEn = true;    // true = enable Kinect tracking; false = enable mouse tracking
boolean autoCalib = true;    // true = user is auto-calibrated
int userID = 1;    // user ID number
float userPos = 0;    // user position
float screenLeft = 0.3*width;    // user position multiplier
float screenRight = 0.7*width;    // user position multiplier

int endState = 1;    // 1 = logo; 2 = credits
PImage logo;
PImage credits;
float alpha1 = 0;    // logo alpha value
float alpha2 = 0;    // credits alpha value


void setup()
{
  size(1600, 1200, OPENGL);
  noFill();
  noCursor();
  smooth();

  for (int i = 0; i < num_max; i++)    // creat ellipse instances
  {
    e[i] = new Ellipse(width/2, height/2, 0, i);
  }

  // connect to XBee receiver via serial port:
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[6], 115200);
  myPort.bufferUntil('\n');

  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);

  logo = loadImage("DS_Logo.png");
  credits = loadImage("DS_Credits.png");
}


void draw()
{
  checkControls();    // check for key presses

    if (performance)
  {
    background(0);

    zoom = -zoomOffset - gyroVal;    // calculate camera zoom

    if (zoom == zoomLimit + 10)    // zoom max alert
    {
      println("Zoom maxed!");
    }
    if (zoom < zoomLimit)    // set zoom limits
    {
      zoom = zoomLimit;
    }

    if (num > numLimit)
    {
      num = numLimit;

      println("Rings maxed!");
    }

    //println("Number of rings: " + num);
    //println("Gyro vallue: " + gyroVal);
    //println("Zoom offset: " + zoomOffset);
    //println("Zoom level: " + zoom);
    //println("Zoom limit: " + zoomLimit);
    //println("User position " + userPos);

    camera(width/2.0, height/6.0, ((zoom)/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);    // set camera zoom

    context.update();    // retrieve Kinect data

    if (context.isTrackingSkeleton(userID))
    {
      headTrack(userID);    // track user's head
    }

    for (int i = 0; i < num; i++)    // draw ellipses
    {
      e[i].draw();
    }
  } else
  {
    background(0);
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);    // reset camera

    if (endState == 1)    // fade in to logo
    {
      alpha1++;
      if (alpha1 > 255)
      {
        alpha1 = 255;
      }
      tint(255, alpha1);
      image(logo, 0, 0);
    } else if (endState == 2)    // fade out of logo and in to credits
    {
      alpha1--;
      if (alpha1 < 1)
      {
        alpha1 = 0;
      }
      tint(255, alpha1);
      image(logo, 0, 0);

      if (alpha1 == 0)
      {
        alpha2++;
        if (alpha2 > 255)
        {
          alpha2 = 255;
        } 
        tint(255, alpha2);
        image(credits, 0, 0);
      }
    }
  }
}

