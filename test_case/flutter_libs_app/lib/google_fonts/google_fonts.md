# Google fonts SDK兼容

## 接入方式
### 命令生成component
``` dart
fairc -k sdk -f /Users/sz/.pub-cache/hosted/pub.flutter-io.cn/google_fonts-1.1.2/lib/google_fonts.dart -o sdk -s google_fonts
```

### 将component添加到Generate中
``` dart
class SimpleGenerate extends GeneratedModule{
  @override
  Map<String, dynamic> components() {
    return Map<String, dynamic>()
      ..addAll(google_fonts_component);
  }

  @override
  Map<String, bool> mapping() {
    return Map<String, bool>();
  }

}
```

### 在widget中使用对应Google fonts
``` dart
    Text(
          widget.title,
          style: GoogleFonts.getFont("Lato"),
        )
```

### 生成json
``` 
flutter pub run build_runner build
```

