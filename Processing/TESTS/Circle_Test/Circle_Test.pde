float rotateVal = 0;
float rotateMod = 0;
float zMod = 0;


void setup()
{
  size(600, 600, P3D);

  background(0);
  stroke(255);
  strokeWeight(4);
  noFill();
  smooth();
}


void draw()
{
  background(0);

  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);    // default camera() values
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0) + zMod, width/2.0, height/2.0, 0, 0, 1, 0);

  translate(width/2, height/2);    // move origin to center of screen

  rotateY(rotateVal);    // rotate shape about Y-axis

  ellipse(0, 0, 200, 200);    // draw circle

  rotateVal = rotateVal + radians(rotateMod);    // update rotation value
}


void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)    // change speed of rotation
    {
      rotateMod += 2;
    } else if (keyCode == RIGHT)    // change speed of rotation
    {
      rotateMod -= 2;
    } else if (keyCode == UP)    // zoom in
    {
      zMod -= 10;
    } else if (keyCode == DOWN)    // zoom out
    {
      zMod += 10;
    }
  }
}

