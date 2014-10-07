/*

 Dissolving Self 1
 
 Created on March 14, 2013
 
 Wiring (Gyro = Arduino):
 * GND = GND
 * VCC = 3.3 V
 * SCL = A5
 * SDA = A4
 * SDO = GND
 * CS = 3.3 V
 * INT2 = NC
 * INT1 = NC
 
 */


#include <Wire.h>

#define CTRL_REG1 0x20
#define CTRL_REG2 0x21
#define CTRL_REG3 0x22
#define CTRL_REG4 0x23
#define CTRL_REG5 0x24

int L3G4200D_Address = 0b1101000;    // L3G4200D's I2C address

int x;
int y;
int z;
int temp;

const int numReadings = 35;
int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average


void setup()
{
  Wire.begin();    // join the I2C bus as master

  Serial.begin(115200);    // open serial port

  for (int thisReading = 0; thisReading < numReadings; thisReading++)  
  {
    readings[thisReading] = 0;
  }

  //Serial.println("Starting up L3G4200D...");
  setupL3G4200D(2000);                        // configure L3G4200 at 250, 500, or 2000 degrees per second

  delay(2000);    // wait for the sensor to be ready
}


void loop()
{
  getGyroValues();    // update x, y, and z with new values

    Serial.println(x);    // send it to the computer as ASCII digits
}


void loopAlt()
{
  getGyroValues();    // update x, y, and z with new values

    total = total - readings[index];    // subtract the last reading

  readings[index] = x;    // read from the sensor

  total = total + readings[index];    // add the reading to the total

  index++;    // advance to the next position in the array               

  if (index >= numReadings)    // if we're at the end of the array,
  {
    index = 0;                 // wrap around to the beginning
  }

  average = total / numReadings;    // calculate the average

  Serial.println(average);    // send it to the computer as ASCII digits

  delay(1);
}


void getGyroValues()
{
  byte xMSB = readRegister(L3G4200D_Address, 0x29);
  byte xLSB = readRegister(L3G4200D_Address, 0x28);
  x = ((xMSB << 8) | xLSB);

  byte yMSB = readRegister(L3G4200D_Address, 0x2B);
  byte yLSB = readRegister(L3G4200D_Address, 0x2A);
  y = ((yMSB << 8) | yLSB);

  byte zMSB = readRegister(L3G4200D_Address, 0x2D);
  byte zLSB = readRegister(L3G4200D_Address, 0x2C);
  z = ((zMSB << 8) | zLSB);
}


int setupL3G4200D(int scale)    // From  Jim Lindblom's (Sparkfun) code
{
  // Enable x, y, z, and turn off power down:
  writeRegister(L3G4200D_Address, CTRL_REG1, 0b00001111);

  // If you'd like to adjust/use the HPF, you can edit the line below to configure CTRL_REG2:
  writeRegister(L3G4200D_Address, CTRL_REG2, 0b00000000);

  // Configure CTRL_REG3 to generate data ready interrupt on INT2
  // No interrupts used on INT1, if you'd like to configure INT1
  // or INT2 otherwise, consult the datasheet:
  writeRegister(L3G4200D_Address, CTRL_REG3, 0b00001000);

  // CTRL_REG4 controls the full-scale range, among other things:

  if(scale == 250)
  {
    writeRegister(L3G4200D_Address, CTRL_REG4, 0b00000000);
  }
  else if(scale == 500)
  {
    writeRegister(L3G4200D_Address, CTRL_REG4, 0b00010000);
  }
  else
  {
    writeRegister(L3G4200D_Address, CTRL_REG4, 0b00110000);
  }

  // CTRL_REG5 controls high-pass filtering of outputs, use it
  // if you'd like:
  writeRegister(L3G4200D_Address, CTRL_REG5, 0b00000010);
}


void writeRegister(int deviceAddress, byte address, byte val)
{
  Wire.beginTransmission(deviceAddress);    // start transmission to device 
  Wire.write(address);    // send register address
  Wire.write(val);    // send value to write
  Wire.endTransmission();    // end transmission
}

int readRegister(int deviceAddress, byte address)
{
  int v;
  Wire.beginTransmission(deviceAddress);
  Wire.write(address);    // register to read
  Wire.endTransmission();

  Wire.requestFrom(deviceAddress, 1);    // request one byte from slave

  while(!Wire.available())    // wait until one byte is received
  {
  }

  v = Wire.read();    // store received byte
  return v;
}

