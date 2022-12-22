import 'package:fair_online/models/abs_model.dart';

class EditorExampleModel extends AbsModel{

  /**
   * 编辑器面板是否显示，默认不显示
   */
  bool _isEditorPanelShow = false;

  get isEditorPanelShow => _isEditorPanelShow;

  set isEditorPanelShow(value) {
    _isEditorPanelShow = value;
    notifyListeners();
  }

}