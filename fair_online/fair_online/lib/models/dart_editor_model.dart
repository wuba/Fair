import 'dart:async';

import 'package:fair_online/data/device_data.dart';
import 'package:fair_online/models/abs_model.dart';
import 'package:fair_online/utils/constant.dart';

class DartEditorModel extends AbsModel{

  DeviceData _currentDeviceData = COMMON_DEVICES[0];

  DeviceData get currentDeviceData => _currentDeviceData;

  set currentDeviceData(DeviceData deviceData) {
    _currentDeviceData = deviceData;
    notifyListeners();
  }

  void Function()? onEditorResumeListener;
  void setOnEditorResumeListener(void Function() callback){
    this.onEditorResumeListener = callback;
  }

  void didChangeDependencies(){
    onEditorResumeListener?.call();
  }

  /**
   * 是否显示语法分析弹窗
   */
  bool _showAnalyzeDialog = true;

  bool get showAnalyzeDialog => _showAnalyzeDialog;

  set showAnalyzeDialog(value) {
    _showAnalyzeDialog = value;
    notifyListeners();
  }

  /**
   * 编辑器面板是否显示，默认不显示
   */
  bool _isEditorPanelShow = false;

  get isEditorPanelShow => _isEditorPanelShow;

  set isEditorPanelShow(value) {
    _isEditorPanelShow = value;
    notifyListeners();
  }

  /**
   * 当前展示的页面的代码
   */
  String _currentCode = '';

  get currentCode => _currentCode;

  /**
   * 当前展示的页面名字
   */
  String _currentPagePath = '';

  get currentPagePath => _currentPagePath;

  Future<void> getCodeByPage(String pagePath) async {
    loadPageListener?.call(pagePath);
  }

  void Function(String)? loadPageListener;
  void setLoadPageListener(void Function(String) callback){
    this.loadPageListener = callback;
  }

}
