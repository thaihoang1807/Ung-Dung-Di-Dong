/**
 * Temperature & Humidity Sensor Implementation
 */

#include "temperature_sensor.h"

TemperatureSensor::TemperatureSensor() {
  pin = DHT_PIN;
  // dht = DHT(pin, DHT22);  // Uncomment when DHT library is available
}

void TemperatureSensor::begin() {
  // dht.begin();  // Uncomment when DHT library is available
  Serial.println("Temperature Sensor (DHT22) initialized");
}

float TemperatureSensor::readTemperature() {
  // TODO: Uncomment when DHT library is available
  // float temp = dht.readTemperature();
  // if (isnan(temp)) {
  //   Serial.println("Failed to read temperature!");
  //   return 0.0;
  // }
  // return temp;
  
  // Placeholder: Return simulated value
  return 25.0 + (random(-50, 50) / 10.0);
}

float TemperatureSensor::readHumidity() {
  // TODO: Uncomment when DHT library is available
  // float humidity = dht.readHumidity();
  // if (isnan(humidity)) {
  //   Serial.println("Failed to read humidity!");
  //   return 0.0;
  // }
  // return humidity;
  
  // Placeholder: Return simulated value
  return 60.0 + (random(-200, 200) / 10.0);
}

