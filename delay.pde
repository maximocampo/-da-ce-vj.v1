int mesh2Skip = 5;
int[] mesh2color = {255,255,255};
int echoCount = 1;
ArrayList<ArrayList<PVector[]>> echoBuffer = new ArrayList<>();
int frameCounter = 0;
int framesBetweenEchoes = 10;
float depthThreshold = 20;
HashMap<PVector, PVector> normalMap = new HashMap<>();
int normalZ = 1;
boolean phong = false;

int minDepth = Integer.MAX_VALUE;;

void tang(int[] depth, float factor) {
  pushMatrix();
  
  PVector p1, p2, p3, p4;
  
  beginShape(TRIANGLES);
  normal(0,0,0.000001);
  
  for (int y = 0; y < currentKinect.height - meshSkip; y += meshSkip) {
    for (int x = 0; x < currentKinect.width - meshSkip; x += meshSkip) {
      int offset1 = x + y * currentKinect.width;
      int offset2 = (x + meshSkip) + y * currentKinect.width;
      int offset3 = x + (y + meshSkip) * currentKinect.width;
      int offset4 = (x + meshSkip) + (y + meshSkip) * currentKinect.width;

      // Skip drawing the triangles if any of the vertices are above kthresh
      if (depth[offset1] >= kthresh || depth[offset2] >= kthresh || depth[offset3] >= kthresh || depth[offset4] >= kthresh) {
        continue;
      }
      

      float z1 = ((factor - depth[offset1] * factor * 2)) - zDist;
      float z2 = ((factor - depth[offset2] * factor * 2)) - zDist;
      float z3 = ((factor - depth[offset3] * factor * 2)) - zDist;
      float z4 = ((factor - depth[offset4] * factor * 2)) - zDist;
      
      p1 = new PVector(x * factor, y * factor, z1);
      p2 = new PVector((x + meshSkip) * factor, y * factor, z2);
      p3 = new PVector(x * factor, (y + meshSkip) * factor, z3);
      p4 = new PVector((x + meshSkip) * factor, (y + meshSkip) * factor, z4);

      // First triangle
      vertex(p1.x, p1.y, p1.z);
      vertex(p2.x, p2.y, p2.z);
      vertex(p3.x, p3.y, p3.z);

      // Second triangle
      vertex(p3.x, p3.y, p3.z);
      vertex(p2.x, p2.y, p2.z);
      vertex(p4.x, p4.y, p4.z);
    }
  }
  
  endShape();
  popMatrix();
}
void mesh2Controls(ControlP5 cp5, PApplet parent) {
    cp5.addTab("mesh2");
    //mesh colors
    ColorPicker meshcolorp = new ColorPicker(cp5, "mesh2color", sliderW, sliderH * 2 + 20, 100, meshcolor)
      .moveTo("mesh2").setPosition(gridX(0), gridY(4)).plugTo(parent, "mesh2color");
      
    // mesh sliders 
    cp5.addSlider("mesh2Skip")
      .setPosition(gridX(0), gridY(0))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("mesh2")
      .plugTo(parent,"mesh2Skip")
      .getCaptionLabel().align(RIGHT, CENTER);
      
           
    // mesh sliders 
    cp5.addSlider("echoCount")
      .setPosition(gridX(0), gridY(1))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("mesh2")
      .plugTo(parent,"echoCount")
      .getCaptionLabel().align(RIGHT, CENTER);  
           
    // mesh sliders 
    cp5.addSlider("framesBetweenEchoes")
      .setPosition(gridX(0), gridY(2))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("mesh2")
      .plugTo(parent,"framesBetweenEchoes")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    // mesh sliders 
    cp5.addSlider("normalZ")
      .setPosition(gridX(0), gridY(3))
      .setSize(sliderW, sliderH)
      .setRange(1, 20)
      .setValue(5)
      .setNumberOfTickMarks(20)
      .moveTo("mesh2")
      .plugTo(parent,"normalZ")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addToggle("phong")
      .setPosition(gridX(0), gridY(8))
      .setSize(sliderH, sliderH)
      .moveTo("mesh2")
      .setValue(false)
      .plugTo(parent,"phong");
}
