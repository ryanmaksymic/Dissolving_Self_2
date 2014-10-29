/*

 Dissolving Self 2
 
 Ryan Maksymic
 
 Created on September 26, 2014
 
 References:
 * http://www.processing.org/tutorials/objects/
 * http://processing.org/examples/simpleparticlesystem.html
 * http://processing.org/examples/multipleparticlesystems.html
 * http://processing.org/examples/arrayobjects.html
 * http://en.wikipedia.org/wiki/Spherical_coordinate_system
 
 To do:
 * Overall:
 - Add shooting stars (?)
 * Curiosity:
 - Add pulsating radii (?)
 * Interplay:
 - Quick EL wire flicker with each quick spin (?)
 - Shooting stars with each lateral movement (?)
 * Embrace:
 - 
 
 */


// open serial communication
import processing.serial.*;
Serial myPort;

// connect syphon
import codeanticode.syphon.*;
SyphonServer server;

int numSky = 300;    // number of group 0 particles
int numBall = 1000;    // number of group 1 & 2 particles

Particle[] part0, part1, part2;    // particle groups 0, 1, & 2

color col2 = color(0, 255, 200);    // group 2 colour: blue
//color col2 = color(255, 155, 5);    // group 2 colour: orange

char mode = ' ';    // particle orientation mode

int colourIndex = -1;    // how many colour particles have been introduced

boolean gyroOn = false;    // true = receiving SoMo gyroscope data

int radius0 = 600;    // group 0 sphere radius
int radius1 = 150;    // group 1 sphere radius
int radius2 = 300;    // group 2 sphere radius

float somoVal = 0;    // gyroscope data from SoMo

float camX, camY;    // camera focal point
char camDest = 'C';    // L, R, C, U, or D

// camera focal point movement velocities
float camXmod = 0;
float camYmod = 0;

boolean fading = false;


void setup()
{
  size(1500, 900, P3D);    // laptop size
  //size(1900, 1200, P3D);    // projector size (?)

  noCursor();    // hide mouse

  // set camera focal point
  camX = width/2;
  camY = height/2;

  part0 = new Particle[numSky];    // particle group 0
  part1 = new Particle[numBall];    // particle group 1
  part2 = new Particle[numBall];    // particle group 2

  // Particle(radius, theta, phi, colour, size, rotSpeed)

  for (int i = 0; i < numSky; i++)    // create group 0 particles
  {
    part0[i] = new Particle(600, PI, 2*PI*random(1), 255, random(0.1, 3), random(-0.02, 0.02));    // offscreen - group 0
  }

  for (int i = 0; i < numBall; i++)    // create group 1 & 2 particles
  {
    part1[i] = new Particle(600, PI, 2*PI*random(1), 255, random(0.3, 5), random(-0.02, 0.02));    // offscreen  - group 1
    part2[i] = new Particle(600, 0, 2*PI*random(1), col2, random(0.8, 8), random(-3, 3));    // offscreen - group 2
  }

  // set up serial communication
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[7], 9600);
  myPort.bufferUntil('\n');

  //server = new SyphonServer(this, "Processing Syphon");    // create syphon server

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
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(1, 600, PI, random(-0.02, 0.02), 0);
      part2[j].goTo(1, 600, 0, random(-3, 3), 0);    // offscreen - group 2
    }
    mode = ' ';
    break;

    // universe mode
  case '1':
    for (int j = 0; j < numSky; j++)
    {
      part0[j].goTo(400, random(400, 800), PI*random(1));    // universe - group 0
    }
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(400, random(60, 2000), PI*random(1));    // universe - group 1
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
    int colourDiv = 3;    // number of group 2 particle groups
    if (colourIndex < colourDiv)    // if there are group 2 particles still hidden
    {
      for (int j = colourIndex*90/colourDiv; j < (colourIndex + 1)*90/colourDiv; j++)
      {
        part2[j].goTo(100, radius2*1.25, PI*random(0.02, 0.98));    // shell - group 2
      }
      mode = ' ';

      println("      (" + (colourIndex + 1) + "/" + colourDiv + ")");    // print group 2 release progress
    }
    break;

    // shell mode
  case '4':
    for (int j = 0; j < numBall; j++)
    {
      part1[j].goTo(200, random(10, radius1), PI*random(0.02, 0.98), random(-1, 1), 0);    // shell - group 1
      part2[j].goTo(200, random(radius2, radius2+10), PI*random(0.02, 0.98));    // shell - group 2
    }
    mode = ' ';
    break;

    // ring mode
  case '5':
    for (int j = 0; j < numBall; j++)
    {
      // ring - group 1 & 2
      part1[j].goTo(150, random(radius1, radius1+10), PI*random(0.49, 0.51), random(-1, 1), 0);
      part2[j].goTo(150, random(radius2, radius2+10), PI*random(0.49, 0.51));
    }
    mode = ' ';
    break;

    // shrink mode
  case '6':
    for (int j = 0; j < numBall; j++)
    {
      // shrink - group 1 & 2
      part1[j].goTo(50, 0, PI*random(0.49, 0.51));
      part2[j].goTo(50, 0, PI*random(0.49, 0.51));
    }
    mode = ' ';
    break;
  }


  // DRAW PARTICLES

  // move(gyroOn, somoVal, camXmod)

  for (int j = 0; j < numSky; j++)    // draw group 0 particles
  {
    part0[j].update();
    part0[j].move(false, 0, 0);
    part0[j].display(fading);
  }

  for (int j = 0; j < numBall; j++)    // draw group 1 & 2 particles
  {
    part1[j].update();
    part1[j].move(gyroOn, somoVal/450, camXmod);
    part1[j].display(fading);

    part2[j].update();
    part2[j].move(gyroOn, somoVal/300, camXmod);
    part2[j].display(fading);
  }


  // CAMERA

  // adjust camera focal point movement velocities
  if (camDest == 'L')
    camXmod = map(camX, width/2, 0.75*width, 8, 0);
  if (camDest == 'R')
    camXmod = map(camX, width/2, 0.25*width, -8, 0);
  if (camDest == 'C')
    camXmod = map(camX, 0.25*width, 0.75*width, 8, -8);
  if (camDest == 'D')
    camYmod = map(camY, height*0.65, height/2, -1, 0);
  if (camDest == 'U')
    camYmod = map(camY, height/2, height*0.65, 1, 0);

  // update camera focal point movement velocities
  camX += camXmod;
  camY += camYmod;

  camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), camX, camY, 0, 0, 1, 0);    // key-controlled camera
  //camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), width - mouseX, height - mouseY, 0, 0, 1, 0);    // mouse-controlled camera
  //camera(width/2.0, height*0.7, (height/2.0) / tan(PI*30.0 / 180.0), width/2, height*0.65, 0, 0, 1, 0);    // standard camera


  //server.sendScreen();    // send frame to syphon
}

