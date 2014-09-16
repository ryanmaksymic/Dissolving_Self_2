/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/130660*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/*
Katie Manduca
 
 make a sphere of points
 radius dependent on mouse location
 */

int numDivisions = 200;

void setup() {
  size(600, 600, P3D);
  stroke(0, 128, 192);
  strokeWeight(1);
}


void draw() {
  background(0);
  // center the shape in the canvas
  translate(width/2, height/2, 0);
  float angle = TWO_PI / numDivisions;
  int radius = 0;
  radius = mouseX / 2;
    for (int j = 0; j < numDivisions; j++) {
    rotateY(angle);

    for (int i = 0; i < numDivisions; i++) {
      float x1 = cos(angle * i) * radius;
      float y1 = sin(angle * i) * radius;

     // stroke(angle*i, 100, 100);
      point(x1, y1, 0);
    }
  }
}


