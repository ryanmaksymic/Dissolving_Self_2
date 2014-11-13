/*

 Dissolving Self 2
 
 Ryan Maksymic
 
 Created on September 26, 2014
 
 References:
 * http://www.processing.org/tutorials/objects/
 * http://processing.org/examples/simpleparticlesystem.htmlc
 * http://processing.org/examples/multipleparticlesystems.html
 * http://processing.org/examples/arrayobjects.html
 * http://en.wikipedia.org/wiki/Spherical_coordinate_system
 
 */


// open serial communication
import processing.serial.*;
Serial myPort;

int numSky = 300;    // number of group 0 particles
int numBall = 1000;    // number of group 1 & 2 particles

Particle[] part0, part1, part2;    // particle groups 0, 1, & 2

//color col2 = color(0, 255, 200);    // group 2 colour: blue
color col2 = color(255, 155, 5);    // group 2 colour: orange

char mode = ' ';    // particle orientation mode

int colourIndex = -1;    // how many colour particles have been introduced

boolean gyroOn = false;    // true = receiving SoMo gyroscope data

int radius0 = 400;    // group 0 sphere radius
int radius1 = 100;    // group 1 sphere radius
int radius2 = 150;    // group 2 sphere radius

float somoVal = 0;    // gyroscope data from SoMo

boolean radiusOn = true;    // true = gyro affects radius

float camX, camY;    // camera focal point
char camDest = 'C';    // L, R, C, U, or D

// camera focal point movement velocities
float camXmod = 0;
float camYmod = 0;

boolean fading = false;    // true = screen is fading to black

PImage quote1;
PImage quote2;
PImage credits;

boolean quote1On = false;
boolean quote2On = false;
boolean creditsOn = false;    // true = credits are displayed

float quote1Alpha = 0;
float quote2Alpha = 0;
float creditsAlpha = 0;


void setup()
{
  //size(1500, 900, P3D);    // laptop size
  size(1600, 900, P3D);    // projector size

  noCursor();    // hide mouse

  // set initial camera focal point
  camX = width/2;
  camY = height*0.45;

  part0 = new Particle[numSky];    // particle group 0
  part1 = new Particle[numBall];    // particle group 1
  part2 = new Particle[numBall];    // particle group 2

  // Particle(radius, theta, phi, colour, size, rotSpeed)

  for (int i = 0; i < numSky; i++)    // create group 0 particles
  {
    part0[i] = new Particle(600, PI, 2*PI*random(1), 255, random(0.1, 2), random(-0.01, 0.01));    // offscreen - group 0
  }

  for (int i = 0; i < numBall; i++)    // create group 1 & 2 particles
  {
    part1[i] = new Particle(600, PI, 2*PI*random(1), 255, random(0.2, 4), random(-0.01, 0.01));    // offscreen  - group 1
    part2[i] = new Particle(600, 0, 2*PI*random(1), col2, random(0.4, 7), random(-1.5, 1.5));    // offscreen - group 2
  }

  // set up serial communication
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[7], 9600);
  myPort.bufferUntil('\n');

  credits = loadImage("credits.png");    // load credits image /
  quote1 = loadImage("quote1.png");
  quote2 = loadImage("quote2.png");

  imageMode(CENTER);

  println("Setup complete");
}


