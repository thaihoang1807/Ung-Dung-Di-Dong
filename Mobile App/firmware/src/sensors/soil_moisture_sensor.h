/**
 * Soil Moisture Sensor Driver
 * 
 * Capacitive Soil Moisture Sensor v1.2
 */

#ifndef SOIL_MOISTURE_SENSOR_H
#define SOIL_MOISTURE_SENSOR_H

#include <Arduino.h>
#include "../config/wifi_config.h"

class SoilMoistureSensor {
private:
  int pin;
  int dryValue;
  int wetValue;

public:
  SoilMoistureSensor();
  void begin();
  float readMoisture();       // Returns moisture percentage (0-100%)
  int readRaw();              // Returns raw ADC value
};

#endif

