// Kinect Functions

void headTrack(int userId)    // get x position of user's head
{
  PVector jointPos = new PVector();
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, jointPos);    // get 3D position of a joint

  if (state <= 4)
  {
    screenLeft = 0.3*width;
    screenRight = 0.7*width;
  }
  else if (state > 4)
  {
    screenLeft = 0.45*width;
    screenRight = 0.55*width;
  }

  userPos = map(jointPos.x, -context.depthWidth(), context.depthWidth(), screenRight, screenLeft);    // map user position to screen width
}

void onNewUser(int userId)    // when a user enters the field of view
{
  println("New User Detected - userId: " + userId);

  // start pose detection
  if (autoCalib)
  {
    context.requestCalibrationSkeleton(userId, true);
  }
  else
  {
    context.startPoseDetection("Psi", userId);
  }
}

void onLostUser(int userId)    // when a user is lost
{
  println("User Lost - userId: " + userId);
}

void onExitUser(int userId)    // when a user exits the field of view
{
  println("onExitUser - userId: " + userId);
}

void onReEnterUser(int userId)    // when a user re-enters the field of view
{
  println("onReEnterUser - userId: " + userId);
}

void onStartPose(String pose, int userId)    // when a user begins a pose
{
  println("Start of Pose Detected  - userId: " + userId + ", pose: " + pose);

  // stop pose detection
  context.stopPoseDetection(userId); 

  // start attempting to calibrate the skeleton
  context.requestCalibrationSkeleton(userId, true);
}

void onEndPose(String pose, int userId)    // when a user exits a pose
{
  println("onEndPose - userId: " + userId + ", pose: " + pose);
}

void onStartCalibration(int userId)    // when calibration begins
{
  println("Beginning Calibration - userId: " + userId);
}

void onEndCalibration(int userId, boolean successfull)    // when calibaration ends - successfully or unsucessfully
{
  println("Calibration of userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");

    // begin skeleton tracking
    context.startTrackingSkeleton(userId);
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");

    // Start pose detection
    context.startPoseDetection("Psi", userId);
  }
}

