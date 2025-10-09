# 🌱 Ứng dụng Quản lý Chăm sóc Cây cảnh

Ứng dụng di động tích hợp IoT giúp người dùng theo dõi và quản lý quá trình chăm sóc cây cảnh với hệ thống tự động hóa thông minh.

## 👥 Thông tin nhóm

**Nhóm**: 6

**Thành viên**:
- Hoàng Chí Bằng - Frontend UI
- Nguyễn Hoàng Hiệp - Backend & Logic
- Nguyễn Anh Tiến - IoT Hardware & Firmware
- Thái Dương Hoàng - Statistics & Notifications

## 📋 Mục tiêu dự án

Xây dựng một ứng dụng di động hoàn chỉnh giúp người dùng:
- Theo dõi và quản lý thông tin cây trồng
- Ghi chép nhật ký chăm sóc hàng ngày
- Giám sát dữ liệu cảm biến real-time (nhiệt độ, độ ẩm đất)
- Điều khiển máy bơm tưới nước từ xa
- Nhận thông báo cảnh báo thông minh
- Xem thống kê và báo cáo chăm sóc

## 🏗️ Kiến trúc hệ thống

```
┌─────────────────────────────────────────────────────┐
│                  Flutter Mobile App                  │
│  (UI, Business Logic, State Management - Provider)  │
└──────────────────┬──────────────────────────────────┘
                   │
                   ↓
┌─────────────────────────────────────────────────────┐
│              Firebase Cloud Services                 │
│  • Authentication  • Firestore  • Storage  • FCM    │
└───────────────┬──────────────────────┬───────────────┘
                │                      │
                ↓                      ↓
        ┌───────────────┐      ┌──────────────┐
        │   User Data   │      │  IoT Data    │
        └───────────────┘      └──────┬───────┘
                                      │
                                      ↓
                              ┌────────────────┐
                              │  ESP32 Device  │
                              │  + Sensors     │
                              │  + Relay/Pump  │
                              └────────────────┘
```

## 📁 Cấu trúc thư mục

