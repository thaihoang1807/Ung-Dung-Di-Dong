/**
 * Firebase Client
 * 
 * Handles communication with Firebase Realtime Database
 */

#ifndef FIREBASE_CLIENT_H
#define FIREBASE_CLIENT_H

#include <Arduino.h>
// #include <FirebaseESP32.h>  // Uncomment when Firebase library is available
#include "../config/wifi_config.h"

class FirebaseClient {
private:
  // FirebaseData firebaseData;  // Uncomment when Firebase library is available
  String basePath;

public:
  FirebaseClient();
  void begin();
  bool sendSensorData(float soilMoisture, float temperature, float humidity);
  bool getPumpState();
  bool updatePumpState(bool state);
};

#endif

