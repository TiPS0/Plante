#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

#include "DHT.h"
#include "PCF8574.h"

#define FIREBASE_HOST "<FIREBASE Realtime Database Link>"
#define FIREBASE_AUTH "<Firebase Auth>"
#define WIFI_SSID "<WiFi Name>"
#define WIFI_PASSWORD "<WiFi Password>"

//  16-Channel Analog Digital Multiplexer
#define S0 D3
#define S1 D4
#define S2 D7
#define S3 D8
#define SIG A0

//   DHT11
#define DHTPIN D5
#define DHTTYPE DHT11 
DHT dht(DHTPIN, DHTTYPE);

PCF8574 m1(0x20);

void setup() {
  Initialzation();
  WiFiConnection();
}

String WiFi_Local = "";

int Alog1;
int Alog2;
int Alog3;
int Alog4;  // LDR Light Sensor

int soilmoisture1;  // Soil Moisture Percent
int soilmoisture2;
int soilmoisture3;
int lightPercent;

void loop() {
  Firebase.setString("/data/IP_Address", WiFi_Local);
  if (Firebase.failed()) {
    Serial.print("firebase failed:");
    Serial.println(Firebase.error());  

    Firebase.setString("/data/WiFi", "false");
    
    delay(1000);
    ESP.restart();
  }
  Firebase.setString("/data/WiFi", "true");

  
  bool check = Firebase.getBool("/data/process");  
  if (check) {
    for (int i = 0; i < 5; i++) {
      m1.digitalWrite(P5,HIGH);
      m1.digitalWrite(P6,HIGH);
      m1.digitalWrite(P7,HIGH);
    
      int h = dht.readHumidity();
      float t = dht.readTemperature();
      float f = dht.readTemperature(true);

      if (isnan(h) || isnan(t) || isnan(f)) {
        Serial.println("Failed to read from DHT sensor!");
        
        delay(2000);
        ESP.restart();  // return;
      } else {
        Serial.print("Humidity: "); 
        Serial.print(h);
        Serial.print(" %\t");
        Serial.print("Temperature: "); 
        Serial.print(t);
        Serial.print(" *C\t");
        Serial.print(f);
        Serial.println(" *F\t");

        Firebase.setString("/data/humidity", String(h));
        Firebase.setString("/data/celsius", String(t));
        Firebase.setString("/data/fahrenheit", String(f));

        delay(1000);
      }
    }
    Firebase.setBool("/data/process", false);
    
  } else {
      // Channel 1 (C1 pin - binary output 1,0,0,0)
    digitalWrite(S0,HIGH); digitalWrite(S1,LOW); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
    Alog1 = analogRead(SIG);
    soilmoisture1 = map(Alog1, 350, 295, 0, 100);
    if (soilmoisture1 < 0) {
      soilmoisture1 = 0;
    } else if (soilmoisture1 > 100) {
      soilmoisture1 = 100;
    }
    
    Firebase.setInt("/Analog/Level1/Alog1", Alog1);   // Serial.println(Alog1);
    Firebase.setString("/Analog/Level1/percent", String(soilmoisture1));
  
      // Channel 2 (C2 pin - binary output 0,1,0,0)
    digitalWrite(S0,LOW); digitalWrite(S1,HIGH); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
    Alog2 = analogRead(SIG);
    soilmoisture2 = map(Alog2, 365, 300, 0, 100);
    if (soilmoisture2 < 0) {
      soilmoisture2 = 0;
    } else if (soilmoisture2 > 100) {
      soilmoisture2 = 100;
    }

    Firebase.setInt("/Analog/Level2/Alog2", Alog2);   // Serial.println(Alog2);
    Firebase.setString("/Analog/Level2/percent", String(soilmoisture2));

      // Channel 3 (C3 pin - binary output 1,1,0,0)
    digitalWrite(S0,HIGH); digitalWrite(S1,HIGH); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
    Alog3 = analogRead(SIG);
    soilmoisture3 = map(Alog3, 375, 310, 0, 100);
    if (soilmoisture3 < 0) {
      soilmoisture3 = 0;
    } else if (soilmoisture3 > 100) {
      soilmoisture3 = 100;
    }
    
    Firebase.setInt("/Analog/Level3/Alog3", Alog3);   // Serial.println(Alog3);
    Firebase.setString("/Analog/Level3/percent", String(soilmoisture3));

      // Channel 4 (C4 pin - binary output 0,0,1,0)
    digitalWrite(S0,LOW); digitalWrite(S1,LOW); digitalWrite(S2,HIGH); digitalWrite(S3,LOW);
    Alog4 = analogRead(SIG);
    lightPercent = map(Alog4, 1024, 0, 0, 100);

    Firebase.setInt("/data/Light", Alog4);   // Serial.println(Alog4);
    Firebase.setString("/data/LightPercent", String(lightPercent));
  }


// Water
  String water1 = Firebase.getString("/Analog/Level1/water");
  String waterMax1 = Firebase.getString("/Analog/Level1/waterMax");

  String water2 = Firebase.getString("/Analog/Level2/water");
  String waterMax2 = Firebase.getString("/Analog/Level2/waterMax");

  String water3 = Firebase.getString("/Analog/Level3/water");
  String waterMax3 = Firebase.getString("/Analog/Level3/waterMax");
    
  if (water1 == "true" && soilmoisture1 <= waterMax1.toInt()) {
    m1.digitalWrite(P5,LOW);  // Turn On Relay
  } else {
    m1.digitalWrite(P5,HIGH);
  }

  if (water2 == "true" && soilmoisture2 <= waterMax2.toInt()) {
    m1.digitalWrite(P6,LOW);
  } else {
    m1.digitalWrite(P6,HIGH);
  }

  if (water3 == "true" && soilmoisture3 <= waterMax3.toInt()) {
    m1.digitalWrite(P7,LOW);
  } else {
    m1.digitalWrite(P7,HIGH);
  }



// Light
  String light1 = Firebase.getString("/Analog/Level1/light");
  String lightMax1 = Firebase.getString("/Analog/Level1/lightMax");
  
  String light2 = Firebase.getString("/Analog/Level2/light");
  String lightMax2 = Firebase.getString("/Analog/Level2/lightMax");
  
  String light3 = Firebase.getString("/Analog/Level3/light");
  String lightMax3 = Firebase.getString("/Analog/Level3/lightMax");
  
  if (light1 == "true" && lightPercent <= lightMax1.toInt()) {
    m1.digitalWrite(P2,LOW);
  } else {
    m1.digitalWrite(P2,HIGH);
  }

  if (light2 == "true" && lightPercent <= lightMax2.toInt()) {
    m1.digitalWrite(P1,LOW);
  } else {
    m1.digitalWrite(P1,HIGH);
  }

  if (light3 == "true" && lightPercent <= lightMax3.toInt()) {
    m1.digitalWrite(P0,LOW);
  } else {
    m1.digitalWrite(P0,HIGH);
  }



// Fans
  String fan = Firebase.getString("/data/Fans");
  if (fan == "true") {
    m1.digitalWrite(P3,LOW);
  } else {
    m1.digitalWrite(P3,HIGH);
  }


  
  delay(500);
}

