# Đóng góp của Thái Dương Hoàng

## Nhiệm vụ được phân công

### 4. Thống kê & Thông báo

#### 4.1. Trang Thống kê & Báo cáo
- **Thư mục**: `mobile_app/lib/features/statistics/`
- **Screens**:
  - `statistics_screen.dart`
- **Widgets**:
  - `care_history_chart.dart` - Biểu đồ lịch sử chăm sóc
  - `statistics_card.dart` - Card hiển thị thống kê
- **Mô tả**: Xử lý, trực quan hóa dữ liệu lịch sử chăm sóc

#### 4.2. Thiết lập Firebase Cloud Messaging (FCM)
- **Thư mục**: `mobile_app/lib/features/statistics/services/`
- **Files**:
  - `fcm_service.dart`
- **Mô tả**: Cấu hình nền tảng để ứng dụng nhận thông báo đẩy
- **Platform configs**:
  - Android: `android/app/google-services.json`
  - iOS: `ios/Runner/GoogleService-Info.plist`

#### 4.3. Xây dựng Logic lắng nghe dữ liệu và kích hoạt cảnh báo
- **Files**:
  - `notification_listener_service.dart`
- **Mô tả**: Lập trình tác vụ chạy ngầm để theo dõi dữ liệu cảm biến
- **Logic**:
  - Lắng nghe thay đổi trong Firestore
  - Kiểm tra ngưỡng cảnh báo (độ ẩm thấp, nhiệt độ cao)
  - Trigger notification khi cần

#### 4.4. Tạo và Gửi nội dung thông báo
- **Files**:
  - `alert_service.dart`
- **Provider**: `mobile_app/lib/providers/notification_provider.dart`
- **Mô tả**: Tạo nội dung và gửi đến điện thoại người dùng khi có cảnh báo

## Công việc đã hoàn thành

### Sprint 1 - Statistics UI
- [ ] Thiết kế giao diện statistics_screen
- [ ] Implement care_history_chart với fl_chart
- [ ] Tạo các loại biểu đồ (line, bar, pie)
- [ ] Implement statistics_card widgets

### Sprint 2 - Data Processing
- [ ] Xử lý dữ liệu lịch sử từ Firestore
- [ ] Tính toán các metrics (tần suất tưới, growth rate)
- [ ] Group data theo ngày/tuần/tháng
- [ ] Export data feature

### Sprint 3 - FCM Setup
- [ ] Tạo Firebase project và enable FCM
- [ ] Config google-services.json cho Android
- [ ] Config GoogleService-Info.plist cho iOS
- [ ] Request notification permissions
- [ ] Implement fcm_service.dart

### Sprint 4 - Notification Listener
- [ ] Implement notification_listener_service.dart
- [ ] Setup Firestore listeners cho sensor data
- [ ] Define alert thresholds
- [ ] Implement background service
- [ ] Test background notifications

### Sprint 5 - Alert System
- [ ] Implement alert_service.dart
- [ ] Create notification templates
- [ ] Implement notification_provider.dart
- [ ] Handle notification tap actions
- [ ] In-app notification display

### Sprint 6 - Testing & Polish
- [ ] Test notifications trên Android
- [ ] Test notifications trên iOS
- [ ] Handle notification permissions
- [ ] Notification history screen
- [ ] Final integration testing

## Statistics Features

### Metrics Tracked
- Số lần tưới nước / tuần
- Lịch sử độ ẩm đất
- Lịch sử nhiệt độ
- Số lần ghi nhật ký
- Số ảnh đã chụp
- Thời gian chăm sóc trung bình

### Chart Types
- Line Chart: Xu hướng độ ẩm/nhiệt độ theo thời gian
- Bar Chart: Tần suất tưới nước theo ngày
- Pie Chart: Phân bố hoạt động chăm sóc

## Notification Types

### Alert Conditions
```dart
- Độ ẩm đất < 30% => "Cây cần tưới nước!"
- Nhiệt độ > 35°C => "Nhiệt độ quá cao!"
- Nhiệt độ < 10°C => "Nhiệt độ quá thấp!"
- Không tưới > 3 ngày => "Đã lâu chưa tưới cây"
```

### Notification Content
```
Title: "🌱 Cảnh báo từ [Tên cây]"
Body: "Độ ẩm đất hiện tại: 25%. Cây cần tưới nước!"
Action: Tap để xem chi tiết và điều khiển
```

## Firebase Functions (Optional)

_Nếu cần xử lý notification từ server-side_

```javascript
// Cloud Function để gửi notification khi sensor data thay đổi
exports.checkSensorAlert = functions.firestore
  .document('iot_data/{plantId}/sensor_readings/{timestamp}')
  .onCreate(async (snap, context) => {
    // Check thresholds và gửi FCM
  });
```

## Screenshots

_Screenshots của statistics screen, charts, notifications_

## Demo Video

_Video demo thống kê, nhận notification_

## Git Commits

_Liệt kê các commit quan trọng_

## Pull Requests

_Link đến các PR_

## Ghi chú

_Các vấn đề về notification permissions, background services, chart performance_

