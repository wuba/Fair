## 准备工作

安装 [grinder](https://pub.dev/packages/grinder) :

```bash
$ dart pub global activate grinder
```

安装 [Protocol
Buffers](https://developers.google.com/protocol-buffers/) :

```bash
$ brew install protobuf
```

安装`protoc`:

```bash
$ dart pub global activate protoc_plugin
```

## 运行

执行`flutter pub get`:

```
flutter pub get
```

启动 Server :

```bash
$ FLUTTER_VERSION="3.3.0" grind serve
```

后端服务运行在8082端口。
