Nhóm: 6 


Thành viên: 

Hoàng Chí Bằng 

Nguyễn Hoàng Hiệp 

Thái Dương Hoàng 

Nguyễn Anh Tiến 


Tên đề tài: Ứng dụng Quản lý Nhật ký Chăm sóc Cây cảnh 


Mục tiêu: Xây dựng một ứng dụng di động hoàn chỉnh giúp người dùng theo dõi và quản lý quá trình chăm sóc cây cảnh. Ứng dụng không chỉ cung cấp các chức năng ghi chép cơ bản mà còn tích hợp hệ thống IoT để giám sát, điều khiển và gửi các cảnh báo thông minh, giúp tự động hóa việc chăm sóc. 




Phân tích nhiệm vụ 

1. Giao diện chính của hệ thống (Frontend UI)

1.1. Đăng ký, Đăng nhập: Hoàng Chí Bằng 

1.2. Trang chủ (Dashboard & Danh sách cây): Hoàng Chí Bằng 

1.3. Trang Thêm / Xoá / Sửa thông tin cây: Hoàng Chí Bằng 

1.4. Trang Ghi nhật ký chăm sóc: Hoàng Chí Bằng 

1.5. Trang Thư viện ảnh của cây: Hoàng Chí Bằng 

1.6. Trang Cài đặt: Hoàng Chí Bằng 


2. Backend & Logic App (Firebase & Database) 

2.1. Thiết lập Firebase & Cấu trúc Database: Nguyễn Hoàng Hiệp (Ghi chú: Authentication, Firestore, Storage) 

2.2. Xử lý Logic Đăng ký, Đăng nhập, Quản lý người dùng: Nguyễn Hoàng Hiệp 

2.3. Xử lý Logic Thêm, Sửa, Xóa cho Cây trồng: Nguyễn Hoàng Hiệp 

2.4. Xử lý Logic Ghi nhật ký & Tải ảnh lên Storage: Nguyễn Hoàng Hiệp 

2.5. Cung cấp API/ViewModel/Logic cho Frontend: Nguyễn Hoàng Hiệp 


3. IoT - Phần cứng, Firmware & Tích hợp App

3.1. Xây dựng Module phần cứng IoT: Nguyễn Anh Tiến (Ghi chú: Lắp ráp ESP32, cảm biến, máy bơm) 

3.2. Lập trình Firmware cho ESP32: Nguyễn Anh Tiến (Ghi chú: Đọc cảm biến và gửi dữ liệu lên Firebase) 

3.3. Nhận lệnh điều khiển từ Firebase: Nguyễn Anh Tiến (Ghi chú: Lập trình để ESP32 thực thi lệnh bật/tắt máy bơm) 

3.4. Trang Chi tiết cây & Hiển thị dữ liệu IoT: Nguyễn Anh Tiến (Ghi chú: Tích hợp biểu đồ, hiển thị dữ liệu real-time) 

3.5. Tích hợp chức năng Điều khiển tưới nước: Nguyễn Anh Tiến (Ghi chú: Gắn logic điều khiển vào nút bấm) 



4. Thống kê & Thông báo

4.1. Trang Thống kê & Báo cáo: Thái Dương Hoàng (Ghi chú: Xử lý, trực quan hóa dữ liệu lịch sử chăm sóc) 

4.2. Thiết lập Firebase Cloud Messaging (FCM): Thái Dương Hoàng (Ghi chú: Cấu hình nền tảng để ứng dụng có khả năng nhận thông báo đẩy) 

4.3. Xây dựng Logic lắng nghe dữ liệu và kích hoạt cảnh báo: Thái Dương Hoàng (Ghi chú: Lập trình tác vụ chạy ngầm để theo dõi dữ liệu cảm biến) 

4.4. Tạo và Gửi nội dung thông báo: Thái Dương Hoàng (Ghi chú: Tạo nội dung và gửi đến điện thoại người dùng khi có cảnh báo) 

Công nghệ sử dụng

Ngôn ngữ: 

Ứng dụng di động: Dart 

Firmware (cho vi điều khiển): C++ (Trên nền tảng Arduino) 


Công nghệ: 


Di động: Flutter Framework, Visual Studio Code / Android Studio, Firebase SDK. 


Backend: Google Firebase (Authentication, Firestore, Cloud Storage, FCM). 


IoT: Vi điều khiển ESP32, Cảm biến độ ẩm đất, Cảm biến nhiệt độ, Module Relay. 


Quản lý code: Git & GitHub. 