// File: mobile_app/lib/features/statistics/screens/statistics_screen.dart

import 'package:flutter/material.dart';
// Import các file thật
import '../services/statistics_service.dart';
import '../widgets/statistics_card.dart';
import '../widgets/care_history_chart.dart';

// --- KHÔNG CÒN CODE GIẢ LẬP Ở ĐÂY ---

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  // Khởi tạo SERVICE THẬT
  final StatisticsService _statisticsService = StatisticsService();
  String _selectedPeriod = 'week';

  late Future<Map<String, int>> _summaryDataFuture;
  late Future<Map<String, double>> _activityBreakdownFuture;
  // Chúng ta không cần Future cho care_history_chart
  // vì widget đó tự xử lý FutureBuilder bên trong nó.

  @override
  void initState() {
    super.initState();
    _fetchStatistics();
  }

  // Sửa lại hàm fetch (service thật không cần plantId)
  void _fetchStatistics() {
    setState(() {
      _summaryDataFuture = _statisticsService.getSummaryData(
        period: _selectedPeriod,
      );
      _activityBreakdownFuture = _statisticsService.getActivityBreakdown(
        period: _selectedPeriod,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê & Báo cáo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 24),

            _buildSummarySection(),
            const SizedBox(height: 24),

            const Text(
              'Lịch sử chăm sóc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Gọi WIDGET BIỂU ĐỒ THẬT
            CareHistoryChart(period: _selectedPeriod),
            const SizedBox(height: 24),

            const Text(
              'Phân loại hoạt động',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActivityBreakdownSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: [
        ChoiceChip(
          label: const Text('Tuần'),
          selected: _selectedPeriod == 'week',
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedPeriod = 'week');
              _fetchStatistics();
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Tháng'),
          selected: _selectedPeriod == 'month',
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedPeriod = 'month');
              _fetchStatistics();
            }
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Năm'),
          selected: _selectedPeriod == 'year',
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedPeriod = 'year');
              _fetchStatistics();
            }
          },
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return FutureBuilder<Map<String, int>>(
      future: _summaryDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 140,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Lỗi tải dữ liệu: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có dữ liệu.'));
        }

        final summaryData = snapshot.data!;
        final wateringCount = summaryData['wateringCount'] ?? 0;
        final diaryCount = summaryData['diaryCount'] ?? 0;

        return Row(
          children: [
            // Sửa tên thành StatisticsCard
            StatisticsCard(
              title: 'Lần tưới nước',
              value: wateringCount.toString(),
              icon: Icons.water_drop_outlined,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            // Sửa tên thành StatisticsCard
            StatisticsCard(
              title: 'Nhật ký',
              value: diaryCount.toString(),
              icon: Icons.book_outlined,
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  Widget _buildActivityBreakdownSection() {
    final activityDetails = {
      'Tưới nước': {'icon': Icons.water_drop, 'color': Colors.blue},
      'Bón phân': {'icon': Icons.grass, 'color': Colors.green},
      'Tỉa cành': {'icon': Icons.content_cut, 'color': Colors.orange},
      'Quan sát': {'icon': Icons.visibility, 'color': Colors.purple},
      'unknown': {'icon': Icons.help_outline, 'color': Colors.grey}, // Thêm
    };

    return FutureBuilder<Map<String, double>>(
      future: _activityBreakdownFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
              child:
                  Center(heightFactor: 3, child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Card(
              child: Center(
                  heightFactor: 3, child: Text('Lỗi: ${snapshot.error}')));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Card(
              child: Center(heightFactor: 3, child: Text('Không có dữ liệu.')));
        }

        final breakdownData = snapshot.data!;

        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: breakdownData.entries.map((entry) {
                final activityName = entry.key;
                final percentage = entry.value;
                // Sửa logic để xử lý activity 'unknown'
                final details = activityDetails[activityName] ??
                    activityDetails['unknown']!;

                return ListTile(
                  leading: Icon(details['icon'] as IconData,
                      color: details['color'] as Color),
                  title:
                      Text(activityName == 'unknown' ? 'Khác' : activityName),
                  trailing: Text('${percentage.toStringAsFixed(0)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// KHÔNG CÒN WIDGET GIỮ CHỖ Ở ĐÂY
