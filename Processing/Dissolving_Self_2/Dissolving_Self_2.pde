/*

 Dissolving Self 2
 
 Ryan Maksymic
 
 Created on September 26, 2014
 
 Modified on:
 * October 5, 2014
 * 
 
 References:
 * http://www.processing.org/tutorials/objects/
 * http://processing.org/examples/simpleparticlesystem.html
 * http://processing.org/examples/multipleparticlesystems.html
 
 */

Particle[] parts;

int count = 50;


void setup()
{
  size(800, 800, P3D);
  stroke(255);
  strokeWeight(20);
}


void draw()
{
  //background(100);

  // the following lines give the particles a motion-blurred "tail":
  fill(0, 15);
  noStroke();
  rectMode(CORNERS);
  rect(0, 0, width, height);

  translate(width/2, height/2, 0);    // center the origin in the screen
}


// TO DO:
// - Create an array of Particle objects
// - Make the particle class take spherical coordinates (r, theta, phi)

class Particle
{
  color col;      // colour
  int x;          // x position
  int y;          // y position
  int z;          // z position

  Particle(color col_, int x_, int y_, int z_)
  {
    col = col_;
    x = x_;
    y = y_;
    z = z_;
  }

  void run()
  {
    update();
    display();
  }

  void update()
  {
    x++;
    y++;
    z++;
  }

  void display()
  {
    stroke(col);
    point(x, y, z);
  }
}

