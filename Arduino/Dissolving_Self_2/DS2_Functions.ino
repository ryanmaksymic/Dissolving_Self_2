// DS2 Functions


int ScaleMAX(int raw)    // scale the inputs
{
  float temp = Scale(raw, -16000, 16000);

  return temp*1024;
}


int ScaleMAX_mag(int raw)    // scale the inputs for magnetometer only
{
  float temp = Scale(raw, -32000, 32000);

  return temp*1024;
}


float Scale(long in, long smin, long smax)    // scale one of the inputs to between 0.0 and 1.0
{
  // bound
  if (in > smax) in=smax;
  if (in < smin) in=smin;

  // change zero-offset
  in = in-smin;
  // NOTE: What's this "zero-offset" stuff? 

  // scale between 0.0 and 1.0 (0.5 would be halfway)
  float temp = (float)in/((float)smax-(float)smin);
  return temp;
}

