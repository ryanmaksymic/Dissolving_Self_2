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

// EL wire control pins
int ELpin = 8;


void setup()
{
  Wire.begin();
  Serial.begin(38400);    // serial monitor

  // initialize device
  Serial.println("Initializing I2C devices...");
  accelgyro.initialize();

  // verify connection
  Serial.println("Testing device connections...");
  Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");

  mySerial.begin(9600);    // XBee communication

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
  Serial.println(gz);
  mySerial.println(gz);

  // test: quick rotation illuminates EL wire
  if (gz > 923  || gz < 100)
  {
    digitalWrite(ELpin, HIGH);
  }
  else
  {
    digitalWrite(ELpin, LOW);
  }

  delay(10);    // wait 10 ms
}


//////// FUNCTIONS ////////

// scale the inputs
int ScaleMAX(int raw)
{
  float temp = Scale(raw, -16000, 16000);

  return temp*1024;
}


// scale the inputs for magnetometer only
int ScaleMAX_mag(int raw)
{
  float temp = Scale(raw, -32000, 32000);

  return temp*1024;
}


// scale one of the inputs to between 0.0 and 1.0
// NOTE: What's this "zero-offset" stuff? 
float Scale(long in, long smin, long smax)
{
  // bound
  if (in > smax) in=smax;
  if (in < smin) in=smin;

  // change zero-offset
  in = in-smin;

  // scale between 0.0 and 1.0 (0.5 would be halfway)
  float temp = (float)in/((float)smax-(float)smin);
  return temp;
}

