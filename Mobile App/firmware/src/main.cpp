/**
 * Plant Care System - ESP32 Firmware
 * 
 * Author: Nguyễn Anh Tiến
 * Description: Reads sensor data and controls water pump via Firebase
 */

#include <Arduino.h>
#include <WiFi.h>
#include "config/wifi_config.h"
#include "sensors/soil_moisture_sensor.h"
#include "sensors/temperature_sensor.h"
#include "actuators/relay_controller.h"
#include "firebase/firebase_client.h"

// Timing variables
unsigned long lastSensorRead = 0;
unsigned long lastFirebaseSync = 0;
const unsigned long SENSOR_INTERVAL = 5000;      // 5 seconds
const unsigned long FIREBASE_INTERVAL = 5000;    // 5 seconds

// Sensor objects
SoilMoistureSensor soilSensor;
TemperatureSensor tempSensor;
RelayController pumpRelay;
FirebaseClient firebaseClient;

void setup() {
  Serial.begin(115200);
  Serial.println("\n\n=== Plant Care System - ESP32 ===");
  
  // Initialize sensors
  Serial.println("Initializing sensors...");
  soilSensor.begin();
  tempSensor.begin();
  pumpRelay.begin();
  
  // Connect to WiFi
  Serial.print("Connecting to WiFi: ");
  Serial.println(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("\nWiFi connected!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
  
  // Initialize Firebase
  Serial.println("Initializing Firebase...");
  firebaseClient.begin();
  
  Serial.println("Setup complete!\n");
}

void loop() {
  unsigned long currentTime = millis();
  
  // Read sensors periodically
  if (currentTime - lastSensorRead >= SENSOR_INTERVAL) {
    lastSensorRead = currentTime;
    
    // Read sensor values
    float soilMoisture = soilSensor.readMoisture();
    float temperature = tempSensor.readTemperature();
    float humidity = tempSensor.readHumidity();
    
    // Print to serial
    Serial.println("=== Sensor Readings ===");
    Serial.print("Soil Moisture: ");
    Serial.print(soilMoisture);
    Serial.println("%");
    Serial.print("Temperature: ");
    Serial.print(temperature);
    Serial.println("°C");
    Serial.print("Humidity: ");
    Serial.print(humidity);
    Serial.println("%");
    Serial.println();
    
    // Send to Firebase
    firebaseClient.sendSensorData(soilMoisture, temperature, humidity);
  }
  
  // Check for control commands from Firebase
  if (currentTime - lastFirebaseSync >= FIREBASE_INTERVAL) {
    lastFirebaseSync = currentTime;
    
    // Check pump state from Firebase
    bool pumpState = firebaseClient.getPumpState();
    
    if (pumpState) {
      Serial.println("Command: Turn ON pump");
      pumpRelay.turnOn();
    } else {
      Serial.println("Command: Turn OFF pump");
      pumpRelay.turnOff();
    }
  }
  
  // Small delay to prevent watchdog timer issues
  delay(100);
}

