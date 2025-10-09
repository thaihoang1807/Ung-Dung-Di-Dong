/**
 * Relay Controller
 * 
 * Controls relay module for water pump
 */

#ifndef RELAY_CONTROLLER_H
#define RELAY_CONTROLLER_H

#include <Arduino.h>
#include "../config/wifi_config.h"

class RelayController {
private:
  int pin;
  bool state;
  unsigned long lastOnTime;

public:
  RelayController();
  void begin();
  void turnOn();
  void turnOff();
  bool getState();
  void checkAutoOff();    // Safety feature: auto-off after timeout
};

#endif

