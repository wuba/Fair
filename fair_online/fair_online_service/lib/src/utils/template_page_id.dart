import 'dart:io';

import 'package:fair_online_service/src/utils/template_page_create_util.dart';

const templateFeedback = "1";

class TemplatePageId {

  static void writeAsStringWithId(File file, String templateId, String pageName, String projectName) {
    if(templateId == templateFeedback) {
      file.writeAsStringSync(TemplatePageCreateUtil.createFeedbackTemplatePage(pageName, projectName));
    }
  }

}