//import netP5.*;
//import oscP5.*;

import codeanticode.syphon.*;

import peasy.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.sound.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.util.Collections;
import com.thomasdiewald.pixelflow.java.utils.DwColorPicker;

Amplitude amp;
AudioIn in;
 
Kinect kinect1;
Kinect kinect2;
Kinect currentKinect;

ControlFrame cf;
ControlP5 cp5;
PeasyCam cam;
PostFX fx;
SobelPass sobelPass;

float[] depthLookUp = new float[2048];

boolean bgReset = true;
int kthresh = 930;
int preset = 1;

boolean IR = false;

SyphonServer server;

//OscP5 oscP5;
//NetAddress myRemoteLocation;

PShader myShader;

void initKinect(Kinect kinect) {
    kinect.initDepth();
    kinect.initVideo();
    kinect.enableMirror(true);
    kinect.enableIR(IR);
}

int numDevices = 0;

ArrayList<Kinect> multiKinect;

PShader shader;


void setup() {
  cursor(CROSS);
  
  numDevices = Kinect.countDevices();
  println("number of Kinect v1 devices  "+numDevices);
  
  //fullScreen(P3D);
  size(700, 500, P3D);
  //size(1792,960, P3D);
  //size(1920, 1080, P3D);
  fx = new PostFX(this);
  fx.preload(BloomPass.class);
  
  cf = new ControlFrame(this,440,840,"box");
  
  multiKinect = new ArrayList<Kinect>();
  
  if (Kinect.countDevices() > 0) {
    kinect1 = new Kinect(this);
    kinect1.activateDevice(0);
    initKinect(kinect1);
  }
  delay(1000);
  if (Kinect.countDevices() > 1) {
      kinect2 = new Kinect(this);
      kinect2.activateDevice(1);
      initKinect(kinect2);
  } 
  
  currentKinect = kinect1;
   
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  cam.setWheelScale(0.1);
  
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
    
  frameRate(30);
 
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

  server = new SyphonServer(this, "Processing Syphon");
  
  shader = loadShader("fragment.glsl", "vertex.glsl");
}


void draw() {
  if (bgReset) { 
    if (soundReactive) {
      if (amp.analyze() > ampThreshold) {
        background(color(255,0,0));
      } else {
        background(bg[0], bg[1], bg[2]);
      }   
    } else {
      background(bg[0], bg[1], bg[2]); 
    }
  }

  float factor = width*0.003;
  translate(-width, -height, 0);
  renderLights();
  
  if(currentKinect != null) {
     int[] depth = currentKinect.getRawDepth();
     switch(preset) {
      case(1):
        bubbleboy(depth, factor);
      break;
      case(3):
        mesh(depth, factor);
      break;
      case(4):
        points(depth, factor);
      break;
      case(5):
       //shader(shader);
  
        // Call your tang function
       tang(depth, factor);  // Replace depthArray and factor with your actual parameters
        
        // Reset to default shader
       //resetShader();      
      break;
    }
  } else {
      println("nope");
  }

  
  
  renderFilters();  
  server.sendScreen();
}

public void controlEvent(ControlEvent event) {
   switch(event.getId()) {
     case(1):
       light1.x = event.getController().getArrayValue()[0];
       light1.y = event.getController().getArrayValue()[1];   
     break;
     case(2):
       light2.x = event.getController().getArrayValue()[0];
       light2.y = event.getController().getArrayValue()[1];   
     break; 
  }
}
