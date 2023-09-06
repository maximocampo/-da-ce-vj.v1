float noiseAdd = 0;
float noiseFactor = 0;
int meshSkip = 5;
int[] meshcolor = {255,255,255};

void mesh(int[] depth, float factor) {
  
  pushMatrix();
  fill(meshcolor[0],meshcolor[1],meshcolor[2]);  
  noStroke();
  
  //specular(255, 255, 0);  
  //shininess(50);

  for (int y = 0; y < currentKinect.height - meshSkip; y += meshSkip) {
    boolean startedShape = false;
    for (int x = 0; x < currentKinect.width; x += meshSkip) {
      int offset = x + y * currentKinect.width;
      
      if (!startedShape) {
        beginShape(TRIANGLE_STRIP);
        startedShape = true;
      } 
      
      float z = ((factor-depth[offset] * factor*2)) - zDist;
      float znext = ((factor-depth[offset + meshSkip*currentKinect.width] * factor*2)) - zDist;
        
      if (depth[offset] < kthresh) {
        vertex(x*factor, y*factor, z);
        vertex(x*factor, (y+meshSkip)*factor, znext);

        if (depth[offset + meshSkip*currentKinect.width] >= kthresh || x == currentKinect.width-1) {
            if (startedShape) {
              endShape();
              startedShape = false;
            }
        }
      } else {
        if (startedShape) {  
          endShape();
          startedShape = false;
        }
      } 
    }
    if (startedShape) {
      endShape();
    }
  }
  
  popMatrix();
}

void meshControls(ControlP5 cp5, PApplet parent) {
    // mesh tab 
    cp5.addTab("mesh");
      
    //mesh colors
    ColorPicker meshcolorp = new ColorPicker(cp5, "meshcolor", sliderW, sliderH * 2 + 20, 100, meshcolor)
      .moveTo("mesh").setPosition(gridX(0), gridY(2)).plugTo(parent, "meshcolor");
      
    // mesh sliders 
    cp5.addSlider("meshSkip")
      .setPosition(gridX(0), gridY(0))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("mesh")
      .plugTo(parent,"meshSkip")
      .getCaptionLabel().align(RIGHT, CENTER);

}
