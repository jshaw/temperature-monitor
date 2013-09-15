import processing.serial.*;

import javax.mail.*;

import javax.mail.internet.*;
import java.util.Properties;

Serial port;

// Variables

String temp_c = "";
String temp_f = "";
String data = "";
int index = 0;
PFont font;
int temp_num = 0;
int first_rise = 0;

void setup(){
  size (500, 400);
  font = loadFont("GothamHTF-XLight-200.vlw");
  textFont(font, 200);
  println(Serial.list()); 
  
  port = new Serial(this, Serial.list()[6], 9600);
// Alternative way to access serial data
//  port = new Serial(this, "/dev/tty.usbmodem411", 9600);
  port.bufferUntil('.');
}

void draw() {
  background(255, 255, 255);
  fill(222, 222, 222);
  text (temp_c, 60, 175);
  fill(222, 222, 222);
  text (temp_f, 60, 370);
  
  String[] list = split(temp_c, "C");
  temp_num = parseInt(list[0]);
//  if (temp_num > 30){
//    print("SHIT TOO HOT!");
//  }
  if (temp_num > 29 && temp_num < 150){
    if (first_rise == 0){
      first_rise = 1;
      print("SHIT TOO HOT!");
      sendMail(temp_num);
    }
  } else {
    if (first_rise == 1){
      first_rise = 0;
    }
  }
}

void serialEvent(Serial port){
  data = port.readStringUntil('.');
  data = data.substring(0, data.length() - 1);
  
  index = data.indexOf(',');
  temp_c = data.substring(0, index);
  
  //fetch farenheit
  temp_f = data.substring(index+ 1, data.length());
}
