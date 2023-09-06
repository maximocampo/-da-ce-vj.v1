// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

 /**
   * Creating a new cp5-controller for PixelFlows colorpicker.
   */
  static class ColorPicker extends Controller<ColorPicker> {
    ControlP5 cp5;
    DwColorPicker colorpicker;
    Pointer ptr = getPointer();
    int[] rgb;
    
    int hud_sy = 16;

    ColorPicker(ControlP5 cp5, String theName, int dim_x, int dim_y, int ny, int[] rgb) {
      super(cp5, theName);

      setSize(dim_x, dim_y);
      this.cp5 = cp5;
      this.rgb = rgb;
      this.colorpicker = new DwColorPicker(cp5.papplet, 0, 0, dim_x, dim_y-hud_sy);
      this.colorpicker.setAutoDraw(false);
      this.colorpicker.setAutoMouse(false);
      createPallette(ny);
      
      setView(new ControllerView<ColorPicker>() {
        public void display(PGraphics pg, ColorPicker cp) {
          
          int dim_x = getWidth();
          int dim_y = getHeight();
          
          int    cp_col = colorpicker.getSelectedColor();
          String cp_rgb = colorpicker.getSelectedRGBasString();
          // String cp_hsb = colorpicker.getSelectedHSBasString();

          int sy = hud_sy;
          int px = 0;
          int py = colorpicker.h()+1;
          
          pg.noStroke();
          pg.fill(200, 50);
          pg.rect(px-1, py, dim_x+2, sy+1);
          pg.fill(cp_col);
          pg.rect(px, py, sy, sy);
          
          pg.fill(255);
          pg.text(cp_rgb, px + sy * 2, py+8);
//          pg.text(cp_hsb, px + sy * 2, py+8);

          colorpicker.display();
        }
      });
    }
    
    public ColorPicker createPallette(int shadesY){
      colorpicker.createPallette(shadesY);
      colorpicker.selectColorByRGB(rgb[0], rgb[1], rgb[2]);
      return this;
    }
    
    public ColorPicker createPallette(int shadesX, int shadesY){
      colorpicker.createPallette(shadesX, shadesY);
      colorpicker.selectColorByRGB(rgb[0], rgb[1], rgb[2]);
      return this;
    }

    
    boolean STATE_SELECT = false;
    public void selectColor(){
      if(STATE_SELECT){
        colorpicker.selectColorByCoords(ptr.x(), ptr.y());
        int[] selected = colorpicker.getSelectedRGBColor();
        rgb[0] = selected[0];
        rgb[1] = selected[1];
        rgb[2] = selected[2];
      }
    }

    protected void onPress() {
      STATE_SELECT = colorpicker.inside(ptr.x(), ptr.y());
      selectColor();
    }
    protected void onDrag() {
      selectColor();
    }
    protected void onRelease( ) {
      selectColor();
      STATE_SELECT = false;
    }

  }
    
