// serialEvent

void serialEvent (Serial myPort)    // runs when serial data is available
{
  String inString = myPort.readStringUntil('\n');    // get the ASCII string

  if (inString != null)    // if there is a message
  {
    inString = trim(inString);    // trim off any whitespace

    float inByte = float(inString);    // convert to float

    inByte = abs(inByte);    // take absolute value

      inByte = map(inByte, 0, 2000, 0, 1000);    // map gyroscope values to new range

    inByte = inByte/20;    // sample

    gyroVal = int(inByte);    // round

    gyroVal = gyroVal*20;    // return
  }

  if (gyroEn == false)    // if gyroscope disabled
  {
    gyroVal = 0;
  }
}

