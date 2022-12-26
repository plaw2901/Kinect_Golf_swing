class depth_buffer{
  
  ArrayList<PImage> buffer;  
  private int frameCounter = 0;
  private int wid = 512;
  private int hei = 424;
  private int numFrame;
  private String Name = "Depth";
  
  depth_buffer(int numberOfFrame) 
  {
    numFrame = numberOfFrame ;
    buffer = new ArrayList<PImage>(numberOfFrame);
    PImage imgFill = new PImage(wid,hei);
    for(int i = 0 ; i < numberOfFrame;i++){
      buffer.add(imgFill);
    }
  }
  
  void Add(PImage img)
  {
    PImage copy = new PImage(wid,hei);
    copy = img.get();
    buffer.set(frameCount%numFrame,copy); 
    frameCounter ++; 
  }
  
  void Save()
  {   
    int num_of_circles = 20;
    PGraphics pg = createGraphics(wid,hei);
    for(int i = 0; i<numFrame; i++){
      PImage img = buffer.get((frameCounter+1+i)%numFrame);
      pg.beginDraw();
      pg.image(img,0,0);
      pg.noFill();
      pg.strokeJoin(ROUND);
      pg.strokeWeight(5);
      pg.stroke(255,0,0);
      pg.beginShape();
      if(club_position.club_pos_buffer.get((frameCounter+1+i-num_of_circles)%numFrame) != null){
        pg.vertex(club_position.club_pos_buffer.get((frameCounter+1+i-num_of_circles)%numFrame).x,club_position.club_pos_buffer.get((frameCounter+1+i-num_of_circles)%numFrame).y); // first point
      }
      int counter = 0;
      for(int j = i-num_of_circles; j <= i; j++)
      { 
        pg.stroke((255/num_of_circles)*counter,0,0);
        if(club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame) != null)
        {  
          pg.curveVertex(club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame).x,club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame).y); // lines between points
        }
        counter++;
      }
      if(club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame) != null)
      {  
        pg.vertex(club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).x,club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).y); // last point point
      }
      pg.endShape();
      /**********************make sure the center is not on the edge*/
      if(club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame) != null && (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).x-20 >=0 && (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).x+20 <=width && (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).y-20 >=0 && (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).y+20 <=height)
      {
        for (int posx = (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).x-20;posx<(int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).x+20;posx++)
        {
          for (int posy = (int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).y-20;posy<(int)club_position.club_pos_buffer.get((frameCounter+1+i)%numFrame).y+20;posy++)
          {
            
            if(img.pixels[posx * posy] ==  0)
            {
              pg.fill(255,255,0);
              pg.rect(posx-20,posy-20,40,40);
            }
          }
        }
      }
      pg.endDraw();
      pg.save("data/" + Name +"/"+ Name + "_" + i + ".jpg");
      println(Name + " image #" + i + " saved"); 
    }
  println(Name + " images done saving");  
  }
}
