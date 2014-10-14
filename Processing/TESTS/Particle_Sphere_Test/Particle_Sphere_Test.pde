/*

 Particle Sphere Test
 
 Ryan Maksymic
 
 Created on September 26, 2014
 
 Modified on:
 * October 5, 2014
 * October 10, 2014
 * October 13, 2014
 * 
 
 References:
 * http://www.processing.org/tutorials/objects/
 * http://processing.org/examples/simpleparticlesystem.html
 * http://processing.org/examples/multipleparticlesystems.html
 * http://processing.org/examples/arrayobjects.html
 * http://en.wikipedia.org/wiki/Spherical_coordinate_system
 
 To do:
 * Set up verticle position levels
 * 
 
 */


Particle[] part;    // particle objects

Orb orb;    // orb object

int num = 600;    // number of particles in the system

color pCol = color(255, 155, 5);    // uncomment for orange colour
//color pCol = color(25, 255, 255);    // uncomment for blue colour

boolean moving = false;
//int moveIndex = num + 1;
int moveIndex = 1;    // enable for gradual change in motion upon key press


void setup()
{
  size(1200, 800, P3D);
  noCursor();

  part = new Particle[num];    // array of particles

  orb = new Orb();    // orb

    for (int i = 0; i < num; i++)
  {
    // enable for discrete vertical levels
    /*
    float thetaLevel = 0;
     
     if (i < num * 0.1)
     thetaLevel = PI * 0.1;
     else if (i < num * 0.2)
     thetaLevel = PI * 0.2;
     else if (i < num * 0.3)
     thetaLevel = PI * 0.3;
     else if (i < num * 0.4)
     thetaLevel = PI * 0.4;
     else if (i < num * 0.5)
     thetaLevel = PI * 0.5;
     else if (i < num * 0.6)
     thetaLevel = PI * 0.6;
     else if (i < num * 0.7)
     thetaLevel = PI * 0.7;
     else if (i < num * 0.8)
     thetaLevel = PI * 0.8;
     else
     thetaLevel = PI * 0.9;
     */


    //part[i] = new Particle(330, PI*random(0.02, 0.98), 2*PI*random(1));    // enable for random particle distribution

    // enable for wavy ring
    //float waveVal = 2*PI*random(1);
    //part[i] = new Particle(330, PI/2 + cos(10*waveVal)/20, waveVal);

    part[i] = new Particle(330, PI*random(0.49, 0.51), 2*PI*random(1));    // enable for particle belt

    //part[i] = new Particle(300, thetaLevel, 2*PI*random(1));    // enable for discrete vertical levels
  }
}


void draw()
{
  background(0);
  //lights();    // does this do anything?

  translate(width/2, height/2, 0);    // center the origin in the screen

  //orb.display();    // display orb

  for (int j = 0; j < num; j++)    // update and display each particle
  {
    //part[j].update(j);
    part[j].updateFalling(j);
    //part[j].updateSwirling(j);
    //part[j].updateWavy();

    part[j].display();
  }

  // enable for gradual change in motion upon key press
  if (moving == true)
    moveIndex += 4;    // adjusts rate of change

  camera(width/2.0, height*0.6, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);    // angle camera view upward
}

