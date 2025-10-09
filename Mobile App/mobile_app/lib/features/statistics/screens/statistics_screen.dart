import 'package:flutter/material.dart';

/// Statistics Screen - Assigned to: Thái Dương Hoàng
/// Task 4.1: Trang Thống kê & Báo cáo
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedPeriod = 'week';

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
            // Period selector
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Tuần'),
                  selected: _selectedPeriod == 'week',
                  onSelected: (selected) {
                    setState(() => _selectedPeriod = 'week');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Tháng'),
                  selected: _selectedPeriod == 'month',
                  onSelected: (selected) {
                    setState(() => _selectedPeriod = 'month');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Năm'),
                  selected: _selectedPeriod == 'year',
                  onSelected: (selected) {
                    setState(() => _selectedPeriod = 'year');
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Summary cards
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.blue[100],
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '15',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Text('Lần tưới nước'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    color: Colors.green[100],
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '8',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Text('Nhật ký'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Care history chart
            const Text(
              'Lịch sử chăm sóc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text('Biểu đồ tần suất chăm sóc'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Sensor data chart
            const Text(
              'Dữ liệu cảm biến',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text('Biểu đồ nhiệt độ & độ ẩm'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Activity breakdown
            const Text(
              'Phân loại hoạt động',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.water_drop, color: Colors.blue),
                      title: const Text('Tưới nước'),
                      trailing: const Text('60%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.grass, color: Colors.green),
                      title: const Text('Bón phân'),
                      trailing: const Text('20%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.content_cut, color: Colors.orange),
                      title: const Text('Tỉa cành'),
                      trailing: const Text('10%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.visibility, color: Colors.purple),
                      title: const Text('Quan sát'),
                      trailing: const Text('10%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

