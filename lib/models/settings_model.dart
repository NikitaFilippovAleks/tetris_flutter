import 'package:flutter/material.dart';
import 'package:tetris_flutter/src/blocks/blocks.dart';

class SettingsModel extends ChangeNotifier {
  int _level = 1;
  final Set<Block> _activeBlocks = { ...allBlocksTypes };

  int get level => _level;
  Set<Block> get activeBlocks => _activeBlocks;

  void setLevel(int level) {
    _level = level;
    notifyListeners();
  }

  void addActiveBlock(Block block) {
    _activeBlocks.add(block);
    notifyListeners();
  }

  void removeActiveBlock(Block block) {
    _activeBlocks.remove(block);
    notifyListeners();
  }
}

class SettingsProvider extends InheritedNotifier<SettingsModel> {
  const SettingsProvider(
      {super.key, required super.notifier, required super.child});

  static SettingsModel of(BuildContext context) {
    final SettingsProvider? result =
        context.dependOnInheritedWidgetOfExactType<SettingsProvider>();
    assert(result != null, 'No SettingsProvider found in context');
    return result!.notifier!;
  }
}
