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


#include <SoftwareSerial.h>

const int ledPin = 8;    // the pin that the LED is attached to
int incomingByte;        // a variable to read incoming serial data into

SoftwareSerial mySerial(MOSI, 4);    // RX, TX


void setup()
{
  // initialize serial communication
  mySerial.begin(9600);

  // initialize the LED pin as an output
  pinMode(ledPin, OUTPUT);
}


void loop()
{
  // see if there's incoming serial data:
  if (mySerial.available() > 0)
  {
    // read the oldest byte in the serial buffer
    incomingByte = mySerial.read();

    // if it's a capital H (ASCII 72), turn on the LED
    if (incomingByte == 'H')
    {
      digitalWrite(ledPin, HIGH);
    } 
    // if it's an L (ASCII 76), turn off the LED
    if (incomingByte == 'L')
    {
      digitalWrite(ledPin, LOW);
    }
  }
}

