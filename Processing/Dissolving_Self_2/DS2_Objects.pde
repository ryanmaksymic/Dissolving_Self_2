// DS2 Objects


class Particle
{
  float size;    // particle's size
  PVector pos;    // particle's cartesian coordinate vector
  PVector posSphere;    // particle's spherical coordinate vector
  float radius;    // particle's radius location
  float rotSpeed;    // particle's rotation speed
  float swirlSpeed;    // particle's swirl speed
  PVector dest;    // cartesian coordinate vector for particle's destination
  PVector vel;    // particle's velocity vector
  color col;    // particle's color
  float alpha;    // particle's transparency


  Particle(float r_, float theta_, float phi_, color col_, float size_, float rotSpeed_)
  {
    //size = random(0.5, 8);    // set particle size range
    size = size_;

    radius = r_;

    posSphere = new PVector(r_, theta_, phi_);    // set spherical coordinates

    pos = new PVector(posSphere.x * sin(posSphere.y) * sin(posSphere.z), posSphere.x * cos(posSphere.y), posSphere.x * sin(posSphere.y) * cos(posSphere.z));    // calculate cartesian coords based on spherical coords

    //rotSpeed = random(0.1, 2.0);    // set rotation speed range
    rotSpeed = rotSpeed_;

    swirlSpeed = 0;

    dest = new PVector(0, 0, 0);    // initialize particle destinationu

    vel = new PVector(0, 0, 0);    // initialize particle velocity

    col = col_;    // set particle colour

    alpha = map(pos.z, -300, 300, 255, 50);    // more distant particles are more faint
  }


  void goTo(float tranSpeed_, float r_, float theta_)    // set new particle destination and transition speed
  {
    radius = r_;

    dest.set(r_, theta_, posSphere.z);    // set particle destination

    vel = PVector.sub(dest, posSphere);    // calculate required particle velocity
    vel.div(tranSpeed_);    // adjust transition speed
  }

  void goTo(float tranSpeed_, float r_, float theta_, float rotSpeed_, float swirlSpeed_)    // set new particle destination and transition speed
  {
    swirlSpeed = swirlSpeed_;

    rotSpeed = rotSpeed_;

    goTo(tranSpeed_, r_, theta_);
  }


  void update()    // update particle locations and draw particles
  {
    if (PVector.dist(dest, posSphere) < 0.01)    // if particle has arrived at destination
    {
      vel.set(0, 0, 0);    // zero velocity
    } else
    {
      posSphere.add(vel);    // update particle location
    }
  }


  void move(boolean gyroOn_, float somoVal_, float camXmod_)
  {
    posSphere.z += radians(rotSpeed);    // rotate current position
    dest.z += radians(rotSpeed);    // rotate destination

    if (swirlSpeed != 0)
    {
      posSphere.y += radians(swirlSpeed + abs(camXmod_)/2);
      dest.y += radians(swirlSpeed + abs(camXmod_)/2);
    }

    if (gyroOn_)
    {
      // SoMo influence: rotation speed
      posSphere.z += radians(somoVal_);
      dest.z += radians(somoVal_);

      // SoMo influence: radius
      float radMod = random(0.5, 3);
      posSphere.x += abs(somoVal_ * radMod);
      dest.x += abs(somoVal_ * radMod);

      // keep radius shrinking to limit
      if (posSphere.x > radius)
      {
        posSphere.x -= 4;
        dest.x -= 4;
      }
    }
  }


  void display(boolean fading_)
  {
    pos.set(posSphere.x * sin(posSphere.y) * sin(posSphere.z), posSphere.x * cos(posSphere.y), posSphere.x * sin(posSphere.y) * cos(posSphere.z));    // calculate cartesian coords based on spherical coords

    strokeWeight(size);    // set particle size /

    if (fading_)
      alpha -= 0.5;
    else
      alpha = map(pos.z, 200, -300, 255, 20);    // calculate particle transparency based on its distance

    stroke(col, alpha);    // set particle colour and transparency

    point(pos.x, pos.y, pos.z);    // draw particle
  }
}

