class color_buffer{
  
  ArrayList<PImage> buffer;
  private int frameCounter = 0;
  private int wid = 1920;
  private int hei = 1080;
  private int numFrame;
  private String Name = "Color";
  
  color_buffer(int numberOfFrame) 
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
    PGraphics pg = createGraphics(wid,hei);
    for(int i = 0; i<numFrame; i++){
      PImage img = buffer.get((frameCounter+1+i)%numFrame);
      pg.beginDraw();
      pg.image(img,0,0);
      pg.endDraw();
      pg.save("data/" + Name +"/"+ Name + "_" + i + ".jpg");
      println(Name + " image #" + i + " saved"); 
    }
  println(Name + " images done saving");  
  }
}
