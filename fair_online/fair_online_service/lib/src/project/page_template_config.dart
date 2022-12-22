class PageTemplateConfig {
  List<Templates>? templates;

  PageTemplateConfig({this.templates});

  PageTemplateConfig.fromJson(Map<String, dynamic> json) {
    if (json['templates'] != null) {
      templates = <Templates>[];
      json['templates'].forEach((v) {
        templates!.add(Templates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (templates != null) {
      data['templates'] = templates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Templates {
  String? path;
  String? screenshot;

  Templates({this.path, this.screenshot});

  Templates.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    screenshot = json['screenshot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['screenshot'] = screenshot;
    return data;
  }
}
