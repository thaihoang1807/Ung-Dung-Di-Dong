import 'package:flutter/material.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/plant_management/screens/add_plant_screen.dart';
import '../../features/plant_management/screens/edit_plant_screen.dart';
import '../../features/diary/screens/diary_list_screen.dart';
import '../../features/diary/screens/add_diary_screen.dart';
import '../../features/gallery/screens/gallery_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/iot/screens/plant_detail_iot_screen.dart';
import '../../features/statistics/screens/statistics_screen.dart';

class AppRoutes {
  // Auth Routes
  static const String login = '/login';
  static const String register = '/register';
  
  // Main Routes
  static const String home = '/home';
  
  // Plant Management Routes
  static const String addPlant = '/add-plant';
  static const String editPlant = '/edit-plant';
  
  // Diary Routes
  static const String diaryList = '/diary-list';
  static const String addDiary = '/add-diary';
  
  // Gallery Routes
  static const String gallery = '/gallery';
  
  // IoT Routes
  static const String plantDetailIot = '/plant-detail-iot';
  
  // Statistics Routes
  static const String statistics = '/statistics';
  
  // Settings Routes
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      
      // Home
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      // Plant Management
      case addPlant:
        return MaterialPageRoute(builder: (_) => const AddPlantScreen());
      case editPlant:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EditPlantScreen(plantId: plantId),
        );
      
      // Diary
      case diaryList:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DiaryListScreen(plantId: plantId),
        );
      case addDiary:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddDiaryScreen(plantId: plantId),
        );
      
      // Gallery
      case gallery:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => GalleryScreen(plantId: plantId),
        );
      
      // IoT
      case plantDetailIot:
        final plantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlantDetailIotScreen(plantId: plantId),
        );
      
      // Statistics
      case statistics:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
      
      // Settings
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

