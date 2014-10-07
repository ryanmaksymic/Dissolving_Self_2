/*
 SoMo XBee Test
 
 Test computer-to-SoMo communication.
 
 Ryan Maksymic
 
 Created on October 6, 2014
 
 Modified on:
 * 
 
 References:
 * http://www.arduino.cc/en/Tutorial/PhysicalPixel
 
 */


import processing.serial.*; 

Serial port; 


void setup()
{
  size(200, 200);

  // list all of the available serial ports in the output pane
  println(Serial.list()); 

  // open the port that the Arduino board is connected to
  port = new Serial(this, Serial.list()[7], 9600);
}


void draw() 
{ 
  background(0);

  // check if a key is being pressed 
  if (keyPressed)
  {
    port.write('H');
  }
  else
  {
    port.write('L');
  }
}

