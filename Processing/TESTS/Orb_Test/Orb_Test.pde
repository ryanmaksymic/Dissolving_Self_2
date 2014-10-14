/*

 Orb Test
 
 Test orb visual
 
 Ryan Maksyimc
 
 Created on October 9, 2014
 
 Modified on:
 * 
 
 References:
 * 
 
 */


int x;
int y;

//int xUpdate;

int xPrev1;
int yPrev1;

int xPrev2;
int yPrev2;

color col;


void setup()
{
  size(500, 500);
  noStroke();

  x = width/2;
  y = height/2;

  //xUpdate = 2;

  xPrev1 = x;
  yPrev1 = y;

  xPrev2 = xPrev1;
  yPrev2 = yPrev1;
  
  col = color(255, 155, 5);
}


void draw()
{
  background(0);

  x = mouseX;
  y = mouseY;

  fill(col, 255);
  ellipse(x, y, 130, 130);

  fill(col, 100);
  ellipse(xPrev1, yPrev1, 155, 155);
  fill(col, 50);
  ellipse(xPrev1, yPrev1, 160, 160);

  fill(col, 30);
  ellipse(xPrev2, yPrev2, 200, 200);
  fill(col, 20);
  ellipse(xPrev2, yPrev2, 205, 205);
  fill(col, 10);
  ellipse(xPrev2, yPrev2, 210, 210);

  xPrev2 = xPrev1;
  yPrev2 = yPrev1;

  xPrev1 = x;
  yPrev1 = y;

  /*
  if (x > 350)
   {
   xUpdate = -2;
   }
   
   if (x < 150)
   {
   xUpdate = 2;
   }
   
   x += xUpdate;
   */
}