/***** === === === === === === === === *****/

void Initialzation() {
  pinMode(S0,OUTPUT);
  pinMode(S1,OUTPUT);
  pinMode(S2,OUTPUT);
  pinMode(S3,OUTPUT);
  pinMode(SIG,INPUT);

  m1.begin();
      // Water
//    m1.pinMode(P8,OUTPUT);
    m1.pinMode(P7,OUTPUT);
    m1.pinMode(P6,OUTPUT);
    m1.pinMode(P5,OUTPUT);
      // Fan
    m1.pinMode(P3,OUTPUT);
      // Light
    m1.pinMode(P2,OUTPUT);
    m1.pinMode(P1,OUTPUT);
    m1.pinMode(P0,OUTPUT);
//    Set OFF
    m1.digitalWrite(P5,HIGH);
    m1.digitalWrite(P6,HIGH);
    m1.digitalWrite(P7,HIGH);
    m1.digitalWrite(P2,HIGH);
    m1.digitalWrite(P1,HIGH);
    m1.digitalWrite(P0,HIGH);
    m1.digitalWrite(P3,HIGH);
    
    dht.begin();
    
    Serial.begin(115200);
}

void WiFiConnection() {
  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);

    DefaultSetting();
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  WiFi_Local = WiFi.localIP().toString();
  WiFi.setAutoReconnect(true);
  WiFi.persistent(true);
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void DefaultSetting() {
  digitalWrite(S0,HIGH); digitalWrite(S1,LOW); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
  Alog1 = analogRead(SIG);
  soilmoisture1 = map(Alog1, 350, 295, 0, 100);
  if (soilmoisture1 < 0) {
    soilmoisture1 = 0;
  } else if (soilmoisture1 > 100) {
    soilmoisture1 = 100;
  }

  digitalWrite(S0,LOW); digitalWrite(S1,HIGH); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
  Alog2 = analogRead(SIG);
  soilmoisture2 = map(Alog2, 365, 300, 0, 100);
  if (soilmoisture2 < 0) {
    soilmoisture2 = 0;
  } else if (soilmoisture2 > 100) {
    soilmoisture2 = 100;
  }

  digitalWrite(S0,HIGH); digitalWrite(S1,HIGH); digitalWrite(S2,LOW); digitalWrite(S3,LOW);
  Alog3 = analogRead(SIG);
  soilmoisture3 = map(Alog3, 375, 310, 0, 100);
  if (soilmoisture3 < 0) {
    soilmoisture3 = 0;
  } else if (soilmoisture3 > 100) {
    soilmoisture3 = 100;
  }

  digitalWrite(S0,LOW); digitalWrite(S1,LOW); digitalWrite(S2,HIGH); digitalWrite(S3,LOW);
  Alog4 = analogRead(SIG);
  lightPercent = map(Alog4, 1024, 0, 0, 100);

  
// Water
  if (soilmoisture1 <= 60) {
    m1.digitalWrite(P5,LOW);  // Turn On Relay
  } else {
    m1.digitalWrite(P5,HIGH);
  }

  if (soilmoisture2 <= 60) {
    m1.digitalWrite(P6,LOW);
  } else {
    m1.digitalWrite(P6,HIGH);
  }

  if (soilmoisture3 <= 60) {
    m1.digitalWrite(P7,LOW);
  } else {
    m1.digitalWrite(P7,HIGH);
  }

// Light
  if (lightPercent <= 20) {
    m1.digitalWrite(P2,LOW);
  } else {
    m1.digitalWrite(P2,HIGH);
  }

  if (lightPercent <= 20) {
    m1.digitalWrite(P1,LOW);
  } else {
    m1.digitalWrite(P1,HIGH);
  }

  if (lightPercent <= 20) {
    m1.digitalWrite(P0,LOW);
  } else {
    m1.digitalWrite(P0,HIGH);
  }
}