```
Mobile App/
├── README.md
├── SETUP_GUIDE.md
├── instruction.md
├── .gitignore
│
├── docs/
│   ├── BANG_CONTRIBUTION.md
│   ├── HIEP_CONTRIBUTION.md
│   ├── TIEN_CONTRIBUTION.md
│   └── HOANG_CONTRIBUTION.md
│
├── mobile_app/
│   ├── lib/
│   │   ├── main.dart                                      [Hiệp]
│   │   ├── app.dart                                       [Hiệp]
│   │   │
│   │   ├── core/
│   │   │   ├── constants/
│   │   │   │   └── app_constants.dart                     [Hiệp]
│   │   │   ├── theme/
│   │   │   │   ├── app_theme.dart                         [Bằng]
│   │   │   │   └── app_colors.dart                        [Bằng]
│   │   │   ├── utils/                                     [Chung]
│   │   │   └── routes/
│   │   │       └── app_routes.dart                        [Bằng + Hiệp]
│   │   │
│   │   ├── models/
│   │   │   ├── user_model.dart                            [Hiệp]
│   │   │   ├── plant_model.dart                           [Hiệp]
│   │   │   ├── diary_entry_model.dart                     [Hiệp]
│   │   │   └── sensor_data_model.dart                     [Hiệp + Tiến]
│   │   │
│   │   ├── services/
│   │   │   ├── firebase/
│   │   │   │   ├── firebase_service.dart                  [Hiệp]
│   │   │   │   ├── auth_service.dart                      [Hiệp]
│   │   │   │   ├── firestore_service.dart                 [Hiệp]
│   │   │   │   └── storage_service.dart                   [Hiệp]
│   │   │   └── api/
│   │   │       └── plant_api_service.dart                 [Hiệp]
│   │   │
│   │   ├── providers/
│   │   │   ├── auth_provider.dart                         [Hiệp]
│   │   │   ├── plant_provider.dart                        [Hiệp]
│   │   │   ├── diary_provider.dart                        [Hiệp]
│   │   │   ├── iot_provider.dart                          [Hiệp + Tiến]
│   │   │   └── notification_provider.dart                 [Hiệp + Hoàng]
│   │   │
│   │   └── features/
│   │       │
│   │       ├── auth/                                      [Bằng]
│   │       │   ├── screens/
│   │       │   │   ├── login_screen.dart                  [Bằng]
│   │       │   │   └── register_screen.dart               [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── home/                                      [Bằng]
│   │       │   ├── screens/
│   │       │   │   └── home_screen.dart                   [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── plant_management/                          [Bằng]
│   │       │   ├── screens/
│   │       │   │   ├── add_plant_screen.dart              [Bằng]
│   │       │   │   └── edit_plant_screen.dart             [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── diary/                                     [Bằng]
│   │       │   ├── screens/
│   │       │   │   ├── diary_list_screen.dart             [Bằng]
│   │       │   │   └── add_diary_screen.dart              [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── gallery/                                   [Bằng]
│   │       │   ├── screens/
│   │       │   │   └── gallery_screen.dart                [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── settings/                                  [Bằng]
│   │       │   ├── screens/
│   │       │   │   └── settings_screen.dart               [Bằng]
│   │       │   └── widgets/                               [Bằng]
│   │       │
│   │       ├── iot/                                       [Tiến]
│   │       │   ├── screens/
│   │       │   │   └── plant_detail_iot_screen.dart       [Tiến]
│   │       │   ├── widgets/                               [Tiến]
│   │       │   └── services/
│   │       │       └── iot_controller_service.dart        [Tiến]
│   │       │
│   │       └── statistics/                                [Hoàng]
│   │           ├── screens/
│   │           │   └── statistics_screen.dart             [Hoàng]
│   │           ├── widgets/                               [Hoàng]
│   │           └── services/
│   │               ├── fcm_service.dart                   [Hiệp + Hoàng]
│   │               ├── notification_listener_service.dart [Hiệp + Hoàng]
│   │               └── alert_service.dart                 [Hiệp + Hoàng]
│   │
│   ├── pubspec.yaml                                       [Hiệp]
│   ├── analysis_options.yaml
│   ├── .gitignore
│   └── assets/
│       ├── images/
│       ├── icons/
│       └── fonts/
│
└── firmware/                                              [Tiến]
    ├── README.md                                          [Tiến]
    ├── platformio.ini                                     [Tiến]
    └── src/
        ├── main.cpp                                       [Tiến]
        ├── config/
        │   ├── wifi_config.h                              [Tiến]
        │   └── wifi_config.h.example                      [Tiến]
        ├── sensors/
        │   ├── soil_moisture_sensor.h                     [Tiến]
        │   ├── soil_moisture_sensor.cpp                   [Tiến]
        │   ├── temperature_sensor.h                       [Tiến]
        │   └── temperature_sensor.cpp                     [Tiến]
        ├── actuators/
        │   ├── relay_controller.h                         [Tiến]
        │   └── relay_controller.cpp                       [Tiến]
        └── firebase/
            ├── firebase_client.h                          [Tiến]
            └── firebase_client.cpp                        [Tiến]
```


## 🔧 Công nghệ sử dụng

### Mobile App
- **Framework**: Flutter 
- **Language**: Dart
- **State Management**: Provider
- **Backend**: Firebase (Auth, Firestore, Storage, FCM)
- **Charts**: fl_chart
- **Image Picker**: image_picker

### Firmware
- **Board**: ESP32 DevKit
- **Framework**: Arduino (PlatformIO)
- **Language**: C++
- **Sensors**: 
  - Capacitive Soil Moisture Sensor
  - DHT22 (Temperature & Humidity)
- **Actuator**: Relay Module + Water Pump

## 📱 Tính năng chính

### 1. Xác thực người dùng
- Đăng ký tài khoản
- Đăng nhập/Đăng xuất
- Quản lý profile

### 2. Quản lý cây trồng
- Thêm cây mới với thông tin chi tiết
- Sửa/Xóa thông tin cây
- Upload ảnh cây trồng
- Xem danh sách cây

