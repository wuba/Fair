## Getting set up

This project is built with [grinder](https://pub.dev/packages/grinder). To install, please run:

```bash
$ dart pub global activate grinder
```

The server API is defined in terms of Protobuf, which requires the
installation of the Protobuf `protoc` compiler. Please see [Protocol
Buffers](https://developers.google.com/protocol-buffers/) for detailed
installation instructions. On macOS, you may also install with Homebrew via:

```bash
$ brew install protobuf
```

The Dart protoc plugin is also required for the above `protoc` compiler
to generate Dart code. To install, please run:

```bash
$ dart pub global activate protoc_plugin
```

## Running

Run pub get:

```
Flutter pub get
```

To run the server, run:

```bash
$ FLUTTER_VERSION="3.3.0" grind serve
```

The server will run from port 8082.
