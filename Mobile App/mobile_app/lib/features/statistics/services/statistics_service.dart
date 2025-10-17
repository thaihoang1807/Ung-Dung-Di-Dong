import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart'; // Cần import để dùng FlSpot cho biểu đồ

class StatisticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// [Task] Lấy dữ liệu tóm tắt (số lần tưới, số nhật ký)
  /// [Input] plantId: ID của cây, period: 'week', 'month', 'year'
  /// [Output] Map chứa 'wateringCount' và 'diaryCount'
  Future<Map<String, int>> getSummaryData({required String plantId, required String period}) async {
    try {
      final now = DateTime.now();
      final startDate = _getStartDate(now, period);

      // Query để lấy tất cả nhật ký trong khoảng thời gian
      final querySnapshot = await _firestore
          .collection('plants')
          .doc(plantId)
          .collection('diaries')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {'wateringCount': 0, 'diaryCount': 0};
      }

      int wateringCount = 0;
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        // Giả sử loại hoạt động được lưu trong trường 'activityType'
        if (data.containsKey('activityType') && data['activityType'] == 'watering') {
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

  /// [Task] Lấy dữ liệu cho biểu đồ lịch sử chăm sóc
  /// [Input] plantId: ID của cây, period: 'week', 'month', 'year'
  /// [Output] Dữ liệu đã được xử lý để vẽ biểu đồ cột (BarChart)
  Future<Map<int, int>> getCareHistoryChartData({required String plantId, required String period}) async {
      final now = DateTime.now();
      final startDate = _getStartDate(now, period);

      final querySnapshot = await _firestore
          .collection('plants')
          .doc(plantId)
          .collection('diaries')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .orderBy('timestamp')
          .get();
      
      // Nhóm số lượng hoạt động theo từng ngày
      // Ví dụ: {0 (Thứ 2): 2 lần, 1 (Thứ 3): 5 lần, ...}
      final Map<int, int> activityByDay = {};

      for (var doc in querySnapshot.docs) {
        final timestamp = (doc.data()['timestamp'] as Timestamp).toDate();
        // weekday trả về 1 cho Thứ 2, 7 cho Chủ Nhật. Ta trừ 1 để mảng bắt đầu từ 0.
        final dayIndex = timestamp.weekday - 1; 
        activityByDay[dayIndex] = (activityByDay[dayIndex] ?? 0) + 1;
      }
      return activityByDay;
  }

  /// [Task] Lấy dữ liệu cho biểu đồ cảm biến (ví dụ: độ ẩm)
  /// [Input] plantId: ID của cây, period: 'week', 'month', 'year'
  /// [Output] Danh sách các điểm FlSpot để vẽ biểu đồ đường (LineChart)
  Future<List<FlSpot>> getSensorChartData({required String plantId, required String period}) async {
      final now = DateTime.now();
      final startDate = _getStartDate(now, period);

      // Giả sử dữ liệu cảm biến được lưu trong một subcollection riêng
      final querySnapshot = await _firestore
          .collection('iot_data')
          .doc(plantId)
          .collection('sensor_readings')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .orderBy('timestamp')
          .limit(100) // Giới hạn số điểm để biểu đồ không quá dày
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      List<FlSpot> spots = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final timestamp = (data['timestamp'] as Timestamp).toDate();
        final humidity = (data['humidity'] as num).toDouble(); // Lấy giá trị độ ẩm
        
        // Chuyển đổi thời gian thành một số để làm trục X
        // Ở đây ta dùng millisecondsSinceEpoch, có thể cần chuẩn hóa lại ở UI
        spots.add(FlSpot(timestamp.millisecondsSinceEpoch.toDouble(), humidity));
      }
      return spots;
  }


  /// [Task] Lấy dữ liệu phân loại hoạt động
  /// [Input] plantId: ID của cây, period: 'week', 'month', 'year'
  /// [Output] Map chứa tỷ lệ phần trăm của từng loại hoạt động
  Future<Map<String, double>> getActivityBreakdown({required String plantId, required String period}) async {
    try {
      final now = DateTime.now();
      final startDate = _getStartDate(now, period);

      final querySnapshot = await _firestore
          .collection('plants')
          .doc(plantId)
          .collection('diaries')
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
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
      print("Lỗi khi lấy dữ liệu phân loại hoạt động: $e");
      return {};
    }
  }

  /// Hàm tiện ích để lấy ngày bắt đầu dựa trên khoảng thời gian
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
}