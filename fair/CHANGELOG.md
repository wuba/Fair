## [4.0.0]
* Extended FunctionDomain, support FairFunction;
* Extended syntactic sugar;
* Fixed some known issues.

## [3.4.0]
* Publish Fair Provider;
* Adaptation to Flutter 3.13;
* Fixed some known issues.

## [3.3.0]
* Runtime log optimization, covering Dart/JS logs;
* Compiler log optimization, removal of redundant/error logs, and enhanced log output;
* Adaptation to Flutter 3.10;
* Fixed some known issues.

## [3.2.1]
* Fixed some issues.

## [3.2.0]
* Adjust the call sequence of dispose;
* Fix for #244 IconData making it impossible to make tree-shake-icons.
* Add js and dart code for the common FairPlugin, reuse the same interaction logic, add example comments;
* Added exception catching and log printing when calling executeFunction using the V8 engine in Android;
* Add FunctionDomain;
* Fixed some known issues.

## [3.1.0]
* Upgrade analyzer library to 5.5.0;
* Dart function to JS supports parameter passing;
* JS Object value compatibility;
* Remove kotlin dependencies from fair/android;
* Add custom parsing for IconData.
* The generation of optional positional parameters is modified to obtain pa;
* Fixed missing OptionalPositional default values
* Remove the generation time from the generation.fair. dart comment.
* Added the ignore unnecessary_import operation.
* Fixed incorrect assignment of Sugar.switchCase key and defaultValue.
* binding was changed to SplayTreeMap to increase search efficiency, especially for lists, where duplicate tags are searched for a short time.
* Exposing specialBinding so that users can override a value;
* When the provider is added to the _binding, the Settings set by the user prevail for quick modification.
* Fixed the loadCoreJs package splicing problem.
* Reduced minSdkVersion to 16;
* runApplication supports specifying the package in which the JS resides;
* Fixed error in calling context in the _reload method.

## [3.0.0]
* Fix class constructor parsing exception.
* Fair Compatible Web.
* Bindmap logic optimization.

## [2.8.1]
* Fixed：CustomScrollView reference external function builder bug.

## [2.8.0]
* Add support of Flutter SDK 3.3.0+.
* Add Sugar：Sugar.isNestedScrollViewHeaderSliversBuilder、Sugar.isButtonStyle、Sugar.isDuration、Sugar.popMenuButton、Sugar.sliverChildBuilderDelegate、Sugar.sliverGridDelegateWithFixedCrossAxisCount.
* Fixed some bugs.

## [2.7.0]
* Add support of Flutter SDK 3.0.0、3.0.1、3.0.2、3.0.3、3.0.4、3.0.5.
* Fixed some bugs.

## [2.6.1]
* Fixed some bugs.
* Fair supports loading bundle from local disk.

## [2.6.0]
* Add support of flutter 2.10.0、2.10.1、2.10.2、2.10.3.
* Support static methods parsing.
* Runtime error message optimization.
* Sugar supports parsing Model type data.

## [2.5.0]
* Add support of flutter 2.8.0、2.8.1.
* Support singleton parsing.
* Add Sugar：Sugar.colorsWithOpacity、Sugar.switchCase、Sugar.convertToString.

## [2.4.1]
* Fix FairLogger import problem.
* Upgrade Analyzer to 2.3.0.

## [2.4.0]
* FlatBuffers supports generating bin files in a null safe environment.

## [2.3.0]
* Add null-safety
* Add support of flutter 2.5.0、2.5.1、2.5.2、2.5.3

## [2.0.0]
* Bug fix of fair_version widgets
* Add support of flutter 2.0.6
* Add support of logical dynamics

## [0.3.0]
* Bug fix of fair_version widgets
* Add support of flutter 1.22.6
* Minimize package size of fair_compiler

## [0.2.0+3]
* Remove some api for v1.12.13 to avoid compile issue.

## [0.2.0+2]
* add `Sugar.mapEach` support in build method.

## [0.2.0+1]
* Support widget update through local assets and remote uri.
* Compact with flutter v1.22.4, v1.20.4, v1.17.3, v1.12.13.
* Generate bundle with build_runner.
* Add state binding for FairWidget
* Support partial refresh of FairWidget