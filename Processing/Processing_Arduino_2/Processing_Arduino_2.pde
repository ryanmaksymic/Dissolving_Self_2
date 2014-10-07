// Graphing sketch v2


// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

// Created 20 Apr 2005
// Updated 18 Jan 2008
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph

void setup ()
{
  // set the window size:
  size(400, 300);
  background(0);

  // Prints out the available serial ports.
  println(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[7], 57600);

  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);

  // Set the Arduino digital pins as inputs.
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
}

void draw ()
{
  // everything happens in the serialEvent()
}

void serialEvent (Serial myPort)
{
  // convert to an int and map to the screen height:
  float inByte = float(arduino.analogRead(5)); 
  inByte = map(inByte, 0, 1023, 0, height);

  // draw the line:
  stroke(127, 34, 255);
  line(xPos, height, xPos, height - inByte);

  // at the edge of the screen, go back to the beginning:
  if (xPos >= width)
  {
    xPos = 0;
    background(0);
  } else
  {
    // increment the horizontal position:
    xPos++;
  }
}

