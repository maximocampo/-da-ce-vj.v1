float bloom1 = 0;
int bloom2 = 0;
float bloom3 = 0;
float bPass = 0;
float noise1 = 0;
float noise2 = 0;
boolean sobel = false;

void renderFilters() {
   fx.render()
    //.blur(20, 50)
    .brightPass(bPass)
    .bloom(bloom1,bloom2, bloom3)
    .noise(noise1, noise2)
    //.sobel(sobel)
    .compose();
    
    if (sobel) {
      fx.render().sobel().compose();
    }
    
    
}

void filterControls (ControlP5 cp5, PApplet parent) {
   cp5.addToggle("sobel")
      .setPosition(gridX(9), gridY(16))
      .setSize(sliderH, sliderH)
      .moveTo("global")
      .setValue(false)
      .plugTo(parent,"sobel")
      .getCaptionLabel();
  
   cp5.addSlider("bloom1")
      .setPosition(gridX(0), gridY(16))
      .setSize(sliderW, sliderH)
      .setRange(0, 1)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"bloom1")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("bloom2")
      .setPosition(gridX(0), gridY(17))
      .setSize(sliderW, sliderH)
      .setRange(0, 1000)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"bloom2")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("bloom3")
      .setPosition(gridX(0), gridY(18))
      .setSize(sliderW, sliderH)
      .setRange(0, 1000)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"bloom3")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("brightpass")
      .setPosition(gridX(0), gridY(19))
      .setSize(sliderW, sliderH)
      .setRange(0, 1)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"bPass")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("noise1")
      .setPosition(gridX(0), gridY(20))
      .setSize(sliderW, sliderH)
      .setRange(0, 1)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"noise1")
      .getCaptionLabel().align(RIGHT, CENTER);
      
    cp5.addSlider("noise2")
      .setPosition(gridX(0), gridY(21))
      .setSize(sliderW, sliderH)
      .setRange(0, 1)
      .setValue(0)
      .moveTo("global")
      .plugTo(parent,"noise2")
      .getCaptionLabel().align(RIGHT, CENTER);
      
   
}
