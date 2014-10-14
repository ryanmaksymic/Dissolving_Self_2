// Ellipse Object

class Ellipse
{
  float x, y, z;
  PVector rot;
  int id;
  float dens = .1;    // density of rings
  float r = 200.0;    // radius of sphere

  float rate = 50.0;
  float speed = 0.05;
  int segno;

  Ellipse(float _x, float _y, float _z, int _id)
  {
    x=_x;
    y=_y;
    z=_z;
    id=_id;
    segno = (int)random(40);

    rot = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
  }

  void follow()
  {
    if (kinectEn == true)    // if Kinect tracking enabled
    {
      x += (userPos - x)/(20.0);
    }
    else if (kinectEn == false)    // if mouse tracking enabled
    {
      x += (mouseX - x)/(20.0);
    }
  }

  void draw()
  {
    if (trackEn)    // if user tracking enabled
    {
      follow();
    }
    else    // otherwise
    {
      x = (width/2);    // center the sphere
    }

    rot.add(
    noise((id+frameCount)/rate)*speed, 
    noise((id+34.0+frameCount)/rate)*speed, 
    noise((id+409.0+frameCount)/rate)*speed
      );

    pushMatrix();
    translate(x, y, z);

    pushMatrix();
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);

    int cnt = 0;

    beginShape();
    for (float f = -PI; f<PI; f+=dens)
    {
      float X = cos(f)*r;
      float Y = sin(f)*r;

      if (abs(cnt-segno) < 5)
      {
        stroke(#ffdddd, map(modelZ(X, Y, 0), -r, r, 1, 180 - abs(cnt-segno)*30));
      }
      else
      {
        stroke(#ffffff, map(modelZ(X, Y, 0), -r, r, 1, 60));
      }

      strokeWeight(map(modelZ(X, Y, 0), -r, r, 5, 1.8));

      vertex(X, Y, 0);
      cnt++;
    }

    endShape(CLOSE);

    if (frameCount%2 == 0)
    {
      segno++;
    }
    if (segno >= cnt)
    {
      segno=0;
    }

    popMatrix();
    popMatrix();
  }
}

