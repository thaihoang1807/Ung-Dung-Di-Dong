/**
 * Soil Moisture Sensor Implementation
 */

#include "soil_moisture_sensor.h"

SoilMoistureSensor::SoilMoistureSensor() {
  pin = SOIL_MOISTURE_PIN;
  dryValue = SOIL_DRY_VALUE;
  wetValue = SOIL_WET_VALUE;
}

void SoilMoistureSensor::begin() {
  pinMode(pin, INPUT);
  Serial.println("Soil Moisture Sensor initialized");
}

int SoilMoistureSensor::readRaw() {
  return analogRead(pin);
}

float SoilMoistureSensor::readMoisture() {
  int rawValue = readRaw();
  
  // Map raw value to percentage (0-100%)
  // Note: Lower ADC value = More moisture
  float moisture = map(rawValue, dryValue, wetValue, 0, 100);
  
  // Constrain to 0-100%
  if (moisture < 0) moisture = 0;
  if (moisture > 100) moisture = 100;
  
  return moisture;
}

