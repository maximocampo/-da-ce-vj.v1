PVector light1 = new PVector(0,0);
float light1z = 0;
int[] l1rgb = {255,255,255};
int[] l2rgb = {255,255,255};
PVector light2 = new PVector(3000,1720);
int light2z = 0;
int light2r = 80;
int light2g = 80;
int light2b = 80;
int ambientR = 0;
int ambientG = 0;
int ambientB = 0;


void renderLights() {
  ambientLight(ambientR, ambientG, ambientB);
  pointLight(l1rgb[0], l1rgb[1], l1rgb[2], light1.x, light1.y, light1z);  
  pointLight(l2rgb[0], l2rgb[1], l2rgb[2], light2.x, light2.y, light2z);  
  //lightFalloff(light2.x, light2.y, light2z);
  
}

void lightControls(ControlP5 cp5, PApplet parent) {
  
  cp5.addTab("lights");

  cp5.addSlider2D("light1 xy")
    .setPosition(gridX(0) - 6,gridY(0))
    .setSize(sliderW - sliderH, sliderW - (sliderH*2))
    .setMinMax(0,0,width*2,height*2)
    .setValue(50,50)
    .setId(1)
    .moveTo("lights")
    .plugTo(parent, "s")
    .getCaptionLabel().align(CENTER, CENTER);
    
  cp5.addSlider("z")
      .setPosition(gridX(6) - 6, gridY(0))
      .setSize(sliderH, sliderW - (sliderH*2))
      .setRange(zDist + 20000, zDist)

      .moveTo("lights")
      .plugTo(parent,"light1z")
      .getCaptionLabel().align(CENTER, CENTER);
      
  ColorPicker l1p = new ColorPicker(cp5, "l1rgb", sliderW, sliderH * 2 + 20, 100, l1rgb)
      .moveTo("lights").setPosition(gridX(0), gridY(5)).plugTo(parent, "l1rgb");
  
  
  
   cp5.addSlider2D("light2 xy")
    .setPosition(gridX(0),gridY(8))
    .setSize(sliderW - sliderH - 6,sliderW - (sliderH*2))
    .setMinMax(0,0,width*2,height*2)
    .setValue(3000,1720)
    .setId(2)
    .moveTo("lights")
    .plugTo(parent, "light2xy")
    .getCaptionLabel().align(CENTER, CENTER);
    
  cp5.addSlider("2z")
      .setPosition(gridX(6) - 6, gridY(8))
      .setSize(sliderH, sliderW - (sliderH*2))
      .setRange(zDist + 20000, zDist)
      .setValue(light2z)
      .moveTo("lights")
      .plugTo(parent,"light2z")
      .getCaptionLabel().align(CENTER, CENTER);
      
  cp5.addSlider("ambientR")
      .setPosition(gridX(8), gridY(0))
            .setSize(sliderW, sliderH)

            .setRange(0, 255)
      .setValue(light2z)
      .moveTo("lights")
      .plugTo(parent,"ambientR")
      .getCaptionLabel().align(CENTER, CENTER);
      
  cp5.addSlider("ambientG")
      .setPosition(gridX(8), gridY(1))
      .setSize(sliderW, sliderH)
      .setRange(0, 255)
      .setValue(light2z)
      .moveTo("lights")
      .plugTo(parent,"ambientG")
      .getCaptionLabel().align(CENTER, CENTER);
      
   cp5.addSlider("ambientB")
      .setPosition(gridX(8), gridY(2))
            .setSize(sliderW, sliderH)

      .setRange(0, 255)
      .setValue(light2z)
      .moveTo("lights")
      .plugTo(parent,"ambientB")
      .getCaptionLabel().align(CENTER, CENTER);
      
   ColorPicker l2p = new ColorPicker(cp5, "l2rgb", sliderW, sliderH * 2 + 20, 100, l2rgb)
      .moveTo("lights").setPosition(gridX(0), gridY(13)).plugTo(parent, "l2rgb");
}
