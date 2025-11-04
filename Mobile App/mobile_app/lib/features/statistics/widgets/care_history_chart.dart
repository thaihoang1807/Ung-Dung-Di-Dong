// File: mobile_app/lib/features/statistics/widgets/care_history_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/statistics_service.dart';

class CareHistoryChart extends StatefulWidget {
  final String period;
  const CareHistoryChart({super.key, required this.period});

  @override
  State<CareHistoryChart> createState() => _CareHistoryChartState();
}

class _CareHistoryChartState extends State<CareHistoryChart> {
  // Khởi tạo service để gọi lấy dữ liệu
  final StatisticsService _service = StatisticsService();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Dùng FutureBuilder để tự động xử lý trạng thái loading/error/data
        child: FutureBuilder<Map<int, int>>(
          // Gọi hàm lấy dữ liệu biểu đồ từ service
          future: _service.getCareHistoryChartData(
            period: widget.period,
          ),
          builder: (context, snapshot) {
            // 1. Trong lúc đang tải dữ liệu
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            // 2. Nếu có lỗi
            if (snapshot.hasError) {
              return SizedBox(
                height: 200,
                child: Center(
                    child: Text('Lỗi tải dữ liệu biểu đồ: ${snapshot.error}')),
              );
            }
            // 3. Nếu không có dữ liệu
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox(
                height: 200,
                child:
                    Center(child: Text('Không có hoạt động nào trong tuần.')),
              );
            }

            // 4. Khi đã có dữ liệu, vẽ biểu đồ
            final data = snapshot.data!;
            return SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (data.values.reduce((a, b) => a > b ? a : b) + 2)
                      .toDouble(), // Tìm giá trị cao nhất và cộng thêm 2 để có khoảng trống
                  barGroups: _createBarGroups(data),
                  titlesData: _buildTitles(),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Hàm chuyển đổi dữ liệu từ Map sang dạng mà biểu đồ hiểu được
  List<BarChartGroupData> _createBarGroups(Map<int, int> data) {
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: (data[index] ?? 0)
                  .toDouble(), // Lấy số lượng hoạt động của ngày, nếu không có thì là 0
              color: Colors.teal,
              width: 15,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              )),
        ],
      );
    });
  }

  // Hàm tạo tiêu đề cho các cột (T2, T3, ..., CN)
  FlTitlesData _buildTitles() {
    return FlTitlesData(
      show: true,
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            String text;
            switch (value.toInt()) {
              case 0:
                text = 'T2';
                break;
              case 1:
                text = 'T3';
                break;
              case 2:
                text = 'T4';
                break;
              case 3:
                text = 'T5';
                break;
              case 4:
                text = 'T6';
                break;
              case 5:
                text = 'T7';
                break;
              case 6:
                text = 'CN';
                break;
              default:
                text = '';
                break;
            }
            return SideTitleWidget(
                axisSide: meta.axisSide, child: Text(text, style: style));
          },
          reservedSize: 28,
        ),
      ),
    );
  }
}
