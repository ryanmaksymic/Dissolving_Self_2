/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/130660*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/*
Katie Manduca
 
 make a sphere of points
 radius dependent on mouse location
 */

int numDivisions = 30;
float rotateVal = 0;
int dotAlpha = 255;
//float angle_1 = TWO_PI / numDivisions;
float angle_1 = radians(1);
float angle_2 = TWO_PI / numDivisions;
int radius = 300;


void setup()
{
  size(800, 800, P3D);
  stroke(255);
  strokeWeight(12);
}


void draw()
{
  background(0);
  translate(width/2, height/2, 0);    // center the shape in the canvas

  rotateY(rotateVal);    // rotate shape about Y-axis
  
  dotAlpha = 255;

  for (int j = 0; j < numDivisions*12; j++)
  {
    rotateY(-angle_1);

    stroke(255, 255, 255, dotAlpha);

    for (int i = -numDivisions/4; i < numDivisions/4; i++)
    {
      float x1 = cos(angle_2 * i) * radius;
      float y1 = sin(angle_2 * i) * radius;

      //stroke(angle*i, 100, 100);
      point(x1, y1, 0);
    }
    
    dotAlpha -= 1;
  }

  //angle_1 = angle_1 + radians(0.01);

  rotateVal += radians(2);    // update rotation value
}

