PImage pic;
int spacing=10;
//maximus -460500
//Double the first range
//range0~NUM = Dark ~ bright
float[] range = {-9000000,-9000000,-6000000};
//string num equal to range num
//m_text~NUM = Dark ~ bright
String[] m_text = {"","0","1"};
boolean on = false;

import processing.video.*;

Capture video;

void setup() {  
  size(640, 480);  
  video = new Capture(this, width, height,30);
  video.start();
}

void draw() {
  //update video
  if(video.available()){
       video.read();
  }
   background(0);
   //define  each pixel
   for (int x=spacing; x<width; x+=spacing) {
   for (int y=spacing; y<height; y+=spacing) {
      color c=video.pixels[x+y*video.width];
      fill(c);
      textSize(spacing*1.5);
      textAlign(CENTER, CENTER);
      //Check range
      for(int i =0;i<range.length;i++){
        //first range
        if(i==0 && on ==false){
          if(c<range[0]){
            text("" + m_text[0], x, y);
            on = true;
          }
        }
        //last range
        if(i==(range.length-1)&&on ==false){
          text("" + m_text[range.length-1], x, y);  
          on = true;
        }
        //middle range
        if((i != (range.length-1))&&(i != 0)){
          if((c>=range[i])&&(c <range[i+1])&& (on ==false)){
          text("" + m_text[i], x, y);
          on = true;
        }
        }
        //reset boolean
        if(i == range.length-1){
          on = false;
        }
      }
    }
  }
}
