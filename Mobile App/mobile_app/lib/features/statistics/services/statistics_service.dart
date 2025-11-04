// File: mobile_app/lib/features/statistics/services/statistics_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Giả sử chúng ta biết ID của người dùng và cây
  // Trong ứng dụng thật, bạn sẽ lấy chúng từ PlantProvider hoặc AuthProvider
  final String _mockPlantId = "plant_123";

  /// Lấy ngày bắt đầu dựa trên khoảng thời gian
  DateTime _getStartDate(DateTime now, String period) {
    switch (period) {
      case 'month':
        return DateTime(now.year, now.month - 1, now.day);
      case 'year':
        return DateTime(now.year - 1, now.month, now.day);
      case 'week':
      default:
        return now.subtract(const Duration(days: 7));
    }
  }

  /// [Task 2.1] Lấy dữ liệu lịch sử từ Firestore
  /// [Task 2.2] Tính toán metrics tóm tắt
  Future<Map<String, int>> getSummaryData({required String period}) async {
    final now = DateTime.now();
    final startDate = _getStartDate(now, period);

    try {
      // Query để lấy tất cả nhật ký trong khoảng thời gian
      final querySnapshot = await _firestore
          .collection('plants')
          .doc(_mockPlantId) 
          .collection('diaries')
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {'wateringCount': 0, 'diaryCount': 0};
      }

      int wateringCount = 0;
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        // Giả sử loại hoạt động được lưu trong trường 'activityType'
        if (data.containsKey('activityType') &&
            data['activityType'] == 'watering') {
          wateringCount++;
        }
      }

      return {
        'wateringCount': wateringCount,
        'diaryCount': querySnapshot.docs.length,
      };
    } catch (e) {
      print("Lỗi khi lấy dữ liệu tóm tắt: $e");
      return {'wateringCount': 0, 'diaryCount': 0};
    }
  }

  /// [Task 2.3] Group data theo ngày (Đã làm)
  Future<Map<int, int>> getCareHistoryChartData(
      {required String period}) async {
    final now = DateTime.now();
    final startDate = _getStartDate(now, period);

    try {
      final querySnapshot = await _firestore
          .collection('plants')
          .doc(_mockPlantId) 
          .collection('diaries')
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .orderBy('timestamp')
          .get();

      // Nhóm số lượng hoạt động theo từng ngày (0=T2, 1=T3, ..., 6=CN)
      final Map<int, int> activityByDay = {};

      for (var doc in querySnapshot.docs) {
        final timestamp = (doc.data()['timestamp'] as Timestamp).toDate();
        // weekday trả về 1 cho Thứ 2, 7 cho Chủ Nhật. Ta trừ 1 để mảng bắt đầu từ 0.
        final dayIndex = timestamp.weekday - 1;
        activityByDay[dayIndex] = (activityByDay[dayIndex] ?? 0) + 1;
      }
      return activityByDay;
    } catch (e) {
      print("Lỗi khi lấy dữ liệu biểu đồ: $e");
      return {};
    }
  }

  /// [Task 2.2] Tính toán phân loại hoạt động
  Future<Map<String, double>> getActivityBreakdown(
      {required String period}) async {
    final now = DateTime.now();
    final startDate = _getStartDate(now, period);

    try {
      final querySnapshot = await _firestore
          .collection('plants')
          .doc(_mockPlantId) 
          .collection('diaries')
          .where('timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {};
      }

      final Map<String, int> activityCounts = {};
      int totalActivities = querySnapshot.docs.length;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final activityType = data['activityType'] as String? ?? 'unknown';
        activityCounts[activityType] = (activityCounts[activityType] ?? 0) + 1;
      }

      final Map<String, double> activityPercentage = {};
      activityCounts.forEach((key, value) {
        activityPercentage[key] = (value / totalActivities) * 100;
      });

      return activityPercentage;
    } catch (e) {
      print("Lỗi khi lấy dữ liệu phân loại: $e");
      return {};
    }
  }
}
