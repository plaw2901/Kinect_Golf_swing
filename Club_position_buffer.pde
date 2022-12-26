class clubhead_buffer{
  
  ArrayList<PVector> club_pos_buffer;
  ArrayList<PImage> buffer;  
  private int frameCounter = 0;
  private int wid = 512;
  private int hei = 424;
  private int numFrame;
  private String Name = "infrared";
  int threshold_color = 255;
  clubhead_buffer(int numberOfFrame) 
  {
    numFrame = numberOfFrame ;
    club_pos_buffer = new ArrayList<PVector>(numberOfFrame);
    buffer = new ArrayList<PImage>(numberOfFrame);
    PImage imgFill = new PImage(wid,hei);
    for(int i = 0 ; i < numberOfFrame;i++){
      buffer.add(imgFill);
      club_pos_buffer.add(null);
    }
  }
  
  void Add(PImage img)
  {
    PImage copy = new PImage(wid,hei);
    copy = img.get();
    buffer.set(frameCount%numFrame,copy); 
    frameCounter ++; 
  }
  
  void get_club_pos() // get club position as well as filtering noise
  {
    color[] colorArray = {#FA037A,#050B79,#F5B2D2,#690579,#8B0345,#05E4FF,#DC00FF,#03672A,#757ABF,#0513FF,#38909B,#043A40,#04401F,#67C48B,#03672A};
    int max_dist = 10;
    for(int i = 0; i < numFrame;i++) // for each frame
    {
      try{
        ArrayList<White_spot> arr_spots = new ArrayList<White_spot>();
        for(int y = buffer.get(i).height-10; y > 10;y--)   //going from down to up
          {
          for(int x = buffer.get(i).width-10; x > 10;x--) //going left to right
          {
            if (color(buffer.get(i).pixels[x + y * buffer.get(i).width]) >= color(threshold_color)) // if pixel is white
            {    
                buffer.get(i).pixels[x + y * buffer.get(i).width] = colorArray[arr_spots.size()];
                boolean isNear = false;
                for(White_spot spot:arr_spots) // check if new spots is close to other existing spots
                {
                  if(spot.isNear(x,y))
                  {
                    spot.add(x,y);
                    isNear = true;
                    break;
                  }
                }
                if(!isNear){
                   White_spot newSpot = new White_spot(x,y,max_dist);
                   arr_spots.add(newSpot);
                }
             }
           }         
         }
         if(arr_spots.size() > 0){
           int size = 2;
           White_spot biggestSpot = arr_spots.get(0);
           for(White_spot spot:arr_spots)
           {
             if (spot.get_size() >= size){
               biggestSpot = spot;
               size = spot.get_size();
             }
           }
           club_pos_buffer.set(i,biggestSpot.get_center()); 
         }
      } catch (ArrayIndexOutOfBoundsException e){
          
        }
     }
   }
   
 void Save()
  {   
    int num_of_circles = 20;
    PGraphics pg = createGraphics(wid,hei);
    for(int i = 0; i<numFrame; i++){
      PImage img = buffer.get((frameCounter+1+i)%numFrame);
      pg.beginDraw();
      pg.image(img,0,0);
      int counter = 0;
        for(int j = i-num_of_circles; j <= i; j++){
          pg.fill(0,counter*(255/num_of_circles),255);
          pg.stroke(0,counter*(255/num_of_circles),255);
          if(club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame) != null){
            
            //pg.ellipse(club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame).x,club_position.club_pos_buffer.get((frameCounter+1+j)%numFrame).y,1,1);
          }
          counter++;
        }
      pg.endDraw();
      pg.save("data/" + Name +"/"+ Name + "_" + i + ".jpg");
      println(Name + " image #" + i + " saved"); 
    }
  println(Name + " images done saving");  
  }
}
