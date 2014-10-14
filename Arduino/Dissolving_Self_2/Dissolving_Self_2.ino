/*

 Dissolving Self 2
 
 This is the final thing.
 
 Ryan Maksymic
 
 Created on October 2, 2014
 
 Modified on:
 * October 6, 2014
 
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


void setup()
{
  Serial.begin(9600);    // serial monitor
  mySerial.begin(9600);    // XBee communication

  Wire.begin();

  accelgyro.initialize();    // initialize device

    Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");    // verify connection

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
  // read raw accel/gyro measurements from device
  accelgyro.getMotion9(&ax, &ay, &az, &gx, &gy, &gz, &mx, &my, &mz);

  // scale and print gyro val
  gz = map(gz, -32800, 32800, 0, 1023);
  //Serial.println(gz);
  mySerial.println(gz);

  // see if there's incoming serial data:
  if (mySerial.available() > 0)
    //if (Serial.available() > 0)
  {
    // read the oldest byte in the serial buffer
    incomingByte = mySerial.read();
    //incomingByte = Serial.read();

    // if it's a capital H (ASCII 72), turn on the LED
    if (incomingByte == 'H')
    {
      digitalWrite(ELpin, HIGH);
    } 
    // if it's an L (ASCII 76), turn off the LED
    if (incomingByte == 'L')
    {
      digitalWrite(ELpin, LOW);
    }
  }

  delay(10);    // wait 10 ms
}

