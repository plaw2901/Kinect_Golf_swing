
//DRAW BODY
void drawBody(KJoint[] joints, KJoint[] joints3d,PGraphics pg) {
  drawBone(joints, joints3d, HEAD, NECK,pg);
  drawBone(joints, joints3d, NECK, SPINE_SHOULDER,pg);
  drawBone(joints, joints3d, SPINE_SHOULDER, SPINE_MID,pg);
  drawBone(joints, joints3d, SPINE_MID, SPINE_BASE,pg);
  drawBone(joints, joints3d, SPINE_SHOULDER, SHOULDER_RIGHT,pg);
  drawBone(joints, joints3d, SPINE_SHOULDER, SHOULDER_LEFT,pg);
  drawBone(joints, joints3d, SPINE_BASE, HIP_RIGHT,pg);
  drawBone(joints, joints3d, SPINE_BASE, HIP_LEFT,pg);
  // Right Arm
  drawBone(joints, joints3d, SHOULDER_RIGHT, ELBOW_RIGHT,pg);
  drawBone(joints, joints3d, ELBOW_RIGHT, WRIST_RIGHT,pg);
  drawBone(joints, joints3d, WRIST_RIGHT, HAND_RIGHT,pg);
  drawBone(joints, joints3d, HAND_RIGHT, HAND_TIP_RIGHT,pg);
  //drawBone(joints, joints3d, HAND_RIGHT, THUMB_RIGHT);
  // Left Arm
  drawBone(joints, joints3d, SHOULDER_LEFT, ELBOW_LEFT,pg);
  drawBone(joints, joints3d, ELBOW_LEFT, WRIST_LEFT,pg);
  drawBone(joints, joints3d, WRIST_LEFT, HAND_LEFT,pg);
  drawBone(joints, joints3d, HAND_LEFT, HAND_TIP_LEFT,pg);
  //drawBone(joints, joints3d, HAND_LEFT, THUMB_LEFT);
  // Right Leg
  drawBone(joints, joints3d, HIP_RIGHT, KNEE_RIGHT,pg);
  drawBone(joints, joints3d, KNEE_RIGHT, ANKLE_RIGHT,pg);
  drawBone(joints, joints3d, ANKLE_RIGHT, FOOT_RIGHT,pg);
  // Left Leg
  drawBone(joints, joints3d, HIP_LEFT, KNEE_LEFT,pg);
  drawBone(joints, joints3d, KNEE_LEFT, ANKLE_LEFT,pg);
  drawBone(joints, joints3d, ANKLE_LEFT, FOOT_LEFT,pg);
  drawJoint(joints, joints3d, HAND_LEFT,pg);
  drawJoint(joints, joints3d, HAND_RIGHT,pg);
  drawJoint(joints, joints3d, FOOT_LEFT,pg);
  drawJoint(joints, joints3d, FOOT_RIGHT,pg);
  drawJoint(joints, joints3d, HEAD,pg);
}



//draw joint
void drawJoint(KJoint[] joints,KJoint[] joints3d, int jointType,PGraphics pg) {
  pg.pushMatrix();
  pg.translate(joints[jointType].getX(), joints[jointType].getY(), joints3d[jointType].getZ());
  pg.ellipse(0, 0, 10/joints3d[jointType].getZ(), 10/joints3d[jointType].getZ());
  pg.popMatrix();
}

//draw bone
void drawBone(KJoint[] joints,KJoint[] joints3d, int jointType1, int jointType2,PGraphics pg) {
  pg.pushMatrix();
  pg.translate(joints[jointType1].getX(), joints[jointType1].getY(), joints3d[jointType1].getZ());
  pg.ellipse(0, 0, 10/joints3d[jointType1].getZ(), 10/joints3d[jointType1].getZ());
  pg.popMatrix();
  pg.line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}


// Base
int SPINE_BASE = KinectPV2.JointType_SpineBase; // #0
int SPINE_MID = KinectPV2.JointType_SpineMid; // #1

// Head
int NECK = KinectPV2.JointType_Neck; // #2
int HEAD = KinectPV2.JointType_Head; // #3

// Left arm
int SHOULDER_LEFT = KinectPV2.JointType_ShoulderLeft; // #4
int ELBOW_LEFT = KinectPV2.JointType_ElbowLeft; // #5
int WRIST_LEFT = KinectPV2.JointType_WristLeft; // #6
int HAND_LEFT = KinectPV2.JointType_HandLeft; // #7

// Right arm
int SHOULDER_RIGHT = KinectPV2.JointType_ShoulderRight; // #8
int ELBOW_RIGHT = KinectPV2.JointType_ElbowRight; // #9
int WRIST_RIGHT = KinectPV2.JointType_WristRight; // #10
int HAND_RIGHT = KinectPV2.JointType_HandRight; // #11

// Left leg
int HIP_LEFT = KinectPV2.JointType_HipLeft; // #12
int KNEE_LEFT = KinectPV2.JointType_KneeLeft; // #13
int ANKLE_LEFT = KinectPV2.JointType_AnkleLeft; // #14
int FOOT_LEFT = KinectPV2.JointType_FootLeft; // #15

// Right Leg
int HIP_RIGHT = KinectPV2.JointType_HipRight; // #16
int KNEE_RIGHT = KinectPV2.JointType_KneeRight; // #17
int ANKLE_RIGHT = KinectPV2.JointType_AnkleRight; // #18
int FOOT_RIGHT = KinectPV2.JointType_FootRight; // #19

// Bonus
int SPINE_SHOULDER = KinectPV2.JointType_SpineShoulder; // #20

// Left Hand details
int HAND_TIP_LEFT = KinectPV2.JointType_HandTipLeft; // #21
int THUMB_LEFT = KinectPV2.JointType_ThumbLeft; // #22

// Right Hand details
int HAND_TIP_RIGHT = KinectPV2.JointType_HandTipRight; // #23
int THUMB_RIGHT = KinectPV2.JointType_ThumbRight; // #24

// * Skeleton tracking state
int SKELETON_NOT_TRACKED = KinectPV2.TrackingState_NotTracked; // 0
int SKELETON_INFERRED = KinectPV2.TrackingState_Inferred; // 1
int SKELETON_TRACKED = KinectPV2.TrackingState_Tracked; // 2


ArrayList<float[]> getSkeletonXYZ(KJoint[] joints3D) {
    int joints_number = 25;
    float[] x_values  = new float[joints_number];
    float[] y_values  = new float[joints_number];
    float[] z_values  = new float[joints_number];
    ArrayList<float[]> XYZ_list = new ArrayList<float[]>();
// For every joints, get the z value, store it in an array 
     for(int i = 0; i < joints_number; i++) {
       x_values[i] = joints3D[i].getX();
       XYZ_list.add(x_values);
       y_values[i] = joints3D[i].getY();
       XYZ_list.add(y_values);
       z_values[i] = joints3D[i].getZ();
       XYZ_list.add(z_values);     
      }
      return XYZ_list;
  }
