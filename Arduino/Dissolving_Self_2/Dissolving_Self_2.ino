/*

 Dissolving Self 2
 
 Sends motion data to Processing. Receives commands from Processing to turn EL wire on and off.
 
 Ryan Maksymic
 
 Created on October 2, 2014
 
 References:
 * 
 
 */


#include <SoftwareSerial.h>
#include "Wire.h"
#include "I2Cdev.h"
#include "MPU6050.h"

MPU6050 accelgyro;

int16_t ax, ay, az;
int16_t gx, gy, gz;
int16_t mx, my, mz;

SoftwareSerial mySerial(MOSI, 4);    // RX, TX

int incomingByte;        // a variable to read incoming serial data into

int ELpin = 8;    // EL wire control pin

char mode = ' ';    // a = accelerometer; g = gyroscope


void setup()
{
  Serial.begin(9600);    // serial monitor
  mySerial.begin(9600);    // XBee communication

  Wire.begin();

  accelgyro.initialize();    // initialize device /

  Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");    // verify connection /

  pinMode(ELpin, OUTPUT);

  // NOTE: I'm not sure what this stuff is about:
  //  for (int i = 2; i < 14; i++)
  //  {
  //    digitalWrite(i, HIGH);    // enable pullups
  //  }

  /*
  while (establishContact()==0)
   {
   Serial.println("Waiting for connection from MAX...");
   delay(100);
   }  //wait for 99 byte
   */
}


void loop()
{
  // INPUTS

  // see if there's incoming serial data:
  if (mySerial.available() > 0)
  {
    // read the oldest byte in the serial buffer
    incomingByte = mySerial.read();

    // turn accelerometer on
    if (incomingByte == 'a')
    {
      mode = 'a';
    }
    // turn gyroscope on
    if (incomingByte == 'g')
    {
      mode = 'g';
    }

    // turn EL wire on
    if (incomingByte == 'h')
    {
      digitalWrite(ELpin, HIGH);
    } 
    // turn EL wire off
    if (incomingByte == 'l')
    {
      digitalWrite(ELpin, LOW);
    }
  }


  // OUTPUTS

  // read raw accel/gyro measurements from device
  accelgyro.getMotion9(&ax, &ay, &az, &gx, &gy, &gz, &mx, &my, &mz);

  // scale and print accelerometer value
  if (mode == 'a')
  {
    ax = map(ax, -32800, 32800, -1000, 1000);
    mySerial.println(ax);
  }
  // scale and print gyrocsope value
  else if (mode == 'g')
  {
    gz = map(gz, -32800, 32800, -1000, 1000);
    mySerial.println(gz);
  }


  delay(5);    // wait 10 ms
}

