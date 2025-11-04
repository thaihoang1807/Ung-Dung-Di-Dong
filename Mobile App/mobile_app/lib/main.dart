// File: main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/firebase/firebase_service.dart';
import 'providers/auth_provider.dart';
import 'providers/plant_provider.dart';
import 'providers/diary_provider.dart';
import 'providers/iot_provider.dart';
import 'providers/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();

  // Không cần khởi tạo FCM/Alert ở đây nữa

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PlantProvider()),
        ChangeNotifierProvider(create: (_) => DiaryProvider()),
        ChangeNotifierProvider(create: (_) => IotProvider()),

        // 2. Cung cấp NotificationProvider
        // Chúng ta sẽ gọi .initialize() từ bên trong app
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const PlantCareApp(),
    ),
  );
}
