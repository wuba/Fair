# What’s new in Fair 2.0
The Fair 2.0 version adds support for logic dynamics and the Flutter 2.0 version. The logic dynamics support includes Fair Compiler tool support for Dart2JS, and third-party plug-in (network, permission, image selection) custom extension interface support.

## Fair Compiler open sourced
The Fair Compiler tool is completely open sourced this time. The Fair tool includes Dart2DSL which generates layout DSL and Dart2JS which generates logic JS.
Since the compiler is in the flutter build command processing entry, but cannot be debugged when the command is running, the core conversion processing modules of dsrt2dsl and dsrt2js have been removed. Both of these modules can be debugged, and the input is the file path.

```
fair
├── dsrt2dsl // The tool part of dart to dsl to generate layout metadata DSL file
├── dsrt2js // The tool part of dart to dsl to generate logical JS file
└──  compiler  // flutter build automatic dynamic product generation entry
```

## Flutter 2.0.6 support

The directory name is changed from fair_version to flutter_version, and the internal is a Flutter component created when it is dynamic.

```
fair
└── flutter_version  // Flutter version compatible components
```

## Added dynamic logic processing capabilities
Fair 2.0 uses the Fair Compiler tool to extract the logical part of the Widget and convert it into a JS file, which is then sent to JSCore for processing. Android uses the V8 engine and the built-in JSCore used by iOS.
Fair 2.0 In addition to JSCore processing logic, we also added Fair syntax sugar and layout method call stack processing capabilities in the JS domain.

## Third-party plug-in extension standardization
Fair 2.0 defines the IFairPlugin standard interface and the standard process for third-party plug-in access. At the same time, a demo of network, permission and picture selection is given in the example.

```
fair
└── fair  // fair engine module
    └── example
        └── lib/src/page
                └── plugins 
                    ├── net     // Network plug-in
                    ├── permission // Permission plug-in
                    └── pick-image // Pick image plug-in
```
[Learn More](./sample_custom_plugin)