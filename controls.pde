String currentSlot = "1";
float left = 2;
float top = 20;
int sliderW = 200;
int sliderH = 26;
boolean soundReactive = false;
float ampThreshold = 0.001;
int zDist = -3600;
PGraphics canvas;
int[] bg =  {0,0,0};

float gridX(float x) {
  return left + (30*x);
}

float gridY(float y) {
  return top + (30*y);
}

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  MultiList l;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h, P2D);
  }

  public void setup() {
    cp5 = new ControlP5(this);
    
    cp5.enableShortcuts();
    cp5.getTab("default").remove();
    cp5.getTab("bubbleboy").bringToFront();
    
    cp5.setColor(cp5.THEME_GREY);
    
    cp5.getProperties().getSnapshot("guardado1");
    
    // bubbleboy tab 
    cp5.addTab("bubbleboy");
      
    bubbleboyControls(cp5, parent);  
    meshControls(cp5, parent);
    lightControls(cp5, parent);
    pointsControls(cp5, parent);
    filterControls(cp5, parent);
    mesh2Controls(cp5, parent);
    
    // global tab 
    cp5.addTab("global");
      
    // global sliders   
      
    cp5.addSlider("kinect thresh")
      .setPosition(gridX(7), gridY(19))
      .setSize(sliderW, sliderH)
      .setRange(0, 1200)
      .setValue(950)
      .moveTo("global")
      .plugTo(parent,"kthresh")
      .getCaptionLabel().align(RIGHT, CENTER);
      
      
    cp5.addToggle("bgRst")
      .setPosition(gridX(8), gridY(16))
      .setSize(sliderH, sliderH)
      .moveTo("global")
      .setValue(true)
      .plugTo(parent,"bgReset"); 
      
    cp5.addToggle("sound")
      .setPosition(gridX(7), gridY(16))
      .setSize(sliderH, sliderH)
      .moveTo("global")
      .setValue(false)
      .plugTo(parent,"soundReactive");
    
    cp5.addSlider("sound thresh")
      .setPosition(gridX(7), gridY(18))
      .setSize(sliderW, sliderH)
      .setRange(0, 0.4)
      .setValue(950)
      .moveTo("global")
      .plugTo(parent,"ampThreshold")
      .getCaptionLabel().align(RIGHT, CENTER);

      
    cp5.addSlider("zDist")
      .setPosition(gridX(0), gridY(22))
      .setSize(sliderW, sliderH)
      .setRange(-10000, 10000)
      .setValue(-5800)
      .moveTo("global")
      .plugTo(parent,"zDist")
      .getCaptionLabel().align(RIGHT, CENTER);
        
        
        
        
    
    ColorPicker bgpicker = new ColorPicker(cp5, "colorpicker1", sliderW, sliderH * 2 + 20, 100, bg)
    .moveTo("global")
    .setPosition(gridX(0), gridY(23)).plugTo(parent, "bg");
    
  }   

  void draw() {
    background(170); 
    fill(255);
    text("framerate: " + int(frameRate), 0, 830);
    
  }

  void keyPressed() {
    switch(key) {
        case('z'): preset = 1;
        cp5.getTab("bubbleboy").bringToFront();
        break;
        case('x'): preset = 3;
        cp5.getTab("mesh").bringToFront();
        break;
        case('c'): preset = 4;
        cp5.getTab("points").bringToFront();
        break;
        case('v'): preset = 5;
        cp5.getTab("mesh2").bringToFront();
        break;
        case('l'): cp5.getTab("lights").bringToFront();
        break;
        case('t'):
          if (currentKinect == kinect1) {
            currentKinect = kinect2;
          } else {
              currentKinect = kinect1;
          }
        break;
        
        case('1'):
        currentSlot="1";
        cp5.getProperties().getSnapshot("guardado1");
        break;
        case('2'):
        currentSlot="2";
        cp5.getProperties().getSnapshot("guardado2");
        break;
        case('3'):
        currentSlot="3";
        cp5.getProperties().getSnapshot("guardado3");
        break;
        case('s'):
        cp5.getProperties().setSnapshot("guardado"+currentSlot);
        break; 
       
    }
  } 
}
