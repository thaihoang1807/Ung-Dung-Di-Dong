# Đóng góp của Nguyễn Hoàng Hiệp

## Nhiệm vụ được phân công

### 2. Backend & Logic App (Firebase & Database)

#### 2.1. Thiết lập Firebase & Cấu trúc Database
- **Thư mục**: `mobile_app/lib/services/firebase/`
- **Files**:
  - `firebase_service.dart` - Khởi tạo Firebase
  - `auth_service.dart` - Firebase Authentication
  - `firestore_service.dart` - Firestore Database
  - `storage_service.dart` - Firebase Storage

#### 2.2. Xử lý Logic Đăng ký, Đăng nhập, Quản lý người dùng
- **Thư mục**: `mobile_app/lib/services/firebase/`
- **Provider**: `mobile_app/lib/providers/auth_provider.dart`
- **Model**: `mobile_app/lib/models/user_model.dart`

#### 2.3. Xử lý Logic Thêm, Sửa, Xóa cho Cây trồng
- **Thư mục**: `mobile_app/lib/services/api/`
- **Files**:
  - `plant_api_service.dart`
- **Provider**: `mobile_app/lib/providers/plant_provider.dart`
- **Model**: `mobile_app/lib/models/plant_model.dart`

#### 2.4. Xử lý Logic Ghi nhật ký & Tải ảnh lên Storage
- **Provider**: `mobile_app/lib/providers/diary_provider.dart`
- **Model**: `mobile_app/lib/models/diary_entry_model.dart`
- **Service**: Image upload logic trong `storage_service.dart`

#### 2.5. Cung cấp API/ViewModel/Logic cho Frontend
- **Thư mục**: `mobile_app/lib/providers/`
- Tất cả các Provider classes
- Integration với UI screens

## Công việc đã hoàn thành

### Sprint 1
- [ ] Setup Firebase project
- [ ] Config Firebase cho Android
- [ ] Config Firebase cho iOS
- [ ] Implement firebase_service.dart

### Sprint 2
- [ ] Implement auth_service.dart
- [ ] Tạo auth_provider.dart với Provider pattern
- [ ] Tạo user_model.dart
- [ ] Xử lý login/logout logic

### Sprint 3
- [ ] Design Firestore database structure
- [ ] Implement firestore_service.dart
- [ ] Tạo plant_model.dart
- [ ] Implement CRUD operations cho Plant

### Sprint 4
- [ ] Implement storage_service.dart
- [ ] Xử lý upload/download ảnh
- [ ] Tạo diary_entry_model.dart
- [ ] Implement diary_provider.dart

### Sprint 5
- [ ] Optimize database queries
- [ ] Implement caching strategy
- [ ] Error handling
- [ ] Testing services

## Database Structure (Firestore)

```
users/
  {userId}/
    - email
    - name
    - createdAt
    
plants/
  {plantId}/
    - userId
    - name
    - species
    - plantedDate
    - imageUrl
    - createdAt
    
diary_entries/
  {entryId}/
    - plantId
    - userId
    - content
    - images[]
    - createdAt
    
sensor_data/
  {plantId}/
    - temperature
    - soilMoisture
    - timestamp
```

## API Documentation

_Document các hàm API chính đã tạo_

### AuthService
- `signIn(email, password)`
- `signUp(email, password, name)`
- `signOut()`
- `getCurrentUser()`

### PlantService
- `addPlant(plant)`
- `updatePlant(plantId, data)`
- `deletePlant(plantId)`
- `getPlants(userId)`

## Screenshots

_Screenshots của Firebase Console, Database structure_

## Git Commits

_Liệt kê các commit quan trọng_

## Pull Requests

_Link đến các PR_

## Ghi chú

_Các thách thức về backend, security rules, optimization_

