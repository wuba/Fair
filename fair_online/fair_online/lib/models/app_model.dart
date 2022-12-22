import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/app/themes.dart';

enum MainPage { None, FlutterEditor, ApiCall, CustomCode, CustomComponent, EditorExample, Dependency }

enum FlutterEditorLeftPanel { Page, Component }

enum FlutterEditorPage { Flutter, FairDsl }

class AppModel extends AbsModel {
  /**
   * 当前页面
   */
  MainPage get currentMainPage => _currentMainPage;
  MainPage _currentMainPage = MainPage.None;

  set currentMainPage(MainPage value) {
    _currentMainPage = value;
    notifyListeners();
  }

  /**
   * 代码编辑左边面板
   */
  FlutterEditorLeftPanel get currentFlutterEditorLeftPanel => _currentFlutterEditorLeftPanel;
  FlutterEditorLeftPanel _currentFlutterEditorLeftPanel = FlutterEditorLeftPanel.Page;

  set currentFlutterEditorLeftPanel(FlutterEditorLeftPanel value) {
    _currentFlutterEditorLeftPanel = value;
    notifyListeners();
  }

  /**
   * 代码编辑页面
   */
  FlutterEditorPage get currentFlutterEditorPage => _currentFlutterEditorPage;
  FlutterEditorPage _currentFlutterEditorPage = FlutterEditorPage.Flutter;

  set currentFlutterEditorPage(FlutterEditorPage value) {
    _currentFlutterEditorPage = value;
    notifyListeners();
  }

  /**
   * 是否初始化完成
   */
  bool get hasInitialized => _hasInitialized;
  bool _hasInitialized = false;

  set hasInitialized(bool value) {
    _hasInitialized = value;
    notifyListeners();
  }

  /// Current Theme (serialized)
  ThemeType get theme => _theme;
  ThemeType _theme = ThemeType.DARK;

  set theme(ThemeType value) {
    _theme = value;
    // scheduleSave();
    notifyListeners();
  }
}
