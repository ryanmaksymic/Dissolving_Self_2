// DS2 Objects


class Particle
{
  color col;    // particle's color
  float size;    // particle's size
  float r, theta, phi;    // particle's spherical coordinates
  float x, y, z;    // particle's cartesian coordinates
  float xPrev, yPrev, zPrev;    // particle's cartesian coordinates in the last frame
  float phiDelta;    // particle's rotation speed
  float thetaDelta;    // particles vertical movement speed


  Particle(float r_, float theta_, float phi_)
  {
    col = pCol;
    // enable to make particles half-colour/half-white
    /*
    if (random(1) > 0.5)
     col = pCol;
     else
     col = color(255);
     */

    size = 6;

    r = r_;
    theta = theta_;
    phi = phi_;

    phiDelta = random(0.25, 0.75);    // randomly pick a rotation speed
    //phiDelta = 0.75;    // enable for coherent rotational movement

    thetaDelta = random(-0.7, 0.7);    // randomly pick a vertical movement speed
    //thetaDelta = 0.003;    // enable for coherent vertical movement

    // calculate cartesian coords based on spherical coords
    x = r * sin(theta) * sin(phi);
    y = r * cos(theta);
    z = r * sin(theta) * cos(phi);

    xPrev = x;
    yPrev = y;
    zPrev = z;
  }


  void update(int j_)    // update locations of particles
  {
    xPrev = x;
    yPrev = y;
    zPrev = z;

    phi += radians(phiDelta);    // rotate sphere

    x = r * sin(theta) * sin(phi);
    z = r * sin(theta) * cos(phi);
    y = r * cos(theta);
  }

  void updateSwirling(int j_)    // update locations of particles
  {
    xPrev = x;
    yPrev = y;
    zPrev = z;

    phi += radians(phiDelta);    // rotate sphere

    if (moving == true && j_ < moveIndex)    // theta value depends on moving condition
      theta += radians(thetaDelta);

    x = r * sin(theta) * sin(phi);
    z = r * sin(theta) * cos(phi);
    y = r * cos(theta);
  }

  void updateWavy()    // update locations of particles
  {
    xPrev = x;
    yPrev = y;
    zPrev = z;

    phi += radians(phiDelta);    // rotate sphere

    if (theta > PI * 0.52)
      thetaDelta *= -1;
    if (theta < PI * 0.48)
      thetaDelta *= -1;

    theta += thetaDelta;

    x = r * sin(theta) * sin(phi);
    z = r * sin(theta) * cos(phi);
    y = r * cos(theta);
  }

  void updateFalling(int j_)    // update locations of particles
  {
    xPrev = x;
    yPrev = y;
    zPrev = z;

    phi += radians(phiDelta);    // rotate sphere

    x = r * sin(theta) * sin(phi);
    z = r * sin(theta) * cos(phi);

    if (moving == true && j_ < moveIndex)    // y value depends on moving condition
      y += 2;
    else
      y = r * cos(theta);
  }

  void display()    // display a particle in its current position; display its glow in its previous position
  {
    strokeWeight(size);
    stroke(col, 255);
    point(x, y, z);

    strokeWeight(size * 1.5);
    stroke(col, 70);
    point(xPrev, yPrev, zPrev);
    strokeWeight(size * 1.6);
    stroke(col, 60);
    point(xPrev, yPrev, zPrev);

    strokeWeight(size * 2);
    stroke(col, 25);
    point(xPrev, yPrev, zPrev);
    strokeWeight(size * 2.2);
    stroke(col, 20);
    point(xPrev, yPrev, zPrev);
  }
}


class Orb
{
  color col;    // orb's color
  float size;    // orb's size
  float x, y, z;    // orb's cartesian coordinates
  float xPrev, yPrev, zPrev;    // orb's cartesian coordinates in the last frame


  Orb()
  {
    col = color(250);

    size = 210;

    x = 0;
    y = 0;
    z = 0;

    xPrev = x;
    yPrev = y;
    zPrev = z;
  }


  void display()    // display an orb in its current position; display its glow in its previous position
  {
    strokeWeight(size);
    stroke(col, 255);
    point(x, y, z);

    strokeWeight(size * 1.2);
    stroke(col, 70);
    point(xPrev, yPrev, zPrev);
    strokeWeight(size * 1.25);
    stroke(col, 60);
    point(xPrev, yPrev, zPrev);

    strokeWeight(size * 1.4);
    stroke(col, 25);
    point(xPrev, yPrev, zPrev);
    strokeWeight(size * 1.5);
    stroke(col, 20);
    point(xPrev, yPrev, zPrev);
  }
}

