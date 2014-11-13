/*

 Dissolving Self 2
 
 Sends motion data to Processing. Receives commands from Processing to turn EL wire on and off.
 
 Ryan Maksymic
 
 Created on October 2, 2014
 
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

boolean gyroOn = false;    // true = send gyroscope data to Processing
boolean ELOn = false;    // true = EL wire is illuminated


void setup()
{
  Serial.begin(9600);    // serial monitor
  mySerial.begin(9600);    // XBee communication

  Wire.begin();

  accelgyro.initialize();    // initialize device /

  Serial.println(accelgyro.testConnection() ? "MPU6050 connection successful" : "MPU6050 connection failed");    // verify connection /

  pinMode(ELpin, OUTPUT);
}


void loop()
{
  // see if there's incoming serial data:
  if (mySerial.available() > 0)
  {
    // read the oldest byte in the serial buffer
    incomingByte = mySerial.read();

    // turn gyroscope on
    if (incomingByte == 'G')
    {
      gyroOn = true;
    }
    // turn gyroscope off
    if (incomingByte == 'g')
    {
      gyroOn = false;
    }

    // flicker EL wire
    if (incomingByte == 'f')
    {
      digitalWrite(ELpin, HIGH);
      delay(random(60, 80));
      digitalWrite(ELpin, LOW);
      delay(random(30, 50));
      digitalWrite(ELpin, HIGH);
      delay(random(60, 80));
      digitalWrite(ELpin, LOW);
    }
    // turn EL wire on
    if (incomingByte == 'E')
    {
      ELOn = true;
    } 
    // turn EL wire off
    if (incomingByte == 'e')
    {
      ELOn = false;
    }
  }

  // read raw accel/gyro measurements from device
  accelgyro.getMotion9(&ax, &ay, &az, &gx, &gy, &gz, &mx, &my, &mz);

  // scale and print accelerometer value
  if (gyroOn)
  {
    gz = map(gz, -32800, 32800, -1000, 1000);
    mySerial.println(gz);
  }

  // flicker EL wire
  if (ELOn)
  {
    digitalWrite(ELpin, HIGH);

    if (millis()%21 == 0)
    {
      digitalWrite(ELpin, LOW);
      delay(random(10, 100));
      digitalWrite(ELpin, HIGH);
    }
  }
}