void draw()
{
  background(0);

  translate(width/2, height/2, 0);    // center the origin


  // SET PARTICLE ORIENTATIONS

  switch(mode)    // change in particle orientation depends on current mode
  {
    // goTo(tranSpeed, radius, theta)
    // goTo(tranSpeed, radius, theta, rotSpeed, swirlSpeed)

    // offscreen mode
  case '0':
    for (int j = 0; j < numSky; j++)    // create group 0 particles
    {
      part0[j].goTo(1, 600, PI, random(-0.01, 0.01), 0);    // offscreen - group 0
    }
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(1, 600, PI, random(-0.01, 0.01), 0);    // offscreen - group 1
      part2[j].goTo(1, 600, 0, random(-1.5, 1.5), 0);    // offscreen - group 2
    }
    mode = ' ';
    break;

    // universe mode
  case '1':
    for (int j = 0; j < numSky; j++)
    {
      part0[j].goTo(2000, random(200, 1000), PI*random(1));    // universe - group 0
    }
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(2000, random(60, 1000), PI*random(1));    // universe - group 1
    }
    mode = ' ';
    break;

    // ball mode
  case '2':
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(250, random(10, radius1), PI*random(0.02, 0.98), random(-1, 1), random(1));    // ball - group 1
    }
    mode = ' ';
    break;

    // colour mode
  case '3':
    int colourDiv = 15;    // number of group 2 particle groups
    if (colourIndex < colourDiv)    // if there are group 2 particles still hidden
    {
      for (int j = colourIndex*800/colourDiv; j < (colourIndex + 1)*800/colourDiv; j++)
      {
        part2[j].goTo(130, radius2, PI*random(0.02, 0.98));    // shell - group 2
        //part2[j].goTo(150, 0, PI);
      }
      mode = ' ';

      println("      (" + (colourIndex + 1) + "/" + colourDiv + ")");    // print group 2 release progress
    }
    break;

    // shell mode
  case '4':
    for (int j = 0; j < numBall; j++)
    {
      //part1[j].goTo(200, random(10, radius1), PI*random(0.02, 0.98), random(-1, 1), 0);    // shell - group 1
      part2[j].goTo(300, random(radius2, radius2+10), PI*random(0.02, 0.98));    // shell - group 2
    }
    mode = ' ';
    break;

    // ring mode
  case '5':
    for (int j = 0; j < numBall; j++)
    {
      // disk - group 1 & 2
      part1[j].goTo(500, random(10, radius1), PI*random(0.49, 0.51));
      part2[j].goTo(400, random(radius1, radius2), PI*random(0.49, 0.51));
    }
    mode = ' ';
    break;

    // shrink mode
  case '6':
    for (int j = 0; j < numBall; j++)
    {
      // shrink - group 1 & 2
      part1[j].goTo(600, 1, PI*random(0.49, 0.51));
      part2[j].goTo(600, 1, PI*random(0.49, 0.51));
    }
    mode = ' ';
    break;
  }


  // DRAW PARTICLES

  // move(gyroOn, somoVal, camXmod, radiusOn)

  for (int j = 0; j < numSky; j++)    // draw group 0 particles
  {
    part0[j].update();
    part0[j].move(false, 0, 0, false);    // no gyro influence
    part0[j].display(fading);
  }

  for (int j = 0; j < numBall; j++)    // draw group 1 & 2 particles
  {
    part1[j].update();
    part1[j].move(gyroOn, somoVal/450, camXmod, false);    // gyro influence: rotation
    part1[j].display(fading);

    part2[j].update();
    part2[j].move(gyroOn, somoVal/300, camXmod, radiusOn);    // gyro influence: rotation, radius
    part2[j].display(fading);
  }


  // CAMERA

  float camSpeed = 0.5;    // speed of camera movement

  // adjust camera focal point movement velocities
  if (camDest == 'L')
    camXmod = map(camX, width/2, 0.6*width, camSpeed, 0);
  if (camDest == 'R')
    camXmod = map(camX, width/2, 0.4*width, -camSpeed, 0);
  if (camDest == 'C')
    camXmod = map(camX, 0.4*width, 0.6*width, camSpeed, -camSpeed);
  if (camDest == 'D')
    camYmod = map(camY, height*0.45, height*0.3, -0.5, 0);
  if (camDest == 'U')
    camYmod = map(camY, height*0.3, height*0.45, 0.5, 0);

  // update camera focal point movement velocities
  camX += camXmod;
  camY += camYmod;

  camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), camX, camY, 0, 0, 1, 0);    // key-controlled camera
  //camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), width - mouseX, height - mouseY, 0, 0, 1, 0);    // mouse-controlled camera
  //camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height*0.65, 0, 0, 1, 0);    // standard camera


  // IMAGES

  if (quote2On)
  {
    image(quote2, width/2, height*0.5, width*0.6, height*0.6);    // display image
  }

  if (quote1On)
  {
    image(quote1, width/2, height*0.5, width*0.6, height*0.6);    // display image
  }

  if (creditsOn)
  {
    tint(255, creditsAlpha);    // update image transparency

    image(credits, width/2, height*0.5, width*0.67, height*0.67);    // display image

    creditsAlpha++;
  }
}

