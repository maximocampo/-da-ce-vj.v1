int sphereRandom = 0;
int sphereSize = 1;
int sphereDetail = 5;
int sphereSkip  = 5;
int[] spherecolor = {255,255,255};
float n = 1;
float z;
int shine = 0;

void bubbleboy (int[] depth, float factor) {
  noStroke();
  fill(spherecolor[0],spherecolor[1],spherecolor[2]);
  shininess(shine);
  
  sphereDetail(sphereDetail);
  
  for (int _y = 0; _y < currentKinect.height - sphereSkip; _y += sphereSkip) {
    for (int _x = 0; _x < currentKinect.width; _x += sphereSkip) {
      int offset = _x + _y * currentKinect.width;
      if (depth[offset] < kthresh) {
        pushMatrix();
        
        float r = random(-sphereRandom, sphereRandom);
        
        float x = _x * factor + r;
        float y = _y * factor + r;
 
        z = ((factor-depth[offset] * factor*2)) - zDist;
        
        translate(x,y,z);
        sphere((sphereSize + r) * (1));
        
        
        popMatrix();
      } 
    }
  }
}
  

void bubbleboyControls(ControlP5 cp5, PApplet parent) {
  cp5.addSlider("sphere skip")
      .setPosition(gridX(0), gridY(0))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(13)
      .setNumberOfTickMarks(20)
      .moveTo("bubbleboy")
      .plugTo(parent,"sphereSkip")
      .getCaptionLabel().align(RIGHT, CENTER);
    
    cp5.addSlider("sphereDetail")
      .setPosition(gridX(0), gridY(1))
      .setSize(sliderW, sliderH)
      .setRange(5, 20)
      .setValue(5)
      .moveTo("bubbleboy")
      .plugTo(parent,"sphereDetail")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("sphere size")
      .setPosition(gridX(0), gridY(2))
      .setSize(sliderW, sliderH)
      .setRange(1, 50)
      .moveTo("bubbleboy")
      .plugTo(parent,"sphereSize")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("sphere random")
      .setPosition(gridX(0), gridY(3))
      .setSize(sliderW, sliderH)
      .setRange(0, 20)
      .moveTo("bubbleboy")
      .plugTo(parent,"sphereRandom")
      .getCaptionLabel().align(RIGHT, CENTER);
        
    cp5.addSlider("shine")
      .setPosition(gridX(0), gridY(4))
      .setSize(sliderW, sliderH)
      .setRange(0, 5000)
      .moveTo("bubbleboy")
      .plugTo(parent,"shine")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    //bubbleboy colors 
    ColorPicker spherecolorp = new ColorPicker(cp5, "bubbleboy", sliderW, sliderH * 2 + 20, 100, spherecolor)
    .moveTo("bubbleboy").setPosition(gridX(0), gridY(5)).plugTo(parent, "spherecolor");
}
