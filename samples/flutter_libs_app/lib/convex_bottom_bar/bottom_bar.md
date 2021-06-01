# convex_bottom_bar SDK兼容

## 接入方式
### 命令生成component
``` dart
fairc -k sdk -f -k sdk -f /Users/sz/.pub-cache/hosted/pub.flutter-io.cn/convex_bottom_bar-2.7.1+2/lib/convex_bottom_bar.dart -o sdk -s bottom_bar
```

### 将component添加到Generate中
``` dart
class SimpleGenerate extends GeneratedModule{
  @override
  Map<String, dynamic> components() {
    return Map<String, dynamic>()
      ..addAll(convex_bottom_bar_component);
  }

  @override
  Map<String, bool> mapping() {
    return Map<String, bool>();
  }

}
```

### 在widget中使用对应bottom_bar
``` dart
    bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            items: [
              TabItem(icon: Icons.list),
              TabItem(icon: Icons.calendar_today),
              TabItem(icon: Icons.assessment),
            ],
          ),
```

### 生成json
``` 
flutter pub run build_runner build
```


