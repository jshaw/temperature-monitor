#include <Wire.h>
int temp_address = 72;

void setup ()
{
  Serial.begin(9600);
  Wire.begin();
}

void loop()
{
  Wire.beginTransmission(temp_address);
  Wire.write(0);
  Wire.endTransmission();
  Wire.requestFrom(temp_address, 1);
  while(Wire.available() == 0);
  int c = Wire.read();
  
  int f = round(c * 9.0 / 5.0 + 32.0);
  
  Serial.print(c);
  Serial.print("C,");
  Serial.print(f);
  Serial.print("F.");
  
  delay(1000);

}
