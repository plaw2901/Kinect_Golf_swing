
import KinectPV2.KJoint;
import KinectPV2.*;
import processing.pdf.PGraphicsPDF;
import java.util.Arrays;
KinectPV2 kinect;
//Ints
int numFrame =180;
//Float
float ratio_X = 1920/512;
float ratio_Y = 1080/424;
float ClubHeadSpeed = 0;
//Image buffer
color_buffer color_buffer = new color_buffer(numFrame);
depth_buffer depth_buffer = new depth_buffer(numFrame);
clubhead_buffer club_position = new clubhead_buffer(numFrame); 
PGraphics pg_depth;
PGraphics pg_color;



void setup() {
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);
  kinect.enableSkeletonDepthMap(true);
  kinect.enableSkeletonColorMap(true);
  kinect.enableSkeleton3DMap(true);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  kinect.enableInfraredImg(true);
  kinect.enableInfraredLongExposureImg(true);
  kinect.init();
  frameRate(29);
  pg_depth = createGraphics(512, 424,P3D);
  pg_color = createGraphics(1920, 1080,P3D);
}
void draw() {
  background(0);
     
  PImage infrared_image = kinect.getInfraredImage();
  PImage depth_image = kinect.getDepthImage();
  PImage color_image = kinect.getColorImage();
/*********************** INFRARED clubface ************************************************/
  club_position.Add(infrared_image);
/*********************** INFRARED clubface ************************************************/

/*********************** DEPTH SKELETON ************************************************/
  pg_depth.beginDraw();
  pg_depth.fill(0);
  pg_depth.rect(0, 0,512,424);
  //get the skeletons as an Arraylist of KSkeletons
  ArrayList<KSkeleton> depth_skeletonArray =  kinect.getSkeletonDepthMap();
  ArrayList<KSkeleton> depth_skeletonArray3d =  kinect.getSkeleton3d();
  //individual joints
  for (int i = 0; i < depth_skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) depth_skeletonArray.get(i);
    KSkeleton skeleton3d = (KSkeleton) depth_skeletonArray3d.get(i);
    //if the skeleton is being tracked compute the skleton joints
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      KJoint[] joints3d = skeleton3d.getJoints();
      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      pg_depth.fill(col);
      pg_depth.stroke(col);
      drawBody(joints,joints3d,pg_depth);
    }
  }
  pg_depth.image(depth_image,0,0); 
  pg_depth.endDraw();
  PImage depth_img = pg_depth.get();  
  depth_buffer.Add(depth_img); 
/*********************** DEPTH SKELETON ************************************************/ 

/*********************** COLOR SKELETON ************************************************/
  //pg_color.beginDraw();
  //pg_color.fill(0);
  //pg_color.rect(0, 0,1920,1080);
  ////get the skeletons as an Arraylist of KSkeletons
  //ArrayList<KSkeleton> COLOR_skeletonArray =  kinect.getSkeletonColorMap();
  //ArrayList<KSkeleton> COLOR_skeletonArray3d =  kinect.getSkeleton3d();
  ////individual joints
  //for (int i = 0; i < COLOR_skeletonArray.size(); i++) {
  //  KSkeleton skeleton = (KSkeleton) COLOR_skeletonArray.get(i);
  //  KSkeleton skeleton3d = (KSkeleton) COLOR_skeletonArray3d.get(i);
  //  //if the skeleton is being tracked compute the skleton joints
  //  if (skeleton.isTracked()) {
  //    KJoint[] joints = skeleton.getJoints();
  //    KJoint[] joints3d = skeleton3d.getJoints();
  //    color col  = skeleton.getIndexColor();
  //    fill(col);
  //    stroke(col);
  //    pg_color.fill(col);
  //    pg_color.stroke(col);
  //    drawBody(joints,joints3d,pg_color);
  //  }
  //}
  //pg_color.image(color_image,0,0);
  //pg_color.endDraw();
  //PImage imgCol = pg_color.get();  
  //color_buffer.Add(color_image);
/*********************** COLOR SKELETON ************************************************/ 
  
  //PImage depth_image = kinect.getDepthImage();
  //depth_buffer.Add(depth_image); 

  
  //PImage LE_infrared_image = kinect.getInfraredLongExposureImage();
  //LE_infrared_buffer.Add(LE_infrared_image);
  
  fill(0);
  stroke(0);
  image(color_image,0,0); 
  fill(0);
  stroke(0);
  rect(0,0,512,424);
  image(depth_image,0,0);
  //rect(0,424,512,424);
  //image(infrared_image,0,0);
  fill(0,255,0);
  textSize(20);
  text(frameRate,50,50);
}

void keyPressed() {  
  if (key == 'q' || key == 'Q' || key == ESC){
      key = 0;  
      //save images
      //color_buffer.Save();
      //depth_buffer.Save();
      print("Quitting \n");
      kinect.dispose();
      stop();
      exit();
    }
    if (key == 's' || key == 'S'){
      club_position.get_club_pos();
      //color_buffer.Save();
      club_position.Save();
      depth_buffer.Save();
    }
} 
