/**
 * Relay Controller Implementation
 */

#include "relay_controller.h"

RelayController::RelayController() {
  pin = RELAY_PIN;
  state = false;
  lastOnTime = 0;
}

void RelayController::begin() {
  pinMode(pin, OUTPUT);
  digitalWrite(pin, LOW);  // Start with relay OFF
  Serial.println("Relay Controller initialized");
}

void RelayController::turnOn() {
  if (!state) {
    digitalWrite(pin, HIGH);
    state = true;
    lastOnTime = millis();
    Serial.println("Relay ON - Pump activated");
  }
}

void RelayController::turnOff() {
  if (state) {
    digitalWrite(pin, LOW);
    state = false;
    Serial.println("Relay OFF - Pump deactivated");
  }
}

bool RelayController::getState() {
  return state;
}

void RelayController::checkAutoOff() {
  // Safety feature: Auto turn off after PUMP_AUTO_OFF_TIMEOUT
  if (state && (millis() - lastOnTime > PUMP_AUTO_OFF_TIMEOUT)) {
    Serial.println("Auto-off triggered (safety timeout)");
    turnOff();
  }
}

