int pointsSkip = 5;
int[] pointsColor = {255,255,255};
float pointsSize = 10;

void points(int[] depth, float factor) {
  for (int _y = 0; _y < currentKinect.height - pointsSkip; _y += pointsSkip) {
    for (int _x = 0; _x < currentKinect.width; _x += pointsSkip) {
      int offset = _x + _y * currentKinect.width;
      if (depth[offset] < kthresh) {
        pushMatrix();
        
        float r = random(-sphereRandom * 10, sphereRandom * 9);
        float x = _x * factor + r;
        float y = _y * factor + r;            
        
        z = (factor-depth[offset] * factor*2) - zDist;

       
        strokeWeight(1);
        stroke(pointsColor[0],pointsColor[1],pointsColor[2]);
        //fill(pointsColor);
        translate(x,y,z);
        circle(0,0,pointsSize);
        popMatrix();
      }
    }
  }
}

void pointsControls(ControlP5 cp5, PApplet parent) {
    cp5.addTab("points");
      
   
    ColorPicker pointscolorp = new ColorPicker(cp5, "pointsColor", sliderW, sliderH * 2 + 20, 100, pointsColor)
      .moveTo("points").setPosition(gridX(0), gridY(2)).plugTo(parent, "pointsColor");
      
    cp5.addSlider("pointsSkip")
      .setPosition(gridX(0), gridY(0))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("points")
      .plugTo(parent,"pointsSkip")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("pointsSize")
      .setPosition(gridX(0), gridY(1))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .moveTo("points")
      .plugTo(parent,"pointsSize")
      .getCaptionLabel().align(RIGHT, CENTER);
      
}
