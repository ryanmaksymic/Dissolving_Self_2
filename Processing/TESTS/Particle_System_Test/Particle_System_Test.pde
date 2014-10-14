/*

 Particle System Test
 
 Ryan Maksymic
 
 Created on September 26, 2014
 
 Modified on:
 * October 5, 2014
 * October 10, 2014
 * 
 
 References:
 * http://www.processing.org/tutorials/objects/
 * http://processing.org/examples/simpleparticlesystem.html
 * http://processing.org/examples/multipleparticlesystems.html
 
 */


Particle[] part;
PVector[] vect;

int num = 100;

color pCol = color(255, 155, 5);    // uncomment this line for ORANGE
//color pCol = color(25, 255, 255);    // uncomment this line for BLUE


void setup()
{
  size(800, 800, P3D);
  stroke(255);
  strokeWeight(20);

  part = new Particle[num];
  vect = new PVector[num];

  for (int i = 0; i < num; i++)
  {
    vect[i] = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
    part[i] = new Particle();
  }
}


void draw()
{
  background(0);

  // the following lines give the particles a motion-blurred "tail":
  //  fill(0, 15);
  //  noStroke();
  //  rectMode(CORNERS);
  //  rect(0, 0, width, height);

  for (int j = 0; j < num; j++)
  {
    part[j].run(vect[j]);
  }

  //translate(width/2, height/2, 0);    // center the origin in the screen
}


// TO DO:
// - Create an array of Particle objects
// - Make the particle class take spherical coordinates (r, theta, phi)

class Particle
{
  color col;
  float x, y, z, xPrev, yPrev, zPrev;

  Particle()
  {
    col = pCol;
    x = random(width);
    y = random(height);
    z = random(-500, 200);
    xPrev = x;
    yPrev = y;
    zPrev = z;
  }

  Particle(color col_, float x_, float y_, float z_)
  {
    col = col_;
    x = x_;
    y = y_;
    z = z_;
    xPrev = x;
    yPrev = y;
    zPrev = z;
  }

  void run(PVector v)
  {
    update(v);
    display();
  }

  void update(PVector v)
  {
    xPrev = x;
    yPrev = y;
    zPrev = z;

    x += v.x; 
    y += v.y;
    z += v.z;

    wallCheck(x, y, z, v);
  }

  void wallCheck(float x, float y, float z, PVector v)
  {
    if (x >= width || x <= 0)
    {
      v.x = -v.x;
    }

    if (y >= height || y <= 0)
    {
      v.y = -v.y;
    }

    if (z >= 200 || z <= -500)
    {
      v.z = -v.z;
    }
  }

  void display()
  {
    strokeWeight(4);
    stroke(col, 255);
    point(x, y, z);

    strokeWeight(6);
    stroke(col, 70);
    point(xPrev, yPrev, zPrev);
    strokeWeight(7);
    stroke(col, 60);
    point(xPrev, yPrev, zPrev);

    strokeWeight(10);
    stroke(col, 25);
    point(xPrev, yPrev, zPrev);
    strokeWeight(12);
    stroke(col, 20);
    point(xPrev, yPrev, zPrev);
  }
}

