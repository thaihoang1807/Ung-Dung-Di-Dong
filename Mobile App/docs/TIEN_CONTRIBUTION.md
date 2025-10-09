# Đóng góp của Nguyễn Anh Tiến

## Nhiệm vụ được phân công

### 3. IoT - Phần cứng, Firmware & Tích hợp App

#### 3.1. Xây dựng Module phần cứng IoT
- **Mô tả**: Lắp ráp ESP32, cảm biến, máy bơm
- **Thư mục**: `firmware/`
- **Hardware Components**:
  - ESP32 DevKit
  - Cảm biến độ ẩm đất (Capacitive Soil Moisture Sensor)
  - Cảm biến nhiệt độ (DHT11/DHT22)
  - Module Relay (cho máy bơm)
  - Máy bơm nước mini

#### 3.2. Lập trình Firmware cho ESP32
- **Thư mục**: `firmware/src/`
- **Files**:
  - `main.cpp` - Main logic
  - `sensors/soil_moisture_sensor.cpp/h`
  - `sensors/temperature_sensor.cpp/h`
  - **Chức năng**: Đọc cảm biến và gửi dữ liệu lên Firebase

#### 3.3. Nhận lệnh điều khiển từ Firebase
- **Thư mục**: `firmware/src/`
- **Files**:
  - `actuators/relay_controller.cpp/h`
  - `firebase/firebase_client.cpp/h`
  - **Chức năng**: ESP32 lắng nghe lệnh từ Firebase và điều khiển relay

#### 3.4. Trang Chi tiết cây & Hiển thị dữ liệu IoT
- **Thư mục**: `mobile_app/lib/features/iot/`
- **Screens**:
  - `plant_detail_iot_screen.dart`
- **Widgets**:
  - `sensor_chart.dart` - Biểu đồ real-time
  - `realtime_data_card.dart` - Hiển thị dữ liệu sensor

#### 3.5. Tích hợp chức năng Điều khiển tưới nước
- **Thư mục**: `mobile_app/lib/features/iot/`
- **Widgets**:
  - `watering_control_button.dart`
- **Service**:
  - `services/iot_controller_service.dart`
- **Provider**: `mobile_app/lib/providers/iot_provider.dart`

## Công việc đã hoàn thành

### Sprint 1 - Hardware
- [ ] Mua và kiểm tra linh kiện
- [ ] Lắp ráp mạch ESP32 với cảm biến
- [ ] Test cảm biến độ ẩm đất
- [ ] Test cảm biến nhiệt độ
- [ ] Lắp ráp module relay với máy bơm

### Sprint 2 - Firmware cơ bản
- [ ] Setup PlatformIO project
- [ ] Implement soil_moisture_sensor.cpp
- [ ] Implement temperature_sensor.cpp
- [ ] Test đọc dữ liệu từ cảm biến
- [ ] Serial monitor debugging

### Sprint 3 - Firebase Integration
- [ ] Config WiFi connection
- [ ] Setup Firebase ESP Client library
- [ ] Implement firebase_client.cpp
- [ ] Gửi dữ liệu sensor lên Firebase
- [ ] Test real-time data sync

### Sprint 4 - Điều khiển
- [ ] Implement relay_controller.cpp
- [ ] Lắng nghe lệnh từ Firebase
- [ ] Test điều khiển relay từ Firebase Console
- [ ] Implement auto-off timer cho máy bơm

### Sprint 5 - App Integration
- [ ] Tạo plant_detail_iot_screen.dart
- [ ] Implement real-time data display
- [ ] Tạo sensor_chart.dart với fl_chart
- [ ] Test hiển thị dữ liệu real-time

### Sprint 6 - Control Features
- [ ] Implement watering_control_button.dart
- [ ] Tạo iot_controller_service.dart
- [ ] Implement iot_provider.dart
- [ ] Test điều khiển từ app
- [ ] Final integration testing

## Hardware Schematic

```
ESP32 Pin Connections:
- GPIO 34: Soil Moisture Sensor (Analog)
- GPIO 4:  DHT22 Data Pin
- GPIO 5:  Relay Control (Digital)
- 3.3V:    Sensor VCC
- GND:     Common Ground
```

## Firmware Architecture

```cpp
// Main Loop Flow:
1. Read sensor data every 5 seconds
2. Send data to Firebase
3. Check for control commands
4. Execute relay control if commanded
5. Update status back to Firebase
```

## Firebase Database Structure (IoT)

```
iot_data/
  {plantId}/
    sensor_readings/
      {timestamp}/
        - temperature
        - soilMoisture
        - humidity
    
    control/
      - pumpState (on/off)
      - lastCommand
      - autoMode (true/false)
```

## Screenshots

_Ảnh hardware setup, mạch điện, app IoT screens_

## Demo Video

_Video demo hardware hoạt động, điều khiển từ app_

## Git Commits

_Liệt kê các commit cho firmware và app_

## Pull Requests

_Link đến các PR_

## Ghi chú

_Các vấn đề về hardware, debugging, WiFi stability, power consumption_

