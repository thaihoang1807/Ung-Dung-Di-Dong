/**
 * Temperature & Humidity Sensor Driver
 * 
 * DHT22 (AM2302) Temperature and Humidity Sensor
 */

#ifndef TEMPERATURE_SENSOR_H
#define TEMPERATURE_SENSOR_H

#include <Arduino.h>
// #include <DHT.h>  // Uncomment when DHT library is available
#include "../config/wifi_config.h"

class TemperatureSensor {
private:
  int pin;
  // DHT dht;  // Uncomment when DHT library is available

public:
  TemperatureSensor();
  void begin();
  float readTemperature();    // Returns temperature in Celsius
  float readHumidity();       // Returns humidity percentage
};

#endif