### 3. Nhật ký chăm sóc
- Ghi chép hoạt động (tưới nước, bón phân, tỉa cành)
- Đính kèm ảnh minh họa
- Xem lịch sử chăm sóc

### 4. Giám sát IoT
- Hiển thị dữ liệu cảm biến real-time
- Biểu đồ lịch sử nhiệt độ và độ ẩm
- Điều khiển máy bơm từ xa
- Cảnh báo khi có bất thường

### 5. Thống kê & Báo cáo
- Thống kê hoạt động chăm sóc
- Biểu đồ phân tích
- Báo cáo theo tuần/tháng/năm

### 6. Thông báo
- Push notification khi cần tưới nước
- Cảnh báo nhiệt độ/độ ẩm bất thường
- Nhắc nhở chăm sóc định kỳ

## 👨‍💻 Phân công công việc chi tiết

### Hoàng Chí Bằng - Frontend UI
**Thư mục chính**: `mobile_app/lib/features/{auth, home, plant_management, diary, gallery, settings}/`

**Nhiệm vụ**:
- Thiết kế và implement tất cả màn hình UI
- Tạo các widget component tái sử dụng
- Xử lý navigation và routing
- Integrate với Provider để hiển thị data

**Files cần làm**: ~20 screens và 30+ widgets

### Nguyễn Hoàng Hiệp - Backend & Logic
**Thư mục chính**: `mobile_app/lib/{services, providers, models}/`

**Nhiệm vụ**:
- Setup Firebase project và services
- Implement tất cả Provider classes
- Viết business logic và API services
- Tạo data models
- Xử lý authentication và data sync

**Files cần làm**: 5 providers, 10+ services, 4 models

### Nguyễn Anh Tiến - IoT
**Thư mục chính**: `firmware/` và `mobile_app/lib/features/iot/`

**Nhiệm vụ**:
- Lắp ráp hardware ESP32 + sensors
- Viết firmware đọc sensor và điều khiển relay
- Integrate Firebase với ESP32
- Tạo UI hiển thị dữ liệu IoT trong app
- Implement remote control features

**Files cần làm**: Firmware (10+ files C++), IoT screens (5 files Dart)

### Thái Dương Hoàng - Statistics & Notifications
**Thư mục chính**: `mobile_app/lib/features/statistics/`

**Nhiệm vụ**:
- Thiết kế UI statistics với charts
- Xử lý và phân tích dữ liệu
- Setup Firebase Cloud Messaging
- Implement notification system
- Tạo logic cảnh báo tự động

**Files cần làm**: Statistics screens (5 files), FCM services (3 files)

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📊 Database Schema

### Firestore Collections

```javascript
users/{userId}
  - email: string
  - name: string
  - createdAt: timestamp

plants/{plantId}
  - userId: string
  - name: string
  - species: string
  - plantedDate: timestamp
  - imageUrl: string
  
diary_entries/{entryId}
  - plantId: string
  - userId: string
  - content: string
  - activityType: string
  - imageUrls: array
  - createdAt: timestamp
  
iot_data/{plantId}
  sensor_readings/{timestamp}
    - temperature: number
    - soilMoisture: number
    - humidity: number
  control/
    - pumpState: boolean
    - lastCommand: timestamp
```

## 🔐 Security Rules

Xem file `firestore.rules` và `storage.rules` để cấu hình Firebase Security Rules.

## 🐛 Troubleshooting

### Flutter App không kết nối Firebase
- Kiểm tra file `google-services.json` hoặc `GoogleService-Info.plist`
- Chạy lại `flutterfire configure`
- Kiểm tra package name trong Firebase Console

### ESP32 không gửi được dữ liệu
- Kiểm tra WiFi credentials trong `wifi_config.h`
- Verify Firebase Database Rules cho phép write
- Kiểm tra Serial Monitor để debug

### Build lỗi
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

## 📝 License

MIT License - Dự án Ứng Dụng Di Động

---



