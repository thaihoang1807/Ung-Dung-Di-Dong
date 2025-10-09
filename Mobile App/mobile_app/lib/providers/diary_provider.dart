import 'package:flutter/material.dart';
import '../models/diary_entry_model.dart';

class DiaryProvider with ChangeNotifier {
  List<DiaryEntryModel> _entries = [];
  bool _isLoading = false;
  String? _error;

  List<DiaryEntryModel> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load diary entries for a plant
  Future<void> loadEntries(String plantId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Implement Firestore query
      // _entries = await diaryService.getEntriesByPlantId(plantId);
      _entries = [];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add new diary entry
  Future<bool> addEntry(DiaryEntryModel entry) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement Firestore add
      // var entryId = await diaryService.addEntry(entry);
      
      _entries.insert(0, entry); // Add to beginning
      
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update diary entry
  Future<bool> updateEntry(String entryId, DiaryEntryModel entry) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement Firestore update
      
      var index = _entries.indexWhere((e) => e.id == entryId);
      if (index != -1) {
        _entries[index] = entry;
      }
      
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete diary entry
  Future<bool> deleteEntry(String entryId) async {
    try {
      _isLoading = true;
      notifyListeners();

      // TODO: Implement Firestore delete
      
      _entries.removeWhere((e) => e.id == entryId);
      
      _isLoading = false;
      notifyListeners();
      
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get entries by activity type
  List<DiaryEntryModel> getEntriesByType(String activityType) {
    return _entries.where((e) => e.activityType == activityType).toList();
  }

  // Get recent entries
  List<DiaryEntryModel> getRecentEntries(int count) {
    return _entries.take(count).toList();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

